package com.renqiu.ggzy.activiti;

import java.util.Calendar;
import java.util.Date;

import org.springframework.stereotype.Service;

/**
 * 超期计算
 * TODO 超期时长要排除非工作日时间
 * @author lenovo
 *
 */
@Service
public class DueDate {

	public Date day(double day) {
		Calendar now = Calendar.getInstance();
		// TODO 数据溢出检测
		int minute = (int) (day * 24 * 60);
		now.add(Calendar.MINUTE, minute);
		return now.getTime();
	}

	public Date hour(double hour) {
		Calendar now = Calendar.getInstance();
		// TODO 数据溢出检测
		int minute = (int) (hour*24);
		now.add(Calendar.MINUTE,minute );
		return now.getTime();
	}
	public Date minute(int minute) {
		Calendar now = Calendar.getInstance();
		// TODO 数据溢出检测
		now.add(Calendar.MINUTE, minute);
		return now.getTime();
	}
}
