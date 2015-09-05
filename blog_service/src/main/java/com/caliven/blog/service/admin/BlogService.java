package com.caliven.blog.service.admin;

import com.caliven.blog.db.entity.Blog;
import com.caliven.blog.db.entity.BlogRelCategory;
import com.caliven.blog.db.entity.CategoryTag;
import com.caliven.blog.db.repository.BlogMapper;
import com.caliven.blog.db.repository.BlogRelCategoryMapper;
import com.caliven.blog.db.repository.CategoryTagMapper;
import com.caliven.blog.db.vo.CategoryVo;
import com.caliven.blog.service.shiro.ShiroUtils;
import com.caliven.blog.utils.Page;
import com.caliven.blog.utils.RelativeDateFormat;
import com.github.pagehelper.PageHelper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 博客管理Service
 * Created by Caliven on 2015/6/28.
 */
@Component
@Transactional
public class BlogService {

    @Autowired
    private BlogMapper blogMapper;
    @Autowired
    private CategoryTagMapper categoryTagMapper;
    @Autowired
    private BlogRelCategoryMapper blogRelCategoryMapper;

    public int saveBlog(Blog blog, String ctIds) throws ParseException {
        Timestamp time = new Timestamp(System.currentTimeMillis());
        if (StringUtils.isBlank(blog.getPublishTime())) {
            blog.setCreatedDate(new Date());
        } else {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm");
            blog.setCreatedDate(sdf.parse(blog.getPublishTime()));
        }
        if (blog.getAllowComment() == null || !blog.getAllowComment()) {
            blog.setAllowComment(false);
        }
        if (blog.getAllowQuote() == null || !blog.getAllowQuote()) {
            blog.setAllowQuote(false);
        }
        blog.setUpdatedDate(time);
        blog.setUserId(ShiroUtils.getCurrUserId());
        if (blog.getId() == null) {
            blog.setType(1);
            blog.setIsDeleted(false);
            blogMapper.insertSelective(blog);
        } else {
            blogMapper.updateByIdSelective(blog);
        }


        Integer blogId = blog.getId();
        blogRelCategoryMapper.deleteByBlogId(blog.getId());
        String[] ids = ctIds.split(",");
        BlogRelCategory rel = null;
        for (int i = 0; i < ids.length; i++) {
            String sid = ids[i];
            if (StringUtils.isBlank(sid) || "null".equals(sid)) {
                continue;
            }
            Integer id = Integer.valueOf(sid);
            rel = new BlogRelCategory();
            rel.setBlogId(blogId);
            rel.setCategoryTagId(id);
            blogRelCategoryMapper.insertSelective(rel);
        }

        return blogId;
    }

    public Blog findBlogById(Integer id) {
        return blogMapper.selectById(id);
    }

    public void delBlog(String ids) {
        String[] bIds = ids.split(",");
        for (int i = 0; i < bIds.length; i++) {
            if (StringUtils.isBlank(bIds[i])) {
                continue;
            }
            Integer id = Integer.valueOf(bIds[i]);
            Blog blog = blogMapper.selectById(id);
            if (blog != null) {
                blog.setIsDeleted(true);
                blogMapper.updateByIdSelective(blog);
            }
        }
    }

    public List<Blog> findsBlogByUserAndPage(Integer userId, Page page) {
        List<Blog> blogList = new ArrayList<Blog>();
        Blog blog = new Blog();
        blog.setUserId(ShiroUtils.getCurrUserId());
        PageHelper.startPage(page.getPageNum(), page.getPageSize());
        List<Blog> list = blogMapper.selectBlog(blog);

        List<BlogRelCategory> cateList = null;
        List<CategoryVo> voList = null;
        for (Blog b : list) {
            voList = new ArrayList<CategoryVo>();
            cateList = blogRelCategoryMapper.selectByBlogId(b.getId(), 1);
            if (cateList != null && cateList.size() > 0) {
                for (BlogRelCategory cate : cateList) {
                    CategoryTag ct = categoryTagMapper.selectById(cate.getCategoryTagId());
                    if (ct == null) {
                        continue;
                    }
                    CategoryVo vo = new CategoryVo();
                    vo.setCategoryId(cate.getId());
                    vo.setCategoryName(ct.getName());
                    voList.add(vo);
                }
            }
            b.setCategorys(voList);
            blogList.add(b);
        }
        return blogList;
    }

    /**
     * 获取所有博客
     *
     * @param blog
     * @param page
     * @return
     */
    public List<Blog> findsBlogByPage(Blog blog, Page page) {
        List<Blog> blogList = new ArrayList<Blog>();
        blog.setUserId(ShiroUtils.getCurrUserId());
        PageHelper.startPage(page.getPageNum(), page.getPageSize());
        List<Blog> list = blogMapper.selectBlog(blog);
        for (Blog b : list) {
            String categoryNames = "";
            b.setRelativeTime(RelativeDateFormat.format(b.getCreatedDate()));
            List<BlogRelCategory> cateList = blogRelCategoryMapper.selectByBlogId(b.getId(), 1);
            if (cateList != null && cateList.size() > 0) {
                for (BlogRelCategory cate : cateList) {
                    CategoryTag ct = categoryTagMapper.selectById(cate.getCategoryTagId());
                    if (ct == null) {
                        continue;
                    }
                    CategoryVo vo = new CategoryVo();
                    vo.setCategoryId(cate.getId());
                    categoryNames += ct.getName()+",";
                }
            }
            if(StringUtils.isNotBlank(categoryNames)){
                categoryNames = categoryNames.substring(0, (categoryNames.length()-1));
            }
            b.setCategoryNames(categoryNames);
            blogList.add(b);
        }
        return blogList;
    }

    /**
     * 查询未审核的文章数量
     * @return
     */
    public int findNoAuditBlogCount() {
        return blogMapper.selectNoAuditBlogCount();
    }

    /**
     * 通过用户ID查询博客总数
     *
     * @param userId 用户ID
     * @return 博客总数
     */
    public int findBlogCountByUserId(Integer userId) {
        if (userId == null) {
            return 0;
        }
        return blogMapper.selectBlogCountByUserId(userId);
    }

    /**
     * 查询某个用户的所有博客
     *
     * @param userId 用户ID
     * @return 博客列表
     */
    public List<Blog> findsBlogByUserId(Integer userId) {
        if (userId == null) {
            return null;
        }
        return blogMapper.selectBlogByUserId(userId, 1);
    }


    public List<Blog> findsRecentBlogByUserId(Integer userId) {
        if (userId == null) {
            return null;
        }
        return blogMapper.selectRecentBlogByUserId(userId);
    }


}
