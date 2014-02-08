package com.renqiu.ggzy.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.renqiu.demo.activiti.entity.AbsProcess;
/**
 * 四证一章申请
 * @author Administrator
 *
 */
@Entity
@Table(name="T_SZYZSQ")
public class Szyzsq extends AbsProcess{
	/**
	 * 申请编号  唯一id,数据库自增，可用于生成二维码
	 */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
//	@GeneratedValue(generator="se_szyzsq" ,strategy=GenerationType.SEQUENCE)
//	@SequenceGenerator(name="se_szyzsq", sequenceName="se_szyzsq_id")  
	private Long sqbh;
	/**
	 * 法人身份证号
	 */
	private String frsfzh;
	/**
	 * 法人姓名
	 */
	private	String frxm;
	/**
	 * 联系方式
	 */
	private	String lxfs;
	/**
	 * 企业名称 
	 */
	private String qymc;
	/**
	 * 受理人id
	 */
	private String slr;
	/**
	 * 受理人姓名
	 */
	private String slrxm;
	
	/**
	 * 是否刻章
	 */
	@Column(nullable=true)
	private String sfkz ;
	 
	/**
	 * 是否办理国税
	 */
	@Column(nullable=true)
	private String sfblgs ;
	
	 
	/**
	 * 流程实例id
	 */
	private	String piId;
	public Long getSqbh() {
		return sqbh;
	}
	public void setSqbh(Long sqbh) {
		this.sqbh = sqbh;
	}
	public String getFrsfzh() {
		return frsfzh;
	}
	public void setFrsfzh(String frsfzh) {
		this.frsfzh = frsfzh;
	}
	public String getFrxm() {
		return frxm;
	}
	public void setFrxm(String frxm) {
		this.frxm = frxm;
	}
	public String getLxfs() {
		return lxfs;
	}
	public void setLxfs(String lxfs) {
		this.lxfs = lxfs;
	}
	public String getPiId() {
		return piId;
	}
	public void setPiId(String piId) {
		this.piId = piId;
	}
	public String getSfkz() {
		return sfkz;
	}
	public void setSfkz(String sfkz) {
		this.sfkz = sfkz;
	}
	public String getSfblgs() {
		return sfblgs;
	}
	public void setSfblgs(String sfblgs) {
		this.sfblgs = sfblgs;
	}
	public String getQymc() {
		return qymc;
	}
	public void setQymc(String qymc) {
		this.qymc = qymc;
	}
	public String getSlr() {
		return slr;
	}
	public void setSlr(String slr) {
		this.slr = slr;
	}
	public String getSlrxm() {
		return slrxm;
	}
	public void setSlrxm(String slrxm) {
		this.slrxm = slrxm;
	}
	
}
