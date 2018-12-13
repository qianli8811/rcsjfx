/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.xssj.entity;


import com.jeeplus.common.persistence.DataEntity;
import com.jeeplus.common.utils.excel.annotation.ExcelField;

/**
 * 授信额度统计Entity
 * @author admin
 * @version 2018-05-03
 */
public class CSxeduTj extends DataEntity<CSxeduTj> {
	
	private static final long serialVersionUID = 1L;
	private Integer nianfen;		// 统计时间，单位：年
	private Integer yuefen;		// 统计时间，单位：月
	private String ckName;		// 查询名称，公司名称
	private Integer sfhz;       //是否合作
	private Double rzje;		// 融资金额
	private Double flmzb;		// 福临门占比
	private Integer zjzzcs;		// 客户资金周转次数
	private Double kfzbl;		// 可负债比例
	private Double dsyear;		// 大前年的销售收入
	private Double deyear;		// 前年的销售收入
	private Double dyyear;		// 去年的销售收入
	private Double sanyear;		// 近三年平均销售收入
	private Double dyear;		// 今年的销售收入
	private Double sxsxed;		// 授信额度上限
	private Double sxxxed;		// 授信额度下限
	private Double qntqljxs;		// 去年同期销售收入
	private Double ljys;		// 累计预算
	private Double qnys;		// 全年预算
	private Double dcl;		// 预算达成率
	private Double qnjd;		// 全年进度
	
	public CSxeduTj() {
		super();
	}

	public CSxeduTj(String id){
		super(id);
	}

	
	public Integer getNianfen() {
		return nianfen;
	}

	public void setNianfen(Integer nianfen) {
		this.nianfen = nianfen;
	}
	
	
	public Integer getYuefen() {
		return yuefen;
	}

	public void setYuefen(Integer yuefen) {
		this.yuefen = yuefen;
	}
	
	@ExcelField(title="公司名称", align=3, sort=1)
	public String getCkName() {
		return ckName;
	}

	public void setCkName(String ckname) {
		this.ckName = ckname;
	}
	

	@ExcelField(title="${nianfen-3}年", align=3, sort=2)
	public Double getDsyear() {
		return dsyear;
	}

	public void setDsyear(Double dsyear) {
		this.dsyear = dsyear;
	}
	
	@ExcelField(title="${nianfen-2}年", align=3, sort=3)
	public Double getDeyear() {
		return deyear;
	}

	public void setDeyear(Double deyear) {
		this.deyear = deyear;
	}
	
	@ExcelField(title="${nianfen-1}年", align=3, sort=4)
	public Double getDyyear() {
		return dyyear;
	}

	public void setDyyear(Double dyyear) {
		this.dyyear = dyyear;
	}
	
	@ExcelField(title="近三年平均销售收入", align=3, sort=5)
	public Double getSanyear() {
		return sanyear;
	}

	public void setSanyear(Double sanyear) {
		this.sanyear = sanyear;
	}
	
	@ExcelField(title="${nianfen}年", align=3, sort=6)
	public Double getDyear() {
		return dyear;
	}
	
	@ExcelField(title="${nianfen-1}年同期销售收入", align=3, sort=7,groups = {0})
	public Double getQntqljxs() {
		return qntqljxs;
	}
	@ExcelField(title="累计预算", align=3, sort=8)
	public Double getLjys() {
		return ljys;
	}
	
	public void setLjys(Double ljys) {
		this.ljys = ljys;
	}
	
	@ExcelField(title="全年预算", align=3, sort=10)
	public Double getQnys() {
		return qnys;
	}
	
	public void setQnys(Double qnys) {
		this.qnys = qnys;
	}
	
	public Double getDcl() {
		return dcl;
	}
	
	@ExcelField(title="预算达成率", align=3, sort=11)
	public String getExcelDcl() {
		Double dcl = this.getDcl();
		return dcl * 100 + "%";
	}
	
	public void setDcl(Double dcl) {
		this.dcl = dcl;
	}
	
	@ExcelField(title="全年进度", align=3, sort=12)
	public Double getQnjd() {
		return qnjd;
	}
	
	public void setQnjd(Double qnjd) {
		this.qnjd = qnjd;
	}
	
	public void setQntqljxs(Double qntqljxs) {
		this.qntqljxs = qntqljxs;
	}

	public void setDyear(Double dyear) {
		this.dyear = dyear;
	}
	@ExcelField(title="福临门占比", align=3, sort=13)
	public Double getFlmzb() {
		return flmzb;
	}
	
	@ExcelField(title="福临门占比", align=3, sort=13)
	public String  getExcelFlmzb() {
		Double flmzb = this.getFlmzb();
		return flmzb / 100 + "%";
	}
	@ExcelField(title="外部融资", align=3, sort=14)
	public Double getRzje() {
		return rzje;
	}
	
	public void setRzje(Double rzje) {
		this.rzje = rzje;
	}
	public void setFlmzb(Double flmzb) {
		this.flmzb = flmzb;
	}
	

	public void setKfzbl(Double kfzbl) {
		this.kfzbl = kfzbl;
	}
	
	@ExcelField(title="授信额度上限", align=3, sort=15)
	public Double getSxsxed() {
		return sxsxed;
	}

	public void setSxsxed(Double sxsxed) {
		this.sxsxed = sxsxed;
	}
	
	@ExcelField(title="授信额度下限", align=3, sort=16)
	public Double getSxxxed() {
		return sxxxed;
	}

	public void setSxxxed(Double sxxxed) {
		this.sxxxed = sxxxed;
	}
	
	
	public Integer getZjzzcs() {
		return zjzzcs;
	}
	
	public void setZjzzcs(Integer zjzzcs) {
		this.zjzzcs = zjzzcs;
	}
	
	public Double getKfzbl() {
		return kfzbl;
	}
	
	
	public Integer getSfhz() {
		return sfhz;
	}
	
	public void setSfhz(Integer sfhz) {
		this.sfhz = sfhz;
	}
	
	
	@Override
	public String toString() {
		return "CSxeduTj{" +
				"nianfen=" + nianfen +
				", yuefen=" + yuefen +
				", ckName='" + ckName + '\'' +
				", sfhz=" + sfhz +
				", rzje=" + rzje +
				", flmzb=" + flmzb +
				", zjzzcs=" + zjzzcs +
				", kfzbl=" + kfzbl +
				", dsyear=" + dsyear +
				", deyear=" + deyear +
				", dyyear=" + dyyear +
				", sanyear=" + sanyear +
				", dyear=" + dyear +
				", sxsxed=" + sxsxed +
				", sxxxed=" + sxxxed +
				", qntqljxs=" + qntqljxs +
				", ljys=" + ljys +
				", qnys=" + qnys +
				", dcl=" + dcl +
				", qnjd=" + qnjd +
				'}';
	}
}