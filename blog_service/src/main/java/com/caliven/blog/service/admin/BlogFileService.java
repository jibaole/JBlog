package com.caliven.blog.service.admin;

import com.caliven.blog.db.entity.BlogFile;
import com.caliven.blog.db.repository.BlogFileMapper;
import com.caliven.blog.service.shiro.ShiroUtils;
import com.caliven.blog.utils.Page;
import com.caliven.blog.utils.StrUtils;
import com.qiniu.common.QiniuException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.List;

/**
 * 文件管理Service
 * Created by Caliven on 2015/7/1.
 */
@Service
@Transactional
public class BlogFileService {

    @Autowired
    private QiniuService qiniuService;
    @Autowired
    private BlogFileMapper blogFileMapper;

    /**
     * 查询某个用户所有文件
     *
     * @param file
     * @param page
     * @return
     */
    public List<BlogFile> findsAll(BlogFile file, Page page) {
        // 默认查未删除附件
        if (file.getIsDeleted() == null) {
            file.setIsDeleted(false);
        }
        file.setUserId(ShiroUtils.getCurrUserId());
        page.setRct(blogFileMapper.selectCountByParams(file));
        return blogFileMapper.selectByParams(file, page);
    }

    /**
     * 查询某篇文章文件
     *
     * @param blogId
     * @return
     */
    public List<BlogFile> findFileByBlogId(String blogId) {
        if (blogId == null) {
            return null;
        }
        return blogFileMapper.selectByEntityId(blogId);
    }

    /**
     * 查询文件信息
     *
     * @param id
     * @return
     */
    public BlogFile findBlogFile(Integer id) {
        if (id == null) {
            return null;
        }
        return blogFileMapper.selectById(id);
    }

    /**
     * 保存文件
     *
     * @param file
     * @return
     */
    public int saveFile(BlogFile file) {
        Timestamp time = new Timestamp(System.currentTimeMillis());
        file.setIsDeleted(false);
        file.setCreatedDate(time);
        file.setUpdatedDate(time);
        blogFileMapper.insertSelective(file);
        return file.getId();
    }

    /**
     * 修改文件文章id
     *
     * @param oldBlogId
     * @param newBlogId
     */
    public void updateBlogId(String oldBlogId, String newBlogId) {
        blogFileMapper.updateBlogId(oldBlogId, newBlogId);
    }


    /**
     * 批量删除文章下的文件
     *
     * @param blogId
     */
    public void batchDeleteFileByBlogId(Integer blogId) throws QiniuException {
        if (blogId == null) {
            return;
        }
        List<BlogFile> list = this.findFileByBlogId(String.valueOf(blogId));
        if (list == null && list.size() <= 0) {
            return;
        }
        String ids = "";
        for (int i = 0; i < list.size(); i++) {
            ids += list.get(i).getId() + ",";
        }
        if (StringUtils.isNotBlank(ids)) {
            ids = ids.substring(0, (ids.length() - 1));
        }
        this.batchDeleteFile(ids);
    }

    /**
     * 批量删除文件(同时删除七牛文件)
     *
     * @param ids
     */
    public void batchDeleteFile(String ids) throws QiniuException {
        this.batchDeleteOrRecoveryFile(ids, true);
    }

    /**
     * 单个删除(同时删除七牛文件)
     *
     * @param id
     */
    public void deleteFile(Integer id) throws QiniuException {
        this.deleteOrRecoveryFile(id, true);
    }

    /**
     * 批量恢复文件(同时恢复七牛文件)
     *
     * @param ids
     */
    public void batchRecoveryFile(String ids) throws QiniuException {
        this.batchDeleteOrRecoveryFile(ids, false);
    }

    /**
     * 恢复单个文件(同时恢复七牛文件)
     *
     * @param id
     */
    public void recoveryFile(Integer id) throws QiniuException {
        this.deleteOrRecoveryFile(id, false);
    }

    /**
     * 批量删除或恢复
     *
     * @param ids
     * @param isDeleted
     */
    private void batchDeleteOrRecoveryFile(String ids, boolean isDeleted) throws QiniuException {
        Integer[] arry = StrUtils.stringToInteger(ids);
        if (arry == null) {
            return;
        }
        if (isDeleted) {
            blogFileMapper.batchDeleteFile(arry);
        } else {
            blogFileMapper.batchRecoveryFile(arry);
        }
        for (Integer id : arry) {
            BlogFile file = blogFileMapper.selectById(id);
            if (file != null && StringUtils.isNotBlank(file.getFileName())) {
                if (isDeleted) {
                    // 删除七牛上的文件
                    qiniuService.delete(file.getFileName());
                } else {
                    // 恢复七牛上的文件
                    qiniuService.recovery(file.getFileName());
                }
            }
        }
    }

    /**
     * 单个删除或恢复
     *
     * @param id
     * @param isDeleted
     */
    private void deleteOrRecoveryFile(Integer id, boolean isDeleted) throws QiniuException {
        BlogFile file = blogFileMapper.selectById(id);
        if (file != null && StringUtils.isNotBlank(file.getFileName())) {

            //删除或恢复数据库文件
            file.setIsDeleted(isDeleted);
            file.setUpdatedDate(new Timestamp(System.currentTimeMillis()));
            blogFileMapper.updateByIdSelective(file);

            if (isDeleted) {
                // 删除七牛上的文件
                qiniuService.delete(file.getFileName());
            } else {
                // 恢复七牛上的文件
                qiniuService.recovery(file.getFileName());
            }
        }
    }
}
