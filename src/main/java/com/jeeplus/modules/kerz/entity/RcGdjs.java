/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.kerz.entity;

import javax.validation.constraints.NotNull;

import com.jeeplus.common.persistence.DataEntity;
import com.jeeplus.common.utils.excel.annotation.ExcelField;

/**
 * 股东家属信息Entity
 * @author admin
 * @version 2018-04-18
 */
public class RcGdjs extends DataEntity<RcGdjs> {
	
	private static final long serialVersionUID = 1L;
	private RcGdxx rcGdxx;		// 股东id
	private String jsgx;		// 1配偶,2女儿,3儿子,4兄弟,5姐妹,6父母,7朋友,8其它
	private String jsxm;		// 姓名
	private String sfzh;		// 身份证号
	private String xb;		// 性别
	private String nl;		// 年龄
	private String job;		// 职业
	private String telephone;		// 电话
	private String isMarry;		// 是否已婚
	private String isDbr;		// 是否担保
	private String peiouisdbr;		// 配偶是否是股东
	private String peiouxm;		// 配偶姓名
	private String peiousfzh;		// 配偶身份证号
	private String peiouxb;		// 配偶性别
	private String peiounl;		// 配偶年龄
	private String peiouxl;     //配偶学历
	private String peioujob;    //配偶职业
	private String peioudh;     //配偶电话
	
	
	
	public RcGdjs() {
		super();
	}

	public RcGdjs(String id){
		super(id);
	}
	
	public RcGdxx getRcGdxx() {
		return rcGdxx;
	}
	
	public void setRcGdxx(RcGdxx rcGdxx) {
		this.rcGdxx = rcGdxx;
	}
	
	@ExcelField(title="1配偶,2女儿,3儿子,4兄弟,5姐妹,6父母,7朋友,8其它", dictType="jtcy_type", align=2, sort=2)
	public String getJsgx() {
		return jsgx;
	}

	public void setJsgx(String jsgx) {
		this.jsgx = jsgx;
	}
	
	@ExcelField(title="姓名", align=2, sort=3)
	public String getJsxm() {
		return jsxm;
	}

	public void setJsxm(String jsxm) {
		this.jsxm = jsxm;
	}
	
	@ExcelField(title="身份证号", align=2, sort=4)
	public String getSfzh() {
		return sfzh;
	}

	public void setSfzh(String sfzh) {
		this.sfzh = sfzh;
	}
	
	@ExcelField(title="性别", align=2, sort=5)
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
	
	@ExcelField(title="职业", align=2, sort=7)
	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}
	
	@ExcelField(title="电话", align=2, sort=8)
	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	
	@ExcelField(title="是否已婚", align=2, sort=9)
	public String getIsMarry() {
		return isMarry;
	}

	public void setIsMarry(String isMarry) {
		this.isMarry = isMarry;
	}
	
	@ExcelField(title="是否担保", align=2, sort=10)
	public String getIsDbr() {
		return isDbr;
	}

	public void setIsDbr(String isDbr) {
		this.isDbr = isDbr;
	}
	
	@ExcelField(title="配偶姓名", align=2, sort=11)
	public String getPeiouxm() {
		return peiouxm;
	}

	public void setPeiouxm(String peiouxm) {
		this.peiouxm = peiouxm;
	}
	
	@ExcelField(title="配偶身份证号", align=2, sort=12)
	public String getPeiousfzh() {
		return peiousfzh;
	}

	public void setPeiousfzh(String peiousfzh) {
		this.peiousfzh = peiousfzh;
	}
	
	@ExcelField(title="性别", align=2, sort=13)
	public String getPeiouxb() {
		return peiouxb;
	}

	public void setPeiouxb(String peiouxb) {
		this.peiouxb = peiouxb;
	}
	
	@ExcelField(title="年龄", align=2, sort=14)
	public String getPeiounl() {
		return peiounl;
	}

	public void setPeiounl(String peiounl) {
		this.peiounl = peiounl;
	}
	
	public String getPeiouxl() {
		return peiouxl;
	}
	
	public void setPeiouxl(String peiouxl) {
		this.peiouxl = peiouxl;
	}
	
	public String getPeioujob() {
		return peioujob;
	}
	
	public void setPeioujob(String peioujob) {
		this.peioujob = peioujob;
	}
	
	public String getPeioudh() {
		return peioudh;
	}
	
	public void setPeioudh(String peioudh) {
		this.peioudh = peioudh;
	}
	
	public String getPeiouisdbr() {
		return peiouisdbr;
	}
	
	public void setPeiouisdbr(String peiouisdbr) {
		this.peiouisdbr = peiouisdbr;
	}
}