package com.jeeplus.modules.kerz.entity;

import com.jeeplus.common.persistence.DataEntity;

public class Gdfxtj extends DataEntity<Gdfxtj> {
	
	private String khjm; //客户简码
	private String khmc; //客户名称
	private Integer heji; //总人数
	private Integer gd; //股东人数
	private Integer sjkgr; //实际控股人
	private Integer dbr; //担保人
	private Integer n;  //男性人数
	private Integer nv; //女性人数
	private Integer sb; //18岁以下
	private Integer ss; //18~30岁
	private Integer ts; //30~50岁
	private Integer ls; //50岁以上
	
	public String getKhjm() {
		return khjm;
	}
	
	public void setKhjm(String khjm) {
		this.khjm = khjm;
	}
	
	public String getKhmc() {
		return khmc;
	}
	
	public void setKhmc(String khmc) {
		this.khmc = khmc;
	}
	
	public Integer getHeji() {
		return heji;
	}
	
	public void setHeji(Integer heji) {
		this.heji = heji;
	}
	
	public Integer getGd() {
		return gd;
	}
	
	public void setGd(Integer gd) {
		this.gd = gd;
	}
	
	public Integer getSjkgr() {
		return sjkgr;
	}
	
	public void setSjkgr(Integer sjkgr) {
		this.sjkgr = sjkgr;
	}
	
	public Integer getDbr() {
		return dbr;
	}
	
	public void setDbr(Integer dbr) {
		this.dbr = dbr;
	}
	
	public Integer getN() {
		return n;
	}
	
	public void setN(Integer n) {
		this.n = n;
	}
	
	public Integer getNv() {
		return nv;
	}
	
	public void setNv(Integer nv) {
		this.nv = nv;
	}
	
	public Integer getSb() {
		return sb;
	}
	
	public void setSb(Integer sb) {
		this.sb = sb;
	}
	
	public Integer getSs() {
		return ss;
	}
	
	public void setSs(Integer ss) {
		this.ss = ss;
	}
	
	public Integer getTs() {
		return ts;
	}
	
	public void setTs(Integer ts) {
		this.ts = ts;
	}
	
	public Integer getLs() {
		return ls;
	}
	
	public void setLs(Integer ls) {
		this.ls = ls;
	}
}
