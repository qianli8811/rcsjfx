/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.xssj.entity;

import javax.validation.constraints.NotNull;

import com.jeeplus.common.persistence.DataEntity;
import com.jeeplus.common.utils.excel.annotation.ExcelField;

/**
 * 企业核心销售数据统计Entity
 * @author admin
 * @version 2018-03-20
 */
public class CCustsaleTj extends DataEntity<CCustsaleTj> {
	
	private static final long serialVersionUID = 1L;
	private Integer nianfen;		// 统计时间，单位：年
	private Integer yuefen;		// 月份
	private String khjm;        //客户简码
	private String daqu;        //大区
	private String ckname;		// 查询名称，公司名称
	private Integer tjname;		// 统计字段,1年销售收入，2净值，3税额，4战略价金额
	private Double num;		// 总计
	private Double yiyue;		// 1月份的值
	private Double eryue;		// 2月份的值
	private Double sanyue;		// 3月份的值
	private Double siyue;		// 4月份的值
	private Double wuyue;		// 5月份的值
	private Double liuyue;		// 6月份的值
	private Double qiyue;		// 7月份的值
	private Double bayue;		// 8月份的值
	private Double jiuyue;		// 9月份的值
	private Double shiyue;		// 10月份的值
	private Double syyyue;		// 11月份的值
	private Double seyyue;		// 12月份的值
	private String beginNianfen;		// 开始 统计时间，单位：年
	private String endNianfen;		// 结束 统计时间，单位：年
	
	private String tableName; //表名
	
	public CCustsaleTj() {
		super();
	}

	public CCustsaleTj(String id){
		super(id);
	}
	@ExcelField(title="统计时间，单位：年", dictType="", align=2, sort=1)
	public Integer getNianfen() {
		return nianfen;
	}
	
	public void setNianfen(Integer nianfen) {
		this.nianfen = nianfen;
	}
	
	@ExcelField(title="查询名称，公司名称", align=2, sort=2)
	public String getCkname() {
		return ckname;
	}

	public void setCkname(String ckname) {
		this.ckname = ckname;
	}
	
	@NotNull(message="统计字段,1年销售收入，2净值，3税额，4战略价金额不能为空")
	@ExcelField(title="统计字段,1年销售收入，2净值，3税额，4战略价金额", dictType="", align=2, sort=3)
	public Integer getTjname() {
		return tjname;
	}

	public void setTjname(Integer tjname) {
		this.tjname = tjname;
	}
	
	@NotNull(message="总计不能为空")
	@ExcelField(title="总计", align=2, sort=4)
	public Double getNum() {
		return num;
	}

	public void setNum(Double num) {
		this.num = num;
	}
	
	@NotNull(message="1月份的值不能为空")
	@ExcelField(title="1月份的值", align=2, sort=5)
	public Double getYiyue() {
		return yiyue;
	}

	public void setYiyue(Double yiyue) {
		this.yiyue = yiyue;
	}
	
	@NotNull(message="2月份的值不能为空")
	@ExcelField(title="2月份的值", align=2, sort=6)
	public Double getEryue() {
		return eryue;
	}

	public void setEryue(Double eryue) {
		this.eryue = eryue;
	}
	
	@NotNull(message="3月份的值不能为空")
	@ExcelField(title="3月份的值", align=2, sort=7)
	public Double getSanyue() {
		return sanyue;
	}

	public void setSanyue(Double sanyue) {
		this.sanyue = sanyue;
	}
	
	@NotNull(message="4月份的值不能为空")
	@ExcelField(title="4月份的值", align=2, sort=8)
	public Double getSiyue() {
		return siyue;
	}

	public void setSiyue(Double siyue) {
		this.siyue = siyue;
	}
	
	@NotNull(message="5月份的值不能为空")
	@ExcelField(title="5月份的值", align=2, sort=9)
	public Double getWuyue() {
		return wuyue;
	}

