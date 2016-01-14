package com.caliven.blog.utils;

import org.apache.commons.lang3.StringUtils;

/**
 * 字符串工具类
 * Created by Caliven on 2015/8/4.
 */
public class StrUtils {

    /**
     * 字符串转Integer数组
     */
    public static Integer[] stringToInteger(String ids) {
        if (StringUtils.isNotBlank(ids)) {
            String[] sids = ids.split(",");
            Integer[] ints = new Integer[sids.length];
            for (int i = 0; i < sids.length; i++) {
                if(StringUtils.isNotBlank(sids[i])){
                    ints[i] = Integer.parseInt(sids[i]);
                }
            }
            return ints;
        }
        return null;
    }


    public static void main(String[] args) {
        Integer[] m = StrUtils.stringToInteger("1,1,1,1,222,");
        for (int i = 0; i < m.length; i++) {
            System.out.println(m[i]+"--");
        }
    }
}
