package com.caliven.blog.service.admin;

import com.caliven.blog.db.entity.Blog;
import com.caliven.blog.db.entity.BlogRelCategory;
import com.caliven.blog.db.entity.CategoryTag;
import com.caliven.blog.db.repository.BlogMapper;
import com.caliven.blog.db.repository.BlogRelCategoryMapper;
import com.caliven.blog.db.repository.CategoryTagMapper;
import com.caliven.blog.service.shiro.ShiroUtils;
import com.caliven.blog.utils.Page;
import com.caliven.blog.utils.RelativeDateFormat;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
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
@Service
@Transactional
public class BlogService {

    @Autowired
    private BlogMapper blogMapper;
    @Autowired
    private CategoryTagMapper categoryTagMapper;
    @Autowired
    private BlogRelCategoryMapper blogRelCategoryMapper;

    /**
     * 博文更多标示，该标示前的字符用于列表前台博文首页显示（配合后端撰写页面 markdown 空间更多按钮显示）
     */
    public static final String CONTENT_SPLIT = "<!--more-->";

    /**
     * 保存博文
     *
     * @param blog
     * @param ctIds
     * @return
     * @throws ParseException
     */
    public int saveBlog(Blog blog, String ctIds) throws ParseException {
        // 处理发布时间
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
        blog.setUpdatedDate(new Timestamp(System.currentTimeMillis()));
        blog.setUserId(ShiroUtils.getCurrUserId());
        if (blog.getId() == null) {
            blog.setType(1);
            blog.setIsDeleted(false);
            blogMapper.insertSelective(blog);
        } else {
            blogMapper.updateByIdSelective(blog);
        }

        // 开始处理分类
        BlogRelCategory rel;
        Integer blogId = blog.getId();
        blogRelCategoryMapper.deleteByBlogId(blogId);
        String[] ids = ctIds.split(",");
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

    /**
     * 查询某篇博文
     *
     * @param id
     * @return
     */
    public Blog findBlogById(Integer id) {
        return blogMapper.selectById(id);
    }

    /**
     * 删除博文
     *
     * @param ids
     */
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

    /**
     * 移除字符串中包含HTML的标签
     *
     * @param content
     * @return
     */
    public static String removeHTML(String content) {
        int before = content.indexOf('<');
        int behind = content.indexOf('>');
        if (before != -1 || behind != -1) {
            behind += 1;
            content = content.substring(0, before).trim()
                    + content.substring(behind, content.length()).trim();
            content = removeHTML(content);
        }
        content = content.replaceAll(" ", "").replaceAll("　", "");//.replaceAll("&nbsp;","");
        return content;
    }


    /**
     * 后台查询所有博文
     *
     * @param blog
     * @param page
     * @return
     */
    public List<Blog> findsAllBlog(Blog blog, Page page) {
        List<Blog> blogList = blogMapper.selectByParams(blog, page, true);
        List<Blog> retList = new ArrayList<>();
        for (Blog b : blogList) {
            retList.add(this.setBlogValue(b));
        }
        return retList;
    }

    /**
     * 设置博文特殊参数值
     *
     * @param blog
     * @return
     */
    private Blog setBlogValue(Blog blog) {
        String categoryNames = "";
        // 处理博文时间显示
        blog.setRelativeTime(RelativeDateFormat.format(blog.getCreatedDate()));
        // 查询博文分类
        List<BlogRelCategory> cateList = blogRelCategoryMapper.selectByBlogId(blog.getId(), 1);
        if (cateList != null && cateList.size() > 0) {
            for (BlogRelCategory cate : cateList) {
                CategoryTag ct = categoryTagMapper.selectById(cate.getCategoryTagId());
                if (ct == null) {
                    continue;
                }
                categoryNames += ct.getName() + ",";
            }
        }
        if (StringUtils.isNotBlank(categoryNames)) {
            categoryNames = categoryNames.substring(0, (categoryNames.length() - 1));
        }
        blog.setCategoryNames(categoryNames);
        return blog;
    }

    /**
     * 查询未审核的文章数量
     *
     * @return
     */
    public int findNoAuditBlogCount() {
        // 管理员则查询所以，无需传 userId 参数
        Integer userId = null;
        if (!ShiroUtils.isAdmin()) {
            userId = ShiroUtils.getCurrUserId();
        }
        return blogMapper.selectNoAuditCount(userId);
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
        return blogMapper.selectCountByUserId(userId);
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
        return blogMapper.selectByUserId(userId, true);
    }


    /***********************前台查询***********************/

    /**
     * 前台查询博文，默认查询 admin 账号下的博文
     *
     * @param blog
     * @param page
     * @return
     */
    public List<Blog> findsBlogByPage(Blog blog, Page page) {
        //获取admin账号id
        blog.setUserId(ShiroUtils.getAdminId());
//        List<Blog> blogList = blogMapper.selectByParams(blog, page, false);
        List<Blog> blogList = blogMapper.selectByUserId(1, true);

        List<Blog> retList = new ArrayList<>();
        for (Blog b : blogList) {
            // 处理博文内容，只截取"<!--more-->"标签前的字符显示
            String content = b.getContent();
            if (StringUtils.isNotBlank(content)) {
                String[] content2 = content.split(CONTENT_SPLIT);
                b.setContent(content2[0]);
            }
            retList.add(this.setBlogValue(b));
        }
        return retList;
    }

    /**
     * 前台查询最近博文列表
     *
     * @param userId
     * @return
     */
    public List<Blog> findsRecentBlog(Integer userId) {
        return blogMapper.selectRecentBlog(userId);
    }


}
