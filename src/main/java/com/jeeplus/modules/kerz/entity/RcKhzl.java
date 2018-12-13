/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.kerz.entity;


import com.jeeplus.common.persistence.DataEntity;
import com.jeeplus.common.utils.excel.annotation.ExcelField;

import java.util.List;

/**
 * 客户管理Entity
 * @author admin
 * @version 2018-03-13
 */
public class RcKhzl extends DataEntity<RcKhzl> {
	
	private static final long serialVersionUID = 1L;
	private String khjm;		// 客户简码前缀：RG,后面数字自增
	private String khmc;		// 客户名称
	private Double flmzb;		// 福临门油销售占比(百分比)
	private String guojia;		// 国家
	private String sf;		// 省份/州/自治区/直辖市
	private String city;		// 城市
	private String khdz;		// 详细地址，xxx县(区)xxx镇(乡)xxx村xxx号
	private Integer zjzzcs;     //资金周转次数
	private Double kfzbl;     //可负债比例
	
	private List<RcGd> rcGdList;//股东信息
	
	public RcKhzl() {
		super();
	}

	public RcKhzl(String id){
		super(id);
	}

	@ExcelField(title="客户简码前缀：RG,后面数字自增", align=2, sort=1)
	public String getKhjm() {
		return khjm;
	}

	public void setKhjm(String khjm) {
		this.khjm = khjm;
	}
	
	@ExcelField(title="客户名称", align=2, sort=2)
	public String getKhmc() {
		return khmc;
	}

	public void setKhmc(String khmc) {
		this.khmc = khmc;
	}
	
	public Double getFlmzb() {
		return flmzb;
	}
	
	public void setFlmzb(Double flmzb) {
		this.flmzb = flmzb;
	}
	
	@ExcelField(title="国家", align=2, sort=4)
	public String getGuojia() {
		return guojia;
	}

	public void setGuojia(String guojia) {
		this.guojia = guojia;
	}
	
	@ExcelField(title="省份/州/自治区/直辖市", align=2, sort=5)
	public String getSf() {
		return sf;
	}

	public void setSf(String sf) {
		this.sf = sf;
	}
	
	@ExcelField(title="城市", align=2, sort=6)
	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}
	
	@ExcelField(title="详细地址，xxx县(区)xxx镇(乡)xxx村xxx号", align=2, sort=7)
	public String getKhdz() {
		return khdz;
	}

	public void setKhdz(String khdz) {
		this.khdz = khdz;
	}
	
	public List<RcGd> getRcGdList() {
		return rcGdList;
	}
	
	public void setRcGdList(List<RcGd> rcGdList) {
		this.rcGdList = rcGdList;
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
	
	public void setKfzbl(Double kfzbl) {
		this.kfzbl = kfzbl;
	}
}