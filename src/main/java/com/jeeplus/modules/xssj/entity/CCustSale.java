/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.xssj.entity;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import com.jeeplus.common.persistence.DataEntity;
import com.jeeplus.common.utils.excel.annotation.ExcelField;

/**
 * 企业核心数据Entity
 * @author admin
 * @version 2018-03-03
 */
public class CCustSale extends DataEntity<CCustSale> {
	
	private static final long serialVersionUID = 1L;
	private String gongchang;		// 工厂
	private String daqu;		// 大区
	private String chengshi;		// 城市群
	private String yewuyuan;		// 业务员
	private String custNo;		// 客户代码
	private String custName;		// 客户名称
	private String dapinleimiaoshu;		// 大品类描述
	private String yijipinleimiaoshu;		// 一级品类描述
	private String erjipinleimiaoshu;		// 二级品类描述
	private String sanjipinleimiaoshu;		// 三级品类描述
	private String chanpinxianmiaoshu;		// 产品线描述
	private String wuliaobianma;		// 物料编码
	private String wuliaomiaoshu;		// 物料描述
	private Double xiang;		// 箱
	private Double dun;		// 吨
	private Double xiaoshoushouru;		// 销售收入
	private Double jingzhi;		// 净值
	private Double shuie;		// 税额
	private Double zhanlvjine;		// 战略价金额
	private Double zhekoujine;		// 折扣金额
	private Double zhekoubili;		// 折扣百分比
	private String shoudafangjiancheng;		// 售达方简称
	private Date fapiaoshiqi;		// 出具发票日期
	private String dingdanbianhao;		// 订单号码
	private Date danjuriqi;		// 单据日期
	private String kucundidian;		// 库存地点
	private String caigoubianhao;		// 采购订单号码
	private Date beginFapiaoshiqi;		// 开始 出具发票日期
	private Date endFapiaoshiqi;		// 结束 出具发票日期
	
	private String tableName;//表名
	
	public CCustSale() {
		super();
	}

	public CCustSale(String id){
		super(id);
	}

	@ExcelField(title="工厂", align=2, sort=1)
	public String getGongchang() {
		return gongchang;
	}

	public void setGongchang(String gongchang) {
		this.gongchang = gongchang;
	}
	
	@ExcelField(title="大区", align=2, sort=2)
	public String getDaqu() {
		return daqu;
	}

	public void setDaqu(String daqu) {
		this.daqu = daqu;
	}
	
	@ExcelField(title="城市群", align=2, sort=3)
	public String getChengshi() {
		return chengshi;
	}

	public void setChengshi(String chengshi) {
		this.chengshi = chengshi;
	}
	
	@ExcelField(title="业务员", align=2, sort=4)
	public String getYewuyuan() {
		return yewuyuan;
	}

	public void setYewuyuan(String yewuyuan) {
		this.yewuyuan = yewuyuan;
	}
	
	@ExcelField(title="客户代码", align=2, sort=5)
	public String getCustNo() {
		return custNo;
	}

	public void setCustNo(String custNo) {
		this.custNo = custNo;
	}
	
	@ExcelField(title="客户名称", align=2, sort=6)
	public String getCustName() {
		return custName;
	}

	public void setCustName(String custName) {
		this.custName = custName;
	}
	
	@ExcelField(title="大品类描述", align=2, sort=7)
	public String getDapinleimiaoshu() {
		return dapinleimiaoshu;
	}

	public void setDapinleimiaoshu(String dapinleimiaoshu) {
		this.dapinleimiaoshu = dapinleimiaoshu;
	}
	
	@ExcelField(title="一级品类描述", align=2, sort=8)
	public String getYijipinleimiaoshu() {
		return yijipinleimiaoshu;
	}

	public void setYijipinleimiaoshu(String yijipinleimiaoshu) {
		this.yijipinleimiaoshu = yijipinleimiaoshu;
	}
	
	@ExcelField(title="二级品类描述", align=2, sort=9)
	public String getErjipinleimiaoshu() {
		return erjipinleimiaoshu;
	}

	public void setErjipinleimiaoshu(String erjipinleimiaoshu) {
		this.erjipinleimiaoshu = erjipinleimiaoshu;
	}
	
	@ExcelField(title="三级品类描述", align=2, sort=10)
	public String getSanjipinleimiaoshu() {
		return sanjipinleimiaoshu;
	}

	public void setSanjipinleimiaoshu(String sanjipinleimiaoshu) {
		this.sanjipinleimiaoshu = sanjipinleimiaoshu;
	}
	
	@ExcelField(title="产品线描述", align=2, sort=11)
	public String getChanpinxianmiaoshu() {
		return chanpinxianmiaoshu;
	}

	public void setChanpinxianmiaoshu(String chanpinxianmiaoshu) {
		this.chanpinxianmiaoshu = chanpinxianmiaoshu;
	}
	
	@ExcelField(title="物料编码", align=2, sort=12)
	public String getWuliaobianma() {
		return wuliaobianma;
	}

	public void setWuliaobianma(String wuliaobianma) {
		this.wuliaobianma = wuliaobianma;
	}
	
	@ExcelField(title="物料描述", align=2, sort=13)
	public String getWuliaomiaoshu() {
		return wuliaomiaoshu;
	}

	public void setWuliaomiaoshu(String wuliaomiaoshu) {
		this.wuliaomiaoshu = wuliaomiaoshu;
	}
	
	@ExcelField(title="箱", align=2, sort=14)
	public Double getXiang() {
		return xiang;
	}

	public void setXiang(Double xiang) {
		this.xiang = xiang;
	}
	
	@ExcelField(title="吨", align=2, sort=15)
	public Double getDun() {
		return dun;
	}

