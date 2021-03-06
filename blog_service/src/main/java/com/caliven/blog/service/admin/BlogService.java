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
import com.caliven.blog.utils.SHA1Utils;
import com.qiniu.common.QiniuException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

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
    private BlogFileService blogFileService;
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
            blog.setBannerImgId(SHA1Utils.gerRandom());
            blog.setIsDeleted(false);
            blogMapper.insertSelective(blog);
        } else {
            //blog.setBannerImgId(SHA1Utils.gerRandom());
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
        Blog blog = blogMapper.selectById(id);
        return this.setBlogValue(blog);
    }


    /**
     * 查询有效的文章
     *
     * @param id
     * @return
     */
    public Blog findEffectiveBlogById(Integer id) {
        Blog blog = blogMapper.selectEffectiveById(id);
        return this.setBlogValue(blog);
    }

    /**
     * 查询上一篇或下一篇博文
     *
     * @param blog
     * @param type 1：上一篇、2：下一篇
     * @return
     */
    public Blog findPrevOrNextBlog(Blog blog, Integer type) {
        return blogMapper.selectPrevOrNextBlog(blog, type);
    }

    /**
     * 删除博文
     *
     * @param ids
     */
    public void delBlog(String ids) throws QiniuException {
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
                // 删除分类、标签关联
                blogRelCategoryMapper.deleteByBlogId(id);
                // 删除文件
                blogFileService.batchDeleteFileByBlogId(id);
            }
        }
    }

    /**
     * 后台查询所有博文
     *
     * @param blog
     * @param page
     * @return
     */
    public List<Blog> findsAllBlog(Blog blog, Page page) {
        page.setRct(blogMapper.selectCountByParams(blog, true));
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
        if (blog == null) {
            return null;
        }

        String categoryNames = "";
        List<CategoryTag> tagList = null;
        List<CategoryTag> categoryList = null;
        // 处理博文时间显示
        blog.setRelativeTime(RelativeDateFormat.format(blog.getCreatedDate()));
        // 查询博文分类、标签
        List<BlogRelCategory> relList = blogRelCategoryMapper.selectByBlogId(blog.getId(), null);
        if (relList != null && relList.size() > 0) {
            tagList = new ArrayList<>();
            categoryList = new ArrayList<>();
            for (BlogRelCategory rel : relList) {
                CategoryTag ct = categoryTagMapper.selectById(rel.getCategoryTagId());
                if (ct == null) {
                    continue;
                }
                if (ct.getType() == 1) {
                    categoryList.add(ct);
                    categoryNames += ct.getName() + ",";
                } else {
                    tagList.add(ct);
                }
            }
        }
        if (StringUtils.isNotBlank(categoryNames)) {
            categoryNames = categoryNames.substring(0, (categoryNames.length() - 1));
        }
        blog.setTagList(tagList);
        blog.setCategoryList(categoryList);
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
    public List<Blog> findsBlogByParams(Blog blog, Page page) {
        //获取admin账号id
        blog.setUserId(ShiroUtils.getAdminId());
        page.setRct(blogMapper.selectCountByParams(blog, false));
        List<Blog> blogList = blogMapper.selectByParams(blog, page, false);
        //List<Blog> blogList = blogMapper.selectByUserId(1, true);

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
        List<Blog> list = blogMapper.selectRecentBlog(userId);
        /*List<Blog> retList = new ArrayList<>();
        for (Blog blog : list) {
            String title = blog.getTitle();
            if (StringUtils.isNotEmpty(title)) {
                if (title.length() > 20) {
                    blog.setTitle(title.substring(0, 20) + "...");
                }
            }
            retList.add(blog);
        }
        return retList;*/
        return list;
    }


    /**
     * 通过类别id或标签id查询
     *
     * @param userId
     * @param ctId
     * @param page
     * @return
     */
    public List<Blog> findsByCategoryTagId(Integer userId, Integer ctId, Page page) {
        if (userId == null || ctId == null) {
            return null;
        }
        Blog blog = new Blog();
        blog.setUserId(userId);
        blog.setCategroyTagId(ctId);
        page.setRct(blogMapper.selectCountByParams(blog, false));
        List<Blog> blogList = blogMapper.selectByParams(blog, page, false);
        List<Blog> retList = new ArrayList<>();
        for (Blog b : blogList) {
            retList.add(this.setBlogValue(b));
        }
        return retList;
    }

    /**
     * 查询关于页面文章
     *
     * @return
     */
    public Blog findAboutBlog() {
        return blogMapper.selectAboutBlog();
    }

    /**
     * 查询留言板页面文章
     *
     * @return
     */
    public Blog findMsgboardBlog() {
        return blogMapper.selectMsgboardBlog();
    }

    /**
     * 查询归档列表
     *
     * @return
     */
    public Map<String, List<Blog>> findsArchives() {
        List<Blog> blogList = blogMapper.selectArchives();
        if (blogList == null || blogList.isEmpty()) {
            return null;
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
        Map<String, List<Blog>> archivesMap = new LinkedHashMap<>();
        for (Blog blog : blogList) {
            String yearMonth = sdf.format(blog.getCreatedDate());
            if (archivesMap.get(yearMonth) == null) {
                //没有则创建一个列表，并在列表添加一个元素
                List<Blog> tempList = new ArrayList<>();
                tempList.add(blog);
                archivesMap.put(yearMonth, tempList);
            } else {
                //有则直接加在相应的列表末尾
                archivesMap.get(yearMonth).add(blog);
            }
        }
        return archivesMap;
    }


    /**
     * 分类列表
     *
     * @return
     */
    public Map<CategoryTag, List<Blog>> findsCategory() {
        return buildCtMap(categoryTagMapper.selectCategoryByUserId(ShiroUtils.getAdminId()));
    }

    /**
     * 标签列表
     *
     * @return
     */
    public Map<CategoryTag, List<Blog>> findsTags() {
        return buildCtMap(categoryTagMapper.selectTagByUserId(ShiroUtils.getAdminId()));

    }

    /**
     * 组装map
     *
     * @param list
     * @return
     */
    private Map<CategoryTag, List<Blog>> buildCtMap(List<CategoryTag> list) {
        if (list == null || list.isEmpty()) {
            return null;
        }
        List<Blog> blogList;
        Map<CategoryTag, List<Blog>> tagsMap = new LinkedHashMap<>();
        for (CategoryTag tag : list) {
            if (tag.getBlogNum() <= 0) {
                continue;
            }
            blogList = blogMapper.selectByTagId(tag.getId());
            if (blogList == null || blogList.isEmpty()) {
                continue;
            }
            tagsMap.put(tag, blogList);
        }
        return tagsMap;
    }
}
