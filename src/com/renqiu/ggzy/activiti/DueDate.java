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
		int dayOfweek;
		for (long i = 0; i < days; i++) {
			dayOfweek = now.get(Calendar.DAY_OF_WEEK);
			if (dayOfweek==Calendar.SATURDAY||dayOfweek==Calendar.SUNDAY) {
				dueDate.add(Calendar.DAY_OF_MONTH, 1);
			}
			now.add(Calendar.DAY_OF_MONTH, 1);
		}
		dayOfweek = dueDate.get(Calendar.DAY_OF_WEEK);
		if (dayOfweek==Calendar.SATURDAY) {
			dueDate.add(Calendar.DAY_OF_MONTH, 2);
		}else if (dayOfweek==Calendar.SUNDAY) {
			dueDate.add(Calendar.DAY_OF_MONTH, 1);
		}
		//排除结束=======================
		return dueDate.getTime();
	}

	public static void main(String[] args) {
		Calendar now = Calendar.getInstance();
		Calendar dueDate = Calendar.getInstance();
		dueDate.add(Calendar.MINUTE, Integer.MAX_VALUE );
		System.out.println(DateUtil.getDateFormatString(now.getTime(),
				DateUtil.STANDARD_DATETIME_FORMAT));
		System.out.println(DateUtil.getDateFormatString(dueDate.getTime(),
				DateUtil.STANDARD_DATETIME_FORMAT));
		long days = DateUtil.daysBetween(now.getTime(), dueDate.getTime());
		int dayOfweek;
		System.out.println(days);
		int count = 0;
		for (long i = 0; i < days; i++) {
			dayOfweek = now.get(Calendar.DAY_OF_WEEK);
			if (dayOfweek==Calendar.SATURDAY||dayOfweek==Calendar.SUNDAY) {
				count++;
				dueDate.add(Calendar.DAY_OF_MONTH, 1);
			}
			now.add(Calendar.DAY_OF_MONTH, 1);
		}
		dayOfweek = dueDate.get(Calendar.DAY_OF_WEEK);
		if (dayOfweek==Calendar.SATURDAY) {
			dueDate.add(Calendar.DAY_OF_MONTH, 2);
		}else if (dayOfweek==Calendar.SUNDAY) {
			dueDate.add(Calendar.DAY_OF_MONTH, 1);
		}
		dueDate.add(Calendar.YEAR, 1);
		System.out.println(count);
		System.out.println(DateUtil.getDateFormatString(dueDate.getTime(),
				DateUtil.STANDARD_DATETIME_FORMAT));
	}
 

}