	public void setDun(Double dun) {
		this.dun = dun;
	}
	
	@ExcelField(title="销售收入", align=2, sort=16)
	public Double getXiaoshoushouru() {
		return xiaoshoushouru;
	}

	public void setXiaoshoushouru(Double xiaoshoushouru) {
		this.xiaoshoushouru = xiaoshoushouru;
	}
	
	@ExcelField(title="净值", align=2, sort=17)
	public Double getJingzhi() {
		return jingzhi;
	}

	public void setJingzhi(Double jingzhi) {
		this.jingzhi = jingzhi;
	}
	
	@ExcelField(title="税额", align=2, sort=18)
	public Double getShuie() {
		return shuie;
	}

	public void setShuie(Double shuie) {
		this.shuie = shuie;
	}
	
	@ExcelField(title="战略价金额", align=2, sort=19)
	public Double getZhanlvjine() {
		return zhanlvjine;
	}

	public void setZhanlvjine(Double zhanlvjine) {
		this.zhanlvjine = zhanlvjine;
	}
	
	@ExcelField(title="折扣金额", align=2, sort=20)
	public Double getZhekoujine() {
		return zhekoujine;
	}

	public void setZhekoujine(Double zhekoujine) {
		this.zhekoujine = zhekoujine;
	}
	
	@ExcelField(title="折扣百分比", align=2, sort=21)
	public Double getZhekoubili() {
		return zhekoubili;
	}

	public void setZhekoubili(Double zhekoubili) {
		this.zhekoubili = zhekoubili;
	}
	
	@ExcelField(title="售达方简称", align=2, sort=22)
	public String getShoudafangjiancheng() {
		return shoudafangjiancheng;
	}

	public void setShoudafangjiancheng(String shoudafangjiancheng) {
		this.shoudafangjiancheng = shoudafangjiancheng;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="出具发票日期不能为空")
	@ExcelField(title="出具发票日期", align=2, sort=23)
	public Date getFapiaoshiqi() {
		return fapiaoshiqi;
	}

	public void setFapiaoshiqi(Date fapiaoshiqi) {
		this.fapiaoshiqi = fapiaoshiqi;
	}
	
	@ExcelField(title="订单号码", align=2, sort=24)
	public String getDingdanbianhao() {
		return dingdanbianhao;
	}

	public void setDingdanbianhao(String dingdanbianhao) {
		this.dingdanbianhao = dingdanbianhao;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="单据日期不能为空")
	@ExcelField(title="单据日期", align=2, sort=25)
	public Date getDanjuriqi() {
		return danjuriqi;
	}

	public void setDanjuriqi(Date danjuriqi) {
		this.danjuriqi = danjuriqi;
	}
	
	@ExcelField(title="库存地点", align=2, sort=26)
	public String getKucundidian() {
		return kucundidian;
	}

	public void setKucundidian(String kucundidian) {
		this.kucundidian = kucundidian;
	}
	
	@ExcelField(title="采购订单号码", align=2, sort=27)
	public String getCaigoubianhao() {
		return caigoubianhao;
	}

	public void setCaigoubianhao(String caigoubianhao) {
		this.caigoubianhao = caigoubianhao;
	}
	
	public Date getBeginFapiaoshiqi() {
		return beginFapiaoshiqi;
	}

	public void setBeginFapiaoshiqi(Date beginFapiaoshiqi) {
		this.beginFapiaoshiqi = beginFapiaoshiqi;
	}
	
	public Date getEndFapiaoshiqi() {
		return endFapiaoshiqi;
	}

	public void setEndFapiaoshiqi(Date endFapiaoshiqi) {
		this.endFapiaoshiqi = endFapiaoshiqi;
	}
	
	public String getTableName() {
		return tableName;
	}
	
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	
	@Override
	public String toString() {
		return "CCustSale{" +
				"gongchang='" + gongchang + '\'' +
				", daqu='" + daqu + '\'' +
				", chengshi='" + chengshi + '\'' +
				", yewuyuan='" + yewuyuan + '\'' +
				", custNo='" + custNo + '\'' +
				", custName='" + custName + '\'' +
				", dapinleimiaoshu='" + dapinleimiaoshu + '\'' +
				", yijipinleimiaoshu='" + yijipinleimiaoshu + '\'' +
				", erjipinleimiaoshu='" + erjipinleimiaoshu + '\'' +
				", sanjipinleimiaoshu='" + sanjipinleimiaoshu + '\'' +
				", chanpinxianmiaoshu='" + chanpinxianmiaoshu + '\'' +
				", wuliaobianma='" + wuliaobianma + '\'' +
				", wuliaomiaoshu='" + wuliaomiaoshu + '\'' +
				", xiang='" + xiang + '\'' +
				", dun='" + dun + '\'' +
				", xiaoshoushouru='" + xiaoshoushouru + '\'' +
				", jingzhi='" + jingzhi + '\'' +
				", shuie='" + shuie + '\'' +
				", zhanlvjine='" + zhanlvjine + '\'' +
				", zhekoujine='" + zhekoujine + '\'' +
				", zhekoubili='" + zhekoubili + '\'' +
				", shoudafangjiancheng='" + shoudafangjiancheng + '\'' +
				", fapiaoshiqi=" + fapiaoshiqi +
				", dingdanbianhao='" + dingdanbianhao + '\'' +
				", danjuriqi=" + danjuriqi +
				", kucundidian='" + kucundidian + '\'' +
				", caigoubianhao='" + caigoubianhao + '\'' +
				", beginFapiaoshiqi=" + beginFapiaoshiqi +
				", endFapiaoshiqi=" + endFapiaoshiqi +
				", delFlag='" + delFlag + '\'' +
				", id='" + id + '\'' +
				'}';
	}
}