package com.caliven.blog.service.admin;

import com.caliven.blog.db.entity.BlogFile;
import com.caliven.blog.db.repository.BlogFileMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.List;

/**
 * 附件管理Service
 * Created by Caliven on 2015/7/1.
 */
@Service
@Transactional
public class BlogFileService {

    @Autowired
    private BlogFileMapper blogFileMapper;

    public List<BlogFile> findFileByBlogId(String blogId) {
        if (blogId == null) {
            return null;
        }
        return blogFileMapper.selectByEntityId(blogId);
    }

    public BlogFile findBlogFile(Integer id) {
        if (id == null) {
            return null;
        }
        return blogFileMapper.selectById(id);
    }

    public int saveFile(BlogFile file) {
        Timestamp time = new Timestamp(System.currentTimeMillis());
        file.setIsDeleted(false);
        file.setCreatedDate(time);
        file.setUpdatedDate(time);
        blogFileMapper.insertSelective(file);
        return file.getId();
    }

    public void updateBlogId(String oldBlogId, String newBlogId) {
        blogFileMapper.updateBlogId(oldBlogId, newBlogId);
    }

    public void delFile(Integer id) {
        BlogFile file = blogFileMapper.selectById(id);
        if (file != null) {
            file.setIsDeleted(true);
            file.setUpdatedDate(new Timestamp(System.currentTimeMillis()));
            blogFileMapper.updateByIdSelective(file);
        }
    }
}
