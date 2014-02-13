package com.renqiu.ggzy.entity;

/**
 * 公示信息
 * 
 * @author lenovo
 * 
 */
public class PublicInfo {
	/**
	 * 申报时间
	 */
	private String sbsj;
	/**
	 * 流水号
	 */
	private String lsh;
	/**
	 * 办理事项
	 */
	private String sxmc;
	/**
	 * 流程状态
	 */
	private String lczt;
	/**
	 * 当前环节
	 */
	private String dqhj;
	/**
	 * 是否超期
	 */
	private String sfcq;
	public String getSbsj() {
		return sbsj;
	}
	public void setSbsj(String sbsj) {
		this.sbsj = sbsj;
	}
	public String getLsh() {
		return lsh;
	}
	public void setLsh(String lsh) {
		this.lsh = lsh;
	}
	public String getSxmc() {
		return sxmc;
	}
	public void setSxmc(String sxmc) {
		this.sxmc = sxmc;
	}
	public String getLczt() {
		return lczt;
	}
	public void setLczt(String lczt) {
		this.lczt = lczt;
	}
	public String getDqhj() {
		return dqhj;
	}
	public void setDqhj(String dqhj) {
		this.dqhj = dqhj;
	}
	public String getSfcq() {
		return sfcq;
	}
	public void setSfcq(String sfcq) {
		this.sfcq = sfcq;
	}

}
