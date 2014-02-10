package com.renqiu.ggzy.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public final class DateUtil {
	public static final String STANDARD_DATE_FORMAT = "yyyy-MM-dd";
	public static final String STANDARD_DATEMINUTE_FORMAT = "yyyy-MM-dd HH:mm";
	public static final String STANDARD_DATETIME_FORMAT = "yyyy-MM-dd HH:mm:ss";

	public static boolean isDate(String text) {
		boolean result = true;
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		try {
			format.parse(text);
		} catch (ParseException e) {
			result = false;
		}

		return result;
	}

	public static String getDateFormatString(Date date, String formatString) {
		String dateString = "";
		SimpleDateFormat format = new SimpleDateFormat(formatString);
		if (date != null) {
			dateString = format.format(date);
		}
		return dateString;
	}

	public static String getStandardDateString(Date date) {
		return getDateFormatString(date, "yyyy-MM-dd");
	}

	public static String getNowStandardDateString() {
		return getStandardDateString(new Date());
	}

	public static String getNowStandardMinuteString() {
		return getStandardMinuteString(new Date());
	}

	public static String getNowStandardSecondString() {
		return getStandardSecondString(new Date());
	}

	public static String getStandardMinuteString(Date date) {
		return getDateFormatString(date, "yyyy-MM-dd HH:mm");
	}

	public static String getStandardSecondString(Date date) {
		return getDateFormatString(date, "yyyy-MM-dd HH:mm:ss");
	}

	public static Date getCurrentTime() {
		return new Date();
	}

	public static Date convertStringToDate(String dateString, String format,
			Date defaultDate) {
		SimpleDateFormat dateFormat = new SimpleDateFormat(format);
		Date date;
		try {
			date = dateFormat.parse(dateString);
		} catch (ParseException e) {
			date = defaultDate;
		}
		return date;
	}

	public static Date addDays(Date date, int days) {
		Date newDate = new Date(date.getTime() + days * 24L * 60L * 60L * 1000L);
		return newDate;
	}

	public static long getDiffDays(Date begin, Date end) {
		long days = (end.getTime() - begin.getTime()) / 86400000L;
		return days;
	}
	  /**
     * 计算日期相差天数
     * 
     * @param early
     *            开始时间
     * @param late
     *            结束时间
     * @return 相差天数  ,日期相等返回1 
     * @author 都本尊 
     */
    public static long daysBetween(Date early, Date late) {

        java.util.Calendar calst = java.util.Calendar.getInstance();
        java.util.Calendar caled = java.util.Calendar.getInstance();
        calst.setTime(early);
        caled.setTime(late);
        // 设置时间为0时
        calst.set(java.util.Calendar.HOUR_OF_DAY, 0);
        calst.set(java.util.Calendar.MINUTE, 0);
        calst.set(java.util.Calendar.SECOND, 0);
        caled.set(java.util.Calendar.HOUR_OF_DAY, 0);
        caled.set(java.util.Calendar.MINUTE, 0);
        caled.set(java.util.Calendar.SECOND, 0);
        // 得到两个日期相差的天数
        long days = ((long) (caled.getTime().getTime() / 1000) - (long) (calst
                .getTime().getTime() / 1000)) / 3600 / 24;
        days = Math.abs(days);
        days++;
        return days;
    }
}
