/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.fptj.entity;


import com.jeeplus.common.persistence.DataEntity;
import com.jeeplus.common.utils.excel.annotation.ExcelField;

/**
 * 销项抽样统计Entity
 * @author admin
 * @version 2018-03-12
 */
public class XxCy extends DataEntity<XxCy> {
	
	private static final long serialVersionUID = 1L;
	private String rzjg;		// 税号
	private String skjbh;		// 分机号
	private String rzje;		// 名称
	private String jsplx;		// 金税盘类型
	private String zhcqrq;		// 最后抽取日期
	
	public XxCy() {
		super();
	}

	public XxCy(String id){
		super(id);
	}

	@ExcelField(title="税号", align=2, sort=1)
	public String getRzjg() {
		return rzjg;
	}

	public void setRzjg(String rzjg) {
		this.rzjg = rzjg;
	}
	
	@ExcelField(title="分机号", align=2, sort=2)
	public String getSkjbh() {
		return skjbh;
	}

	public void setSkjbh(String skjbh) {
		this.skjbh = skjbh;
	}
	
	@ExcelField(title="名称", dictType="", align=2, sort=3)
	public String getRzje() {
		return rzje;
	}

	public void setRzje(String rzje) {
		this.rzje = rzje;
	}
	
	@ExcelField(title="金税盘类型", align=2, sort=4)
	public String getJsplx() {
		return jsplx;
	}

	public void setJsplx(String jsplx) {
		this.jsplx = jsplx;
	}
	
	@ExcelField(title="最后抽取日期", align=2, sort=5)
	public String getZhcqrq() {
		return zhcqrq;
	}

	public void setZhcqrq(String zhcqrq) {
		this.zhcqrq = zhcqrq;
	}
	
}