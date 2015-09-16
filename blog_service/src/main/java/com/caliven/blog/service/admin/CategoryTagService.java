package com.caliven.blog.service.admin;

import com.caliven.blog.db.entity.CategoryTag;
import com.caliven.blog.db.repository.BlogRelCategoryMapper;
import com.caliven.blog.db.repository.CategoryTagMapper;
import com.caliven.blog.service.shiro.ShiroUtils;
import com.caliven.blog.utils.Page;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * 分类、标签管理Service
 * Created by Caliven on 2015/7/1.
 */
@Service
@Transactional
public class CategoryTagService {

    @Autowired
    private CategoryTagMapper categoryTagMapper;
    @Autowired
    private BlogRelCategoryMapper blogRelCategoryMapper;

    /**
     * 保存分类
     *
     * @param category
     */
    public void saveCategory(CategoryTag category) {
        Timestamp time = new Timestamp(System.currentTimeMillis());
        Integer parentId = category.getParentId();
        category.setType(1); // type == 1 分类标示
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

    /**
     * 查询分类或标签
     *
     * @param id
     * @return
     */
    public CategoryTag findCategoryTagById(Integer id) {
        return categoryTagMapper.selectById(id);
    }

    /**
     * 检测分类、标签名称是否存在
     *
     * @param type
     * @param name
     * @param id
     * @return
     */
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

    /**
     * 检测分类、标签缩略名否存在
     *
     * @param type
     * @param slug
     * @param id
     * @return
     */
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

    /**
     * 删除分类
     *
     * @param ids
     */
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

    /**
     * 通过父节点 id批量删除分类
     *
     * @param parentId
     */
    private void batchDelCategory(Integer parentId) {
        List<CategoryTag> list = this.findsTreeCategroyByParentId(null, parentId);
        for (CategoryTag categroy : list) {
            categoryTagMapper.deleteById(categroy.getId());
            blogRelCategoryMapper.deleteByCategoryTagId(categroy.getId());
        }
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
     * @param page
     * @return
     */
    public List<CategoryTag> findsCategory(CategoryTag ct, Page page) {
        Integer userId = ShiroUtils.getCurrUserId();
        if (ct.getParentId() == null) {
            CategoryTag root = categoryTagMapper.selectRootCategory(userId);
            if (root != null) {
                ct.setParentId(root.getId());
            }
        }
        ct.setUserId(userId);
        ct.setType(1); //type=1:类别
        List<CategoryTag> list = categoryTagMapper.selectCategoryByParams(ct, page);
        return list;
    }

    /**
     * 查询某个用户的所有分类
     *
     * @param userId
     * @return
     */
    public List<CategoryTag> findsAllCategoryByUserId(Integer userId) {
        List<CategoryTag> treeList = null;
        CategoryTag rootCate = this.findRootCategoryByUserId(userId);
        if (rootCate == null) {
            // 初始化根节点类别
            CategoryTag root = new CategoryTag();
            root.setName("不选择");
            root.setParentId(0);
            root.setLevel(0);
            root.setType(1);
            this.saveCategory(root);
            rootCate = this.findRootCategoryByUserId(userId);
        }
        if (rootCate != null) {
            Integer rootId = rootCate.getId();
            treeList = this.findsTreeCategroyByParentId(userId, rootId);
        }
        return treeList;
    }

    /**
     * 查询某用户下所有非树节点的分类
     *
     * @param userId
     * @return
     */
    public List<CategoryTag> findsAllCategoryNoRoot(Integer userId) {
        List<CategoryTag> treeList = this.findsAllCategoryByUserId(userId);
        for (CategoryTag c : treeList) {
            if (0 == c.getParentId()) {
                treeList.remove(c);
                break;
            }
        }
        return treeList;
    }

    /**
     * 查询某个用户的分类根节点
     *
     * @param userId
     * @return
     */
    public CategoryTag findRootCategoryByUserId(Integer userId) {
        return categoryTagMapper.selectRootCategory(userId);
    }

    /**
     * 循环迭代查询用户下类别树结构
     *
     * @param userId
     * @param parentId
     * @return
     */
    public List<CategoryTag> findsTreeCategroyByParentId(Integer userId, Integer parentId) {
        List<CategoryTag> rtnList = new ArrayList<>();
        CategoryTag cate = categoryTagMapper.selectById(parentId);
        if (cate != null) {
            rtnList.add(cate);
            List<CategoryTag> list = categoryTagMapper.selectTreeCategory(userId, parentId);
            if (list != null && list.size() > 0) {
                for (CategoryTag categroy : list) {
                    Integer pId = categroy.getId();
                    rtnList.addAll(findsTreeCategroyByParentId(userId, pId));
                }
            }
        }
        return rtnList;
    }

    /////////////////////////// Tag ////////////////////////////////

    /**
     * 保存标签
     *
     * @param tag
     */
    public void saveTag(CategoryTag tag) {
        tag.setType(2); // type == 2 标签标示
        Timestamp time = new Timestamp(System.currentTimeMillis());
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

    /**
     * 删除标签
     *
     * @param id
     */
    public void deleteTag(Integer id) {
        categoryTagMapper.deleteById(id);
        blogRelCategoryMapper.deleteByCategoryTagId(id);
    }

    /**
     * 通过用户ID查询标签总数
     *
     * @param userId
     * @return 标签总数
     */
    public int findTagCountByUserId(Integer userId) {
        if (ShiroUtils.isAdmin()) {
            userId = null;
        }
        return categoryTagMapper.selectTagCountByUserId(userId);
    }

    /**
     * 查询某个用户的标签
     *
     * @param userId
     * @return
     */
    public List<CategoryTag> findsTag(Integer userId) {
        return categoryTagMapper.selectTagByUserId(userId);
    }

}
