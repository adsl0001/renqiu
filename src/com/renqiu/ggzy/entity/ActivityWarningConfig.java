package com.renqiu.ggzy.entity;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="T_ActivityWarningConfig")
public class ActivityWarningConfig {
	@Id
	private String processDefinitionKey ;
	/**
	 * 活动id
	 */
	private String activityId;
	/**
	 *  提前多少分钟预警
	 */
	private long minute;

}
