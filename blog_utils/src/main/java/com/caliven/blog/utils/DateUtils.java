package com.caliven.blog.utils;

import org.apache.commons.lang3.StringUtils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

/**
 * 日期工具类
 * Created by Caliven on 2015/8/4.
 */
public class DateUtils {

    /**
     * 获取最近12个月
     */
    public static String[] getLast12Months() {
        String[] last12Months = new String[12];
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.MONTH, cal.get(Calendar.MONTH) + 1); //要先+1,才能把本月的算进去
        // 数组时间由大到小，采用倒叙循环
        for (int i = 11; i >= 0; i--) {
            cal.set(Calendar.MONTH, cal.get(Calendar.MONTH) - 1); //逐次往前推1个月
            last12Months[11 - i] = DateUtils.getEnglishDate(cal.getTime());
        }
        return last12Months;
    }

    public static String getEnglishDate(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
        return sdf.format(date);
    }

    public static String getChinaDate(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("MMMM yyyy", Locale.CHINA);
        return sdf.format(date);
    }

    public static Date getEnglishDate(String date) {
        if (StringUtils.isEmpty(date)) {
            return null;
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
        try {
            return sdf.parse(date);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static Date getChinaDate(String date) {
        if (StringUtils.isEmpty(date)) {
            return null;
        }
        SimpleDateFormat sdf = new SimpleDateFormat("MMMM yyyy", Locale.CHINA);
        try {
            return sdf.parse(date);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }


    public static void main(String[] args) {
        String[] m = DateUtils.getLast12Months();
        for (int i = 0; i < m.length; i++) {
            System.out.println(m[i]);
        }
    }
}