	public void setWuyue(Double wuyue) {
		this.wuyue = wuyue;
	}
	
	@NotNull(message="6月份的值不能为空")
	@ExcelField(title="6月份的值", align=2, sort=10)
	public Double getLiuyue() {
		return liuyue;
	}

	public void setLiuyue(Double liuyue) {
		this.liuyue = liuyue;
	}
	
	@NotNull(message="7月份的值不能为空")
	@ExcelField(title="7月份的值", align=2, sort=11)
	public Double getQiyue() {
		return qiyue;
	}

	public void setQiyue(Double qiyue) {
		this.qiyue = qiyue;
	}
	
	@NotNull(message="8月份的值不能为空")
	@ExcelField(title="8月份的值", align=2, sort=12)
	public Double getBayue() {
		return bayue;
	}

	public void setBayue(Double bayue) {
		this.bayue = bayue;
	}
	
	@NotNull(message="9月份的值不能为空")
	@ExcelField(title="9月份的值", align=2, sort=13)
	public Double getJiuyue() {
		return jiuyue;
	}

	public void setJiuyue(Double jiuyue) {
		this.jiuyue = jiuyue;
	}
	
	@NotNull(message="10月份的值不能为空")
	@ExcelField(title="10月份的值", align=2, sort=14)
	public Double getShiyue() {
		return shiyue;
	}

	public void setShiyue(Double shiyue) {
		this.shiyue = shiyue;
	}
	
	@NotNull(message="11月份的值不能为空")
	@ExcelField(title="11月份的值", align=2, sort=15)
	public Double getSyyyue() {
		return syyyue;
	}

	public void setSyyyue(Double syyyue) {
		this.syyyue = syyyue;
	}
	
	@NotNull(message="12月份的值不能为空")
	@ExcelField(title="12月份的值", align=2, sort=16)
	public Double getSeyyue() {
		return seyyue;
	}

	public void setSeyyue(Double seyyue) {
		this.seyyue = seyyue;
	}
	
	public String getBeginNianfen() {
		return beginNianfen;
	}

	public void setBeginNianfen(String beginNianfen) {
		this.beginNianfen = beginNianfen;
	}
	
	public String getEndNianfen() {
		return endNianfen;
	}

	public void setEndNianfen(String endNianfen) {
		this.endNianfen = endNianfen;
	}
	
	public String getKhjm() {
		return khjm;
	}
	
	public void setKhjm(String khjm) {
		this.khjm = khjm;
	}
	
	public String getDaqu() {
		return daqu;
	}
	
	public void setDaqu(String daqu) {
		this.daqu = daqu;
	}
	
	public String getTableName() {
		return tableName;
	}
	
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	
	public Integer getYuefen() {
		return yuefen;
	}
	
	public void setYuefen(Integer yuefen) {
		this.yuefen = yuefen;
	}
	
	@Override
	public String toString() {
		return "CCustsaleTj{" +
				"nianfen=" + nianfen +
				", khjm='" + khjm + '\'' +
				", daqu='" + daqu + '\'' +
				", ckname='" + ckname + '\'' +
				", tjname=" + tjname +
				", num=" + num +
				", yiyue=" + yiyue +
				", eryue=" + eryue +
				", sanyue=" + sanyue +
				", siyue=" + siyue +
				", wuyue=" + wuyue +
				", liuyue=" + liuyue +
				", qiyue=" + qiyue +
				", bayue=" + bayue +
				", jiuyue=" + jiuyue +
				", shiyue=" + shiyue +
				", syyyue=" + syyyue +
				", seyyue=" + seyyue +
				", beginNianfen='" + beginNianfen + '\'' +
				", endNianfen='" + endNianfen + '\'' +
				", remarks='" + remarks + '\'' +
				", createBy=" + createBy +
				", createDate=" + createDate +
				", updateBy=" + updateBy +
				", updateDate=" + updateDate +
				", delFlag='" + delFlag + '\'' +
				'}';
	}
}