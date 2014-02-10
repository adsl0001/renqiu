package com.renqiu.ggzy.activiti;

import java.util.Calendar;
import java.util.Date;

import org.springframework.stereotype.Service;

import com.renqiu.ggzy.util.DateUtil;

/**
 * 超期计算 TODO 超期时长要排除非工作日时间
 * 
 * @author lenovo
 * 
 */
@Service
public class DueDate {

	public Date day(double day) {
		// TODO 数据溢出检测
		int minute = (int) (day * 24 * 60);
		return minute(minute);
	}

	public Date hour(double hour) {
		// TODO 数据溢出检测
		int minute = (int) (hour * 24);
		return minute(minute);
	}

	public Date minute(int minute) {
		Calendar now = Calendar.getInstance();
		Calendar dueDate = Calendar.getInstance();
		// TODO 数据溢出检测
		dueDate.add(Calendar.MINUTE, minute);
		// 排除周六日===========
		long days = DateUtil.daysBetween(now.getTime(), dueDate.getTime());
		//两个间隔天数中有多少节假日
		
		return dueDate.getTime();
	}
	public static void main(String[] args) {
		Calendar now = Calendar.getInstance();
		Calendar dueDate = Calendar.getInstance();
		dueDate.add(Calendar.MINUTE, 60*23);
		System.out.println(DateUtil.getDateFormatString(now.getTime(), DateUtil.STANDARD_DATETIME_FORMAT));
		System.out.println(DateUtil.getDateFormatString(dueDate.getTime(), DateUtil.STANDARD_DATETIME_FORMAT));
		long days = DateUtil.daysBetween(now.getTime(), dueDate.getTime());
//		days = days > 0 ? days + 1 : 1 - days;
		System.out.println(days);
	}
//
//	private static long computeHolidays(Calendar begin, Calendar end,
//			boolean ignoreHolidays) {
//	
//		// 算出两个日期间的天数
//		long days = DateUtil.getDiffDays(begin.getTime(), end.getTime());
//		// 我们的计算的天数是包含两个日期，也就是一个 闭区间
//		days = days > 0 ? days + 1 : 1 - days;
//		if (ignoreHolidays) {
//			return days;
//		}
//
//		int holidays = 0;
//		// 确定一个 大日期
//		if (cal1.compareTo(cal2) > 0) {
//			Calendar temp = cal1;
//			cal1 = cal2;
//			cal2 = temp;
//			temp = null;
//		}
//		// 只要两个日期之间相隔的天数 是7 的整数倍，那么 双休日的时间 一定为 2*(对7的整数倍)
//		holidays = (days / 7) * 2;
//		// 去除整数倍的时间后，看看两个日期间的 周末天数
//		cal1.add(Calendar.DAY_OF_YEAR, (days / 7) * 7);
//
//		int day = -1;
//		// 如果两个日期间的 间隔天数正好是7的整数倍也就不用 循环找周末了
//		do {
//			day = cal2.get(Calendar.DAY_OF_WEEK);
//			if (day == 1 || day == 7)
//				holidays++;
//			if (cal1.compareTo(cal2) == 0)
//				break;
//			cal2.add(Calendar.DAY_OF_YEAR, -1);
//		} while ((days % 7) > 0);
//
//		return holidays;
//	}

}
