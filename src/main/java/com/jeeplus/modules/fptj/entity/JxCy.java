/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.fptj.entity;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import com.jeeplus.common.persistence.DataEntity;
import com.jeeplus.common.utils.excel.annotation.ExcelField;

/**
 * 进项抽样统计Entity
 * @author admin
 * @version 2018-03-12
 */
public class JxCy extends DataEntity<JxCy> {
	
	private static final long serialVersionUID = 1L;
	private String xsfh;		// 税号
	private String gmfmc;		// 名称
	private String jsplx;		// 金税盘类型
	private Date zhcqrq;		// 最后抽取日期
	
	public JxCy() {
		super();
	}

	public JxCy(String id){
		super(id);
	}

	
	@ExcelField(title="类型", align=2, sort=3)
	public String getJsplx() {
		return jsplx;
	}
	@ExcelField(title="税号", align=2, sort=1)
	public String getXsfh() {
		return xsfh;
	}
	
	public void setXsfh(String xsfh) {
		this.xsfh = xsfh;
	}
	@ExcelField(title="名称", align=2, sort=2)
	public String getGmfmc() {
		return gmfmc;
	}
	
	public void setGmfmc(String gmfmc) {
		this.gmfmc = gmfmc;
	}
	
	public void setJsplx(String jsplx) {
		this.jsplx = jsplx;
	}
	@ExcelField(title="抽取日期", align=2, sort=2)
	public Date getZhcqrq() {
		return zhcqrq;
	}
	
	public void setZhcqrq(Date zhcqrq) {
		this.zhcqrq = zhcqrq;
	}
}