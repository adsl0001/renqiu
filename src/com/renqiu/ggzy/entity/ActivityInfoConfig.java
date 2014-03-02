package com.renqiu.ggzy.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 活动信息配置
 * 
 * @author lenovo
 * 
 */
@Entity
@Table(name = "T_ActivityInfoConfig")
public class ActivityInfoConfig {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long activityInfoId;
	/**
	 * 流程定义id
	 */
	private String processDefinitionKey;
	/**
	 * 活动id
	 */
	private String activityId;
	/**
	 * 提前多少分钟预警
	 */
	private long minute;
	/**
	 * 责任单位名称
	 */
	private String dwmc ;

}
