/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.cwzb.entity;

import javax.validation.constraints.NotNull;

import com.jeeplus.common.persistence.DataEntity;
import com.jeeplus.common.utils.excel.annotation.ExcelField;

/**
 * 财务指标参数设置Entity
 * @author admin
 * @version 2018-04-10
 */
public class RcCwzb extends DataEntity<RcCwzb> {
	
	private static final long serialVersionUID = 1L;
	private Double zjzzcs;		// 资金周转次数
	private Double khfzb;		// 客户负责比例
	private Double pjdwyj;      //平均单位油价（单位：元）
	
	public RcCwzb() {
		super();
	}

	public RcCwzb(String id){
		super(id);
	}

	@NotNull(message="资金周转次数不能为空")
	@ExcelField(title="资金周转次数", align=2, sort=1)
	public Double getZjzzcs() {
		return zjzzcs;
	}

	public void setZjzzcs(Double zjzzcs) {
		this.zjzzcs = zjzzcs;
	}
	
	@NotNull(message="客户负责比例不能为空")
	@ExcelField(title="客户负责比例", align=2, sort=2)
	public Double getKhfzb() {
		return khfzb;
	}

	public void setKhfzb(Double khfzb) {
		this.khfzb = khfzb;
	}
	
	public Double getPjdwyj() {
		return pjdwyj;
	}
	
	public void setPjdwyj(Double pjdwyj) {
		this.pjdwyj = pjdwyj;
	}
}