/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.kerz.entity;

import javax.validation.constraints.NotNull;

import com.jeeplus.common.persistence.DataEntity;
import com.jeeplus.common.utils.excel.annotation.ExcelField;

/**
 * 股东信息Entity
 * @author admin
 * @version 2018-04-18
 */
public class RcGdxx extends DataEntity<RcGdxx> {
	
	private static final long serialVersionUID = 1L;
	private RcKhzl rcKhzl;		// 客户资料id
	private String khlx;		// 类型：1股东，2实际控股人，3法人,4其它
	private String gdxm;		// 姓名
	private String sfzh;		// 身份证号
	private String xb;		// 性别
	private String nl;		// 年龄
	private String zgb;		// 占股比
	private String isMarry;		// 是否已婚
	private String isDbr;		// 是否是担保
	
	private String xl;     //配偶学历
	
	private String dh;     //配偶电话
	
	public RcGdxx() {
		super();
	}

	public RcGdxx(String id){
		super(id);
	}
	
	
	public RcKhzl getRcKhzl() {
		return rcKhzl;
	}
	
	public void setRcKhzl(RcKhzl rcKhzl) {
		this.rcKhzl = rcKhzl;
	}
	
	
	
	
	@ExcelField(title="类型：1股东，2实际控股人，3法人,4其它", dictType="rcgd_type", align=2, sort=2)
	public String getKhlx() {
		return khlx;
	}

	public void setKhlx(String khlx) {
		this.khlx = khlx;
	}
	
	@ExcelField(title="姓名", align=2, sort=3)
	public String getGdxm() {
		return gdxm;
	}

	public void setGdxm(String gdxm) {
		this.gdxm = gdxm;
	}
	
	@ExcelField(title="身份证号", align=2, sort=4)
	public String getSfzh() {
		return sfzh;
	}

	public void setSfzh(String sfzh) {
		this.sfzh = sfzh;
	}
	
	@ExcelField(title="性别", dictType="sex", align=2, sort=5)
	public String getXb() {
		return xb;
	}

	public void setXb(String xb) {
		this.xb = xb;
	}
	
	@ExcelField(title="年龄", align=2, sort=6)
	public String getNl() {
		return nl;
	}

	public void setNl(String nl) {
		this.nl = nl;
	}
	
	@ExcelField(title="占股比", align=2, sort=7)
	public String getZgb() {
		return zgb;
	}

	public void setZgb(String zgb) {
		this.zgb = zgb;
	}
	
	@ExcelField(title="是否已婚", dictType="yes_no", align=2, sort=8)
	public String getIsMarry() {
		return isMarry;
	}

	public void setIsMarry(String isMarry) {
		this.isMarry = isMarry;
	}
	
	@ExcelField(title="是否是担保", dictType="yes_no", align=2, sort=9)
	public String getIsDbr() {
		return isDbr;
	}

	public void setIsDbr(String isDbr) {
		this.isDbr = isDbr;
	}
	
	public String getXl() {
		return xl;
	}
	
	public void setXl(String xl) {
		this.xl = xl;
	}
	
	public String getDh() {
		return dh;
	}
	
	public void setDh(String dh) {
		this.dh = dh;
	}
}