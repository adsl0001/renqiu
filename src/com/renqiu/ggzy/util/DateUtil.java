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
}
