package com.caliven.blog.service.admin;

import com.qiniu.common.QiniuException;
import com.qiniu.http.Response;
import com.qiniu.storage.BucketManager;
import com.qiniu.storage.UploadManager;
import com.qiniu.util.Auth;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * 七牛文件管理Service
 * Created by Caliven on 2015/11/3.
 */
@Component
public class QiniuService {

    /**
     * 七牛accessKey
     */
    @Value("#{configProperties['qiniu.access.key']}")
    private String accessKey;
    /**
     * 七牛secretKey
     */
    @Value("#{configProperties['qiniu.secret.key']}")
    private String secretKey;
    /**
     * 七牛bucketName
     */
    @Value("#{configProperties['qiniu.bucket.name']}")
    private String bucketName;
    /**
     * 七牛备份bucketName
     */
    @Value("#{configProperties['qiniu.bucket.name.bak']}")
    private String bucketNameBak;
    /**
     * 七牛bucketName对应的domain下载域名
     */
    @Value("#{configProperties['qiniu.domain']}")
    private String domain;


    /**
     * 七牛上传
     *
     * @param bytes
     * @param key
     * @return 下载链接
     * @throws QiniuException
     */
    public String upload(byte[] bytes, String key) throws QiniuException {
        String token = this.getToken();
        UploadManager uploadManager = new UploadManager();
        Response res = uploadManager.put(bytes, key, token);
        if (res.isOK()) {
            // 获取私有下载 URL
            // String downloadUrl = auth.privateDownloadUrl("http://" + domain + "/" + fileName);
            return domain + "/" + key;
        }
        return null;
    }

    /**
     * 根据key删除文件(备份到qiniu.bucket.name.bak中再删除qiniu.bucket.name的文件,先备份在删除)
     *
     * @param key
     * @throws QiniuException
     */
    public void delete(String key) throws QiniuException {
        BucketManager bucketManager = this.getBucketManager();
        // 删除文件前复制一份到备份 qiniu.bucket.name.bak 中
        bucketManager.copy(bucketName, key, bucketNameBak, key);
        // 删除文件
        bucketManager.delete(bucketName, key);
    }

    /**
     * 根据key恢复文件(从qiniu.bucket.name.bak中恢复到qiniu.bucket.name中,先复制在删除)
     *
     * @param key
     * @throws QiniuException
     */
    public void recovery(String key) throws QiniuException {
        BucketManager bucketManager = this.getBucketManager();
        // 恢复文件复制一份到 qiniu.bucket.name 中
        bucketManager.copy(bucketNameBak, key, bucketName, key);
        // 删除备份文件
        bucketManager.delete(bucketNameBak, key);
    }

    /**
     * 获取七牛Auth
     *
     * @return
     */
    private Auth getAuth() {
        return Auth.create(accessKey, secretKey);
    }

    /**
     * 获取七牛的上传token值
     *
     * @return
     */
    private String getToken() {
        Auth auth = this.getAuth();
        return auth.uploadToken(bucketName);
    }

    /**
     * 获取BucketManager
     *
     * @return
     */
    private BucketManager getBucketManager() {
        return new BucketManager(this.getAuth());
    }
}
