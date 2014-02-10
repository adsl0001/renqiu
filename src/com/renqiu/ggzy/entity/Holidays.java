package com.renqiu.ggzy.entity;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 *工作日设置
 * 
 * @author lenovo
 * 
 */
@Entity
@Table(name="T_Holidays")
public class Holidays {
	@Id
	private String theDate;
	/**
	 * 是否工作日
	 * 0是非工作日
	 * 1是工作日
	 */
	private int workingDay ;
	/**
	 * 描述
	 */
	private String description;
	public String getTheDate() {
		return theDate;
	}
	public void setTheDate(String theDate) {
		this.theDate = theDate;
	}
	public int getWorkingDay() {
		return workingDay;
	}
	public void setWorkingDay(int workingDay) {
		this.workingDay = workingDay;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
}
