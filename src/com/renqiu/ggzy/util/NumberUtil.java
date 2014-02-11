package com.renqiu.ggzy.util;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.HashMap;


public class NumberUtil {
    /**
     * 四舍五入
     *
     * @param anumber
     * @param place
     * @return
     */
    public static double round(double anumber, int place) {
        String sValue = String.valueOf(anumber);
        BigDecimal bigValue = new BigDecimal(sValue);
        return bigValue.setScale(place, BigDecimal.ROUND_HALF_UP).doubleValue();
    }

    /**
     * 五舍六入
     *
     * @param anumber
     * @param pattern
     * @return
     * @throws NumberFormatException
     */
    public static double round1(double anumber, String pattern)
            throws NumberFormatException {
        String sValue;
        NumberFormat nf = new DecimalFormat(pattern);
        sValue = nf.format(anumber);
        return Double.parseDouble(sValue);
    }
    private static java.util.Map<String, String> SmallToBigMap = new HashMap<String, String>();
    static {
        SmallToBigMap.put("0", "零");
        SmallToBigMap.put("1", "一");
        SmallToBigMap.put("2", "二");
        SmallToBigMap.put("3", "三");
        SmallToBigMap.put("4", "四");
        SmallToBigMap.put("5", "五");
        SmallToBigMap.put("6", "六");
        SmallToBigMap.put("7", "七");
        SmallToBigMap.put("8", "八");
        SmallToBigMap.put("9", "九");
        SmallToBigMap.put("10", "十");
        SmallToBigMap.put("100", "百");
        SmallToBigMap.put("1000", "千");
        SmallToBigMap.put("10000", "万");
        SmallToBigMap.put("100000000", "亿");
    }

    public static String format(String num) {
        // 先将末尾的零去掉
        String numString = String.valueOf(num).replaceAll(".[0]+$", "");
        // 分别获取整数部分和小数部分的数字
        String intValue;
        String decValue = "";
        if (numString.indexOf(".") != -1) {
            intValue = String.valueOf(num).split("\\.")[0];
            decValue = String.valueOf(num).split("\\.")[1];
        }
        else {
            intValue = String.valueOf(num);
        }
        // 翻译整数部分。
        intValue = formatInteger(Integer.parseInt(String.valueOf(intValue)));
        // 翻译小数部分
        decValue = formatDecnum(decValue);
        String resultString = intValue;
        if (!decValue.equals(""))
            resultString = resultString + "点" + decValue;
        return resultString;
    }

    /**
     * 将阿拉伯整数数字翻译为汉语小写数字。 其核心思想是按照中文的读法，从后往前每四个数字为一组。每一组最后要加上对应的单位，分别为万、亿等。
     * 每一组中从后往前每个数字后面加上对应的单位，分别为个十百千。 每一组中如果出现零千、零百、零十的情况下去掉单位。
     * 每组中若出现多个连续的零，则通读为一个零。 若每一组中若零位于开始或结尾的位置，则不读。
     *
     * @param num
     * @return
     */
    public static String formatInteger(int num) {
        int unit = 10000;
        int perUnit = 10000;
        String sb = new String();
        String unitHeadString = "";
        while (num > 0) {
            int temp = num % perUnit;
            sb = formatIntegerLess10000(temp) + sb;
            // 判断是否以单位表示为字符串首位，如果是，则去掉，替换为零
            if (!unitHeadString.equals(""))
                sb = sb.replaceAll("^" + unitHeadString, "零");
            num = num / perUnit;
            if (num > 0) {
                // 如果大于当前单位，则追加对应的单位
                unitHeadString = SmallToBigMap.get(String.valueOf(unit));
                sb = unitHeadString + sb;
            }
            unit = unit * perUnit;
        }
        return sb;
    }

    /**
     * 将小于一万的整数转换为中文汉语小写
     *
     * @param num
     * @return
     */
    public static String formatIntegerLess10000(int num) {
        StringBuffer sb = new StringBuffer();
        for (int unit = 1000; unit > 0; unit = unit / 10) {
            int _num = num / unit;
            // 追加数字翻译
            if (unit == 10 && sb.toString().matches("[零]+") && _num == 1) {
                // if (_num == 1) {
                // //十位是1的时候要 按 十一、十三 等 读取
                // // sb.append(SmallToBigMap.get("10"));
                // }
            }
            else {
                sb.append(SmallToBigMap.get(String.valueOf(_num)));
            }
            if (unit > 1 && _num > 0)
                sb.append(SmallToBigMap.get(String.valueOf(unit)));
            num = num % unit;
        }
        // System.out.println(sb.toString().replaceAll("[零]+",
        // "零").replaceAll("^零", "").replaceAll("零$", ""));
        // 先将连续的零联合为一个零，再去掉头部和末尾的零
        return sb.toString().replaceAll("[零]+", "零").replaceAll("^零", "")
                .replaceAll("零$", "");
    }

    public static String formatDecnum(String num) {
        StringBuffer sBuffer = new StringBuffer();
        char[] chars = num.toCharArray();
        for (int i = 0; i < num.length(); i++) {
            sBuffer.append(SmallToBigMap.get(String.valueOf(chars[i])));
        }

        return sBuffer.toString();
    }


    /**
     *
     * @param args
     */
    public static void main(String args[]) {
        double dValue = 1213.44460000000000001D;
        double dTemp = round(dValue, 2);
        double dd = round1(dValue, "###.000");
        System.out.println("Round is " + dTemp);
        System.out.println("Round1 is " + dd);

        // System.out.println(toChineseNumber.formatInteger(21));

        // System.out.println(toChineseNumber.format("123.123"));
        // System.out.println(toChineseNumber.format("101"));
        // System.out.println(toChineseNumber.format("1001"));
        // System.out.println(toChineseNumber.format("10100"));
        // System.out.println(toChineseNumber.format("1000000001.123"));
        int[] test = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,
                17, 18, 19, 20, 15, 25, 30, 45, 58, 60, 112, 110, 105, 154,
                903, 999, 1009, 1000, 2031, 2301, 3344 };
        for (int i = 0; i < test.length; i++) {
            System.out.println(NumberUtil.format(String
                    .valueOf(test[i])));
        }
    }
}
