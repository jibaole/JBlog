package com.caliven.blog.service.admin;

import com.caliven.blog.db.entity.BlogRelCategory;
import com.caliven.blog.db.entity.CategoryTag;
import com.caliven.blog.db.repository.BlogRelCategoryMapper;
import com.caliven.blog.db.repository.CategoryTagMapper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Caliven on 2015/7/11.
 */
@Component
@Transactional
public class BlogRelCategoryService {

    @Autowired
    private CategoryTagMapper categoryTagMapper;
    @Autowired
    private BlogRelCategoryMapper blogRelCategoryMapper;

    public String findsCateIdByBlogId(Integer blogId) {
        List<Integer> ids = blogRelCategoryMapper.selectCateIdByBlogId(blogId, 1);
        if(ids == null || ids.size() <= 0){
            return null;
        }
        StringBuffer sb = new StringBuffer();
        for (Integer id : ids) {
            sb.append(id+",");
        }
        String id = sb.toString();
        return id.substring(0, id.length()-1);
    }

    public List<CategoryTag> findsTagByBlogId(Integer blogId) {
        List<CategoryTag> list = new ArrayList<CategoryTag>();
        List<BlogRelCategory> relList = blogRelCategoryMapper.selectByBlogId(blogId, 2);
        for (BlogRelCategory rel : relList) {
            list.add(categoryTagMapper.selectById(rel.getCategoryTagId()));
        }
        return list;
    }

    public String findsTagIdByBlogId(Integer blogId) {
        List<Integer> ids = blogRelCategoryMapper.selectCateIdByBlogId(blogId, 2);
        if(ids == null || ids.size() <= 0){
            return null;
        }
        StringBuffer sb = new StringBuffer();
        for (Integer id : ids) {
            sb.append(id+",");
        }
        String id = sb.toString();
        return id.substring(0, id.length() - 1);
    }


}
