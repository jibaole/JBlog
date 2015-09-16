package com.caliven.blog.admin;

import com.caliven.blog.db.entity.*;
import com.caliven.blog.service.admin.*;
import com.caliven.blog.service.shiro.ShiroUtils;
import com.caliven.blog.utils.Page;
import com.caliven.blog.utils.RelativeDateFormat;
import com.github.pagehelper.PageInfo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by Caliven on 2015/6/30.
 */
@Controller
@RequestMapping("/admin/article")
public class ArticleController {

    @Autowired
    private UserService userService;
    @Autowired
    private BlogService blogService;
    @Autowired
    private BlogFileService blogFileService;
    @Autowired
    private CategoryTagService categoryTagService;
    @Autowired
    private BlogRelCategoryService blogRelCategoryService;

    @ModelAttribute
    private void initNavbar(Model model) {
        model.addAttribute("navbar", 3);
    }

    @RequestMapping(value = "list", method = {RequestMethod.GET, RequestMethod.POST})
    public String list(Model model, Blog blog, Page page) {
        searchBlog(model, blog, page);
        return "admin/article/article-list";
    }

    /**
     * 未审核的文章
     *
     * @param model
     * @param page
     * @return
     */
    @RequestMapping(value = "audits", method = RequestMethod.GET)
    public String audits(Model model, Page page) {
        Blog blog = new Blog();
        blog.setStatus(0);
        searchBlog(model, blog, page);
        return "admin/article/article-list";
    }

    private void searchBlog(Model model, Blog blog, Page page) {
        List<CategoryTag> treeList = categoryTagService.findsAllCategory();
        List<Blog> list = blogService.findsBlogByPage(blog, page);
        PageInfo pageInfo = new PageInfo(list);
        BeanUtils.copyProperties(pageInfo, page);
        model.addAttribute("blogs", list);
        model.addAttribute("page", page);
        model.addAttribute("blog", blog);
        model.addAttribute("treeList", treeList);
    }

    @RequestMapping(value = "edit", method = RequestMethod.GET)
    public String edit(Model model, Integer id) {
        List<CategoryTag> alltagList = categoryTagService.findsTag();
        List<CategoryTag> cateList = categoryTagService.findsAllCategoryNoRoot();
        if (id != null) {
            Blog blog = blogService.findBlogById(id);
            User user = userService.findUserById(blog.getUserId());
            String cateIds = blogRelCategoryService.findsCateIdByBlogId(id);
            String relativeTime = RelativeDateFormat.format(blog.getUpdatedDate());
            List<CategoryTag> tagList = blogRelCategoryService.findsTagByBlogId(id);
            List<BlogFile> files = blogFileService.findFileByBlogId(String.valueOf(id));
            if (tagList != null && tagList.size() > 0) {
                StringBuffer idsb = new StringBuffer();
                StringBuffer namesb = new StringBuffer();
                for (CategoryTag tag : tagList) {
                    idsb.append(tag.getId() + ",");
                    namesb.append("<span class='label label-info'>" + tag.getName() + "</span> ");
                }
                String tagIds = idsb.toString();
                String tagNames = namesb.toString();
                tagIds = tagIds.substring(0, tagIds.length() - 1);
                model.addAttribute("tagIds", tagIds);
                model.addAttribute("tagNames", tagNames);
            }
            model.addAttribute("relativeTime", relativeTime);
            model.addAttribute("cateIds", cateIds);
            model.addAttribute("files", files);
            model.addAttribute("blog", blog);
            model.addAttribute("user", user);
        } else {
            String tmpBlogId = System.currentTimeMillis() + "_" + ShiroUtils.getCurrUserId();
            model.addAttribute("tmpBlogId", tmpBlogId);
        }
        model.addAttribute("tagList", alltagList);
        model.addAttribute("cateList", cateList);
        model.addAttribute("navbar", 2);
        return "admin/article/article-edit";
    }

    @RequestMapping(value = "save", method = RequestMethod.POST)
    public String save(RedirectAttributesModelMap modelMap,
                       Blog blog, String cateIds,
                       String tagIds, String tmpBlogId) {
        try {
            int blogId = blogService.saveBlog(blog, cateIds + "," + tagIds);
            if (StringUtils.isNotBlank(tmpBlogId)) {
                blogFileService.updateBlogId(tmpBlogId, String.valueOf(blogId));
            }
            return "redirect:/admin/article/list";
        } catch (Exception e) {
            e.printStackTrace();
            modelMap.addFlashAttribute("error", e.getMessage());
            modelMap.addFlashAttribute("tmpBlogId", tmpBlogId);
            List<BlogFile> files = blogFileService.findFileByBlogId(tmpBlogId);
            modelMap.addFlashAttribute("files", files);
            return "redirect:/admin/article/edit?id=" + blog.getId();
        }
    }

    @ResponseBody
    @RequestMapping(value = "autosave", method = RequestMethod.POST)
    public Object autosave(Blog blog, String cateIds, String tagIds, String tmpBlogId) {
        Integer id = null;
        String json = "{\"status\":true";
        try {
            id = blogService.saveBlog(blog, cateIds + "," + tagIds);
            if (StringUtils.isNotBlank(tmpBlogId)) {
                blogFileService.updateBlogId(tmpBlogId, String.valueOf(id));
            }
        } catch (Exception e) {
            json = "{\"status\":false";
        }
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss aaa");
        json += ",\"id\":" + id + ",\"date\":\"" + sdf.format(new Date()) + "\"}";
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "del", method = RequestMethod.GET)
    public Object del(String ids) {
        try {
            blogService.delBlog(ids);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

}
