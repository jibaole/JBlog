package com.caliven.blog.service.admin;

import com.caliven.blog.db.entity.CategoryTag;
import com.caliven.blog.db.repository.BlogRelCategoryMapper;
import com.caliven.blog.db.repository.CategoryTagMapper;
import com.caliven.blog.service.shiro.ShiroUtils;
import com.caliven.blog.utils.Page2;
import com.github.pagehelper.PageHelper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * 分类、标签管理Service
 * Created by Caliven on 2015/7/1.
 */
@Component
@Transactional
public class CategoryTagService {

    @Autowired
    private CategoryTagMapper categoryTagMapper;
    @Autowired
    private BlogRelCategoryMapper blogRelCategoryMapper;

    public void saveCategory(CategoryTag category) {
        Timestamp time = new Timestamp(System.currentTimeMillis());
        Integer parentId = category.getParentId();
        category.setType(1);
        Integer level = 0;
        if (parentId != null) {
            CategoryTag parentCt = categoryTagMapper.selectById(parentId);
            if (parentCt != null) {
                level = parentCt.getLevel() + 1;
            }
        }
        category.setLevel(level);
        if (category.getId() == null) {
            Integer userId = ShiroUtils.getCurrUserId();
            category.setUserId(userId);
            category.setCreatedDate(time);
            categoryTagMapper.insertSelective(category);
        } else {
            category.setUpdatedDate(time);
            categoryTagMapper.updateByIdSelective(category);
        }
    }

    public void saveTag(CategoryTag tag) {
        Timestamp time = new Timestamp(System.currentTimeMillis());
        Integer parentId = tag.getParentId();
        tag.setType(2);
        if (tag.getId() == null) {
            Integer userId = ShiroUtils.getCurrUserId();
            tag.setUserId(userId);
            tag.setCreatedDate(time);
            categoryTagMapper.insertSelective(tag);
        } else {
            tag.setUpdatedDate(time);
            categoryTagMapper.updateByIdSelective(tag);
        }
    }

    public CategoryTag findCategoryTagById(Integer id) {
        return categoryTagMapper.selectById(id);
    }

    public boolean checkName(Integer type, String name, Integer id) {
        CategoryTag ct = new CategoryTag();
        ct.setId(id);
        ct.setType(type);
        ct.setName(name);
        ct.setUserId(ShiroUtils.getCurrUserId());
        if (categoryTagMapper.selectByCon(ct) != null) {
            return true;
        }
        return false;
    }

    public boolean checkSlug(Integer type, String slug, Integer id) {
        CategoryTag ct = new CategoryTag();
        ct.setId(id);
        ct.setType(type);
        ct.setSlug(slug);
        ct.setUserId(ShiroUtils.getCurrUserId());
        if (categoryTagMapper.selectByCon(ct) != null) {
            return true;
        }
        return false;
    }

    public void deleteCategory(String ids) {
        String[] ctIds = ids.split(",");
        for (int i = 0; i < ctIds.length; i++) {
            if (StringUtils.isBlank(ctIds[i])) {
                continue;
            }
            Integer id = Integer.valueOf(ctIds[i]);
            this.batchDelCategory(id);
        }
    }

    private void batchDelCategory(Integer parentId) {
        List<CategoryTag> list = this.findsTreeCategroyByParentId(parentId);
        for (CategoryTag categroy : list) {
            categoryTagMapper.deleteById(categroy.getId());
            blogRelCategoryMapper.deleteByCategoryTagId(categroy.getId());
        }
    }

    public void deleteTag(Integer id) {
        categoryTagMapper.deleteById(id);
        blogRelCategoryMapper.deleteByCategoryTagId(id);
    }

    /**
     * 通过用户ID查询分类总数(管理员查询所有)
     *
     * @return 分类总数
     */
    public int findCategoryCount() {
        Integer userId = null;
        if (!ShiroUtils.isAdmin()) {
            userId = ShiroUtils.getCurrUserId();
        }
        return categoryTagMapper.selectCategoryCountByUserId(userId);
    }

    /**
     * 查询某个用户的分类
     *
     * @param ct
     * @param page2
     * @return
     */
    public List<CategoryTag> findsCategory(CategoryTag ct, Page2 page2) {
        Integer userId = userId = ShiroUtils.getCurrUserId();
        if (ct.getParentId() == null) {
            CategoryTag root = categoryTagMapper.selectRootCategory(userId);
            if (root != null) {
                ct.setParentId(root.getId());
            }
        }
        ct.setUserId(userId);
        ct.setType(1);//type=1:类别
        PageHelper.startPage(page2.getPageNum(), page2.getPageSize());
        List<CategoryTag> list = categoryTagMapper.selectCategoryTag(ct);
        return list;
    }

    public List<CategoryTag> findsAllCategory(){
        List<CategoryTag> treeList = null;
        CategoryTag rootCate = this.findRootCategory();
        if (rootCate == null) {
            // 初始化根节点类别
            CategoryTag root = new CategoryTag();
            root.setName("不选择");
            root.setParentId(0);
            root.setLevel(0);
            root.setType(1);
            this.saveCategory(root);
            rootCate = this.findRootCategory();
        }
        if (rootCate != null) {
            Integer rootId = rootCate.getId();
            treeList = this.findsTreeCategroyByParentId(rootId);
        }
        return treeList;
    }

    public List<CategoryTag> findsAllCategoryNoRoot(){
        List<CategoryTag> treeList = this.findsAllCategory();
        for(CategoryTag c : treeList){
            if(0 == c.getParentId()){
                treeList.remove(c);
                break;
            }
        }
        return treeList;
    }

    public CategoryTag findRootCategory() {
        Integer userId = ShiroUtils.getCurrUserId();
        return categoryTagMapper.selectRootCategory(userId);
    }

    /**
     * 循环迭代查询类别树结构
     *
     * @param parentId
     * @return
     */
    public List<CategoryTag> findsTreeCategroyByParentId(Integer parentId) {
        List<CategoryTag> rtnList = new ArrayList<CategoryTag>();
        CategoryTag cate = categoryTagMapper.selectById(parentId);
        if (cate != null) {
            rtnList.add(cate);
            Integer userId = ShiroUtils.getCurrUserId();
            List<CategoryTag> list = categoryTagMapper.selectTreeCategory(userId, parentId);
            if (list != null && list.size() > 0) {
                for (CategoryTag categroy : list) {
                    Integer pId = categroy.getId();
                    rtnList.addAll(findsTreeCategroyByParentId(pId));
                }
            }
        }
        return rtnList;
    }

    /////////////////////////// Tag ////////////////////////////////

    /**
     * 通过用户ID查询标签总数
     *
     * @return 标签总数
     */
    public int findTagCount() {
        Integer userId = null;
        if (!ShiroUtils.isAdmin()) {
            userId = ShiroUtils.getCurrUserId();
        }
        return categoryTagMapper.selectTagCountByUserId(userId);
    }

    /**
     * 查询某个用户的标签
     *
     * @return
     */
    public List<CategoryTag> findsTag() {
        Integer userId = ShiroUtils.getCurrUserId();
        CategoryTag ct = new CategoryTag();
        ct.setType(2);//type=2:标签
        //ct.setUserId(userId);
        return categoryTagMapper.selectCategoryTag(ct);
    }

}
