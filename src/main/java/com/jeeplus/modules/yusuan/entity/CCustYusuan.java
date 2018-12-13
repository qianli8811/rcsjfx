/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.yusuan.entity;

import javax.validation.constraints.NotNull;

import com.jeeplus.common.persistence.DataEntity;
import com.jeeplus.common.utils.excel.annotation.ExcelField;

/**
 * 客户预算Entity
 * @author admin
 * @version 2018-04-21
 */
public class CCustYusuan extends DataEntity<CCustYusuan> {
	
	private static final long serialVersionUID = 1L;
	private Integer nianfen;		// 时间，单位：年
	private String ckname;		// 查询名称，公司名称
	private String num;		// 合计
	private String yiyue;		// 1月份的值
	private String eryue;		// 2月份的值
	private String sanyue;		// 3月份的值
	private String siyue;		// 4月份的值
	private String wuyue;		// 5月份的值
	private String liuyue;		// 6月份的值
	private String qiyue;		// 7月份的值
	private String bayue;		// 8月份的值
	private String jiuyue;		// 9月份的值
	private String shiyue;		// 10月份的值
	private String syyyue;		// 11月份的值
	private String seyyue;		// 12月份的值
	
	public CCustYusuan() {
		super();
	}

	public CCustYusuan(String id){
		super(id);
	}

	@NotNull(message="时间")
	@ExcelField(title="时间", align=2, sort=1)
	public Integer getNianfen() {
		return nianfen;
	}

	public void setNianfen(Integer nianfen) {
		this.nianfen = nianfen;
	}
	
	@ExcelField(title="公司名称", dictType="", align=2, sort=2)
	public String getCkname() {
		return ckname;
	}

	public void setCkname(String ckname) {
		this.ckname = ckname;
	}
	
	
	@ExcelField(title="1月", align=2, sort=3)
	public String getYiyue() {
		return yiyue;
	}

	public void setYiyue(String yiyue) {
		this.yiyue = yiyue;
	}
	
	@ExcelField(title="2月", align=2, sort=4)
	public String getEryue() {
		return eryue;
	}

	public void setEryue(String eryue) {
		this.eryue = eryue;
	}
	
	@ExcelField(title="3月", align=2, sort=5)
	public String getSanyue() {
		return sanyue;
	}

	public void setSanyue(String sanyue) {
		this.sanyue = sanyue;
	}
	
	@ExcelField(title="4月", align=2, sort=6)
	public String getSiyue() {
		return siyue;
	}

	public void setSiyue(String siyue) {
		this.siyue = siyue;
	}
	
	@ExcelField(title="5月", align=2, sort=7)
	public String getWuyue() {
		return wuyue;
	}

	public void setWuyue(String wuyue) {
		this.wuyue = wuyue;
	}
	
	@ExcelField(title="6月", align=2, sort=8)
	public String getLiuyue() {
		return liuyue;
	}

	public void setLiuyue(String liuyue) {
		this.liuyue = liuyue;
	}
	
	@ExcelField(title="7月", align=2, sort=9)
	public String getQiyue() {
		return qiyue;
	}

	public void setQiyue(String qiyue) {
		this.qiyue = qiyue;
	}
	
	@ExcelField(title="8月", align=2, sort=10)
	public String getBayue() {
		return bayue;
	}

	public void setBayue(String bayue) {
		this.bayue = bayue;
	}
	
	@ExcelField(title="9月", align=2, sort=11)
	public String getJiuyue() {
		return jiuyue;
	}

	public void setJiuyue(String jiuyue) {
		this.jiuyue = jiuyue;
	}
	
	@ExcelField(title="10月", align=2, sort=12)
	public String getShiyue() {
		return shiyue;
	}

	public void setShiyue(String shiyue) {
		this.shiyue = shiyue;
	}
	
	@ExcelField(title="11月", align=2, sort=13)
	public String getSyyyue() {
		return syyyue;
	}

	public void setSyyyue(String syyyue) {
		this.syyyue = syyyue;
	}
	
	@ExcelField(title="12月", align=2, sort=14)
	public String getSeyyue() {
		return seyyue;
	}

	public void setSeyyue(String seyyue) {
		this.seyyue = seyyue;
	}
	
	
	@ExcelField(title="合计", align=2, sort=15)
	public String getNum() {
		return num;
	}
	
	public void setNum(String num) {
		this.num = num;
	}
	
}