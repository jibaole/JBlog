package com.caliven.blog.utils;

import java.util.Random;

/**
 * 工具类
 *
 * @author caliven
 * @version v1.0
 * @date 2014年7月19日
 */
public class BlogUtils {

    public static final String HASH_ALGORITHM = "SHA-1";
    public static final int HASH_INTERATIONS = 1024;
    public static final int SALT_SIZE = 8;

    /**
     * 设定安全的密码，生成随机的salt并经过1024次 sha-1 hash
     * <p/>
     * 所谓加Salt，就是加点“佐料”。其基本想法是这样的——当用户首次提供密码时（通常是注册时），
     * 由系统自动往这个密码里撒一些“佐料”，然后再散列。而当用户登录时，系统为用户提供的代码撒上同样的“佐料”，
     * 然后散列，再比较散列值，已确定密码是否正确。这里的“佐料”被称作“Salt值”，这个值是由系统随机生成的，
     * 并且只有系统知道。这样，即便两个用户使用了同一个密码，由于系统为它们生成的salt值不同，
     * 他们的散列值也是不同的。即便黑客可以通过自己的密码和自己生成的散列值来找具有特定密码的用户，
     * 但这个几率太小了（密码和salt值都得和黑客使用的一样才行）。
     *
     * @param password
     */
    public static String entryptPwd(String password) {
        byte[] salt = Digests.generateSalt(BlogUtils.SALT_SIZE);
        byte[] hashPassword = Digests.sha1(password.getBytes(), salt, BlogUtils.HASH_INTERATIONS);
        return Encodes.encodeHex(hashPassword);
    }

    /**
     * 获取Salt值
     *
     * @return
     */
    public static String entryptSalt() {
        byte[] salt = Digests.generateSalt(BlogUtils.SALT_SIZE);
        return Encodes.encodeHex(salt);
    }


    /**
     * 获取1-20的随机数
     *
     * @return
     */
    public static Integer gerRandom() {
        int min = 1;
        int max = 20;
        Random random = new Random();
        int num = random.nextInt(max) % (max - min + 1) + min;
        if (num >= 18) {
            return null;
        }
        return num;
    }

    public static void main() {

    }
}
