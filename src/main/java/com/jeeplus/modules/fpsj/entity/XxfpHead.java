/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.fpsj.entity;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import com.jeeplus.common.persistence.DataEntity;
import com.jeeplus.common.utils.excel.annotation.ExcelField;

/**
 * 发票数据Entity
 * @author admin
 * @version 2018-02-24
 */
public class XxfpHead extends DataEntity<XxfpHead> {
	
	private static final long serialVersionUID = 1L;
	private String fphm;		// 金税发票号码
	private Date kprq;		// 开票日期  2017-09-22
	private String khsh;		// 客户税号
	private String khmc;		// 客户名称
	private String khdz;		// 客户地址
	private String khkhyhzh;		// 客户银行账号
	private String bz;		// 发票备注
	private String kpr;		// 开票人
	private String skr;		// 收款人
	private String fhr;		// 复核人
	private String zfbz;		// 作废标志
	private String kplx;		// 开票类型 0--专票  1--普票
	private String zbhsje;		// 合计不含税金额
	private String zse;		// 合计税额
	private String jshj;		// 合计价税合计
	private String skjbh;		// 分机号
	private String qysh;		// 开票方税号
	private String qymc;        //开票方名称
	private String qydz;        //开票方地址
	private String qykhyhzh;		// 开票方银行账号
	
	private String isUpdate;		// 强制更新0--不强制更新  1--强制更新
	
	
	private Date beginKprq;		// 开始 开票日期  2017-09-22
	private Date endKprq;		// 结束 开票日期  2017-09-22
	
	private Date xzrq;//下载日期
	
	public XxfpHead() {
		super();
	}

	public XxfpHead(String id){
		super(id);
	}

	@ExcelField(title="金税发票号码", align=2, sort=1)
	public String getFphm() {
		return fphm;
	}

	public void setFphm(String fphm) {
		this.fphm = fphm;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="开票日期  2017-09-22不能为空")
	@ExcelField(title="开票日期", align=2, sort=2)
	public Date getKprq() {
		return kprq;
	}

	public void setKprq(Date kprq) {
		this.kprq = kprq;
	}
	
	@ExcelField(title="客户税号", align=2, sort=3)
	public String getKhsh() {
		return khsh;
	}

	public void setKhsh(String khsh) {
		this.khsh = khsh;
	}
	
	@ExcelField(title="客户名称", align=2, sort=4)
	public String getKhmc() {
		return khmc;
	}

	public void setKhmc(String khmc) {
		this.khmc = khmc;
	}
	
	@ExcelField(title="客户地址", align=2, sort=5)
	public String getKhdz() {
		return khdz;
	}

	public void setKhdz(String khdz) {
		this.khdz = khdz;
	}
	
	@ExcelField(title="客户银行账号", align=2, sort=6)
	public String getKhkhyhzh() {
		return khkhyhzh;
	}

	public void setKhkhyhzh(String khkhyhzh) {
		this.khkhyhzh = khkhyhzh;
	}
	
	@ExcelField(title="发票备注", align=2, sort=7)
	public String getBz() {
		return bz;
	}

	public void setBz(String bz) {
		this.bz = bz;
	}
	
	@ExcelField(title="开票人", align=2, sort=8)
	public String getKpr() {
		return kpr;
	}

	public void setKpr(String kpr) {
		this.kpr = kpr;
	}
	
	@ExcelField(title="收款人", align=2, sort=9)
	public String getSkr() {
		return skr;
	}

	public void setSkr(String skr) {
		this.skr = skr;
	}
	
	@ExcelField(title="复核人", align=2, sort=10)
	public String getFhr() {
		return fhr;
	}

	public void setFhr(String fhr) {
		this.fhr = fhr;
	}
	
	@ExcelField(title="作废标志", align=2, sort=11)
	public String getZfbz() {
		return zfbz;
	}

	public void setZfbz(String zfbz) {
		this.zfbz = zfbz;
	}
	
	@ExcelField(title="开票类型", dictType="", align=2, sort=12)
	public String getKplx() {
		return kplx;
	}

	public void setKplx(String kplx) {
		this.kplx = kplx;
	}
	
	@ExcelField(title="合计不含税金额", align=2, sort=13)
	public String getZbhsje() {
		return zbhsje;
	}

	public void setZbhsje(String zbhsje) {
		this.zbhsje = zbhsje;
	}
	
	@ExcelField(title="合计税额", align=2, sort=14)
	public String getZse() {
		return zse;
	}

	public void setZse(String zse) {
		this.zse = zse;
	}
	
	@ExcelField(title="合计价税合计", align=2, sort=15)
	public String getJshj() {
		return jshj;
	}

	public void setJshj(String jshj) {
		this.jshj = jshj;
	}
	
	@ExcelField(title="分机号", align=2, sort=16)
	public String getSkjbh() {
		return skjbh;
	}

	public void setSkjbh(String skjbh) {
		this.skjbh = skjbh;
	}
	
	@ExcelField(title="开票方税号", align=2, sort=17)
	public String getQysh() {
		return qysh;
	}

	public void setQysh(String qysh) {
		this.qysh = qysh;
	}
	
	@ExcelField(title="开票方银行账号", align=2, sort=18)
	public String getQykhyhzh() {
		return qykhyhzh;
	}

	public void setQykhyhzh(String qykhyhzh) {
		this.qykhyhzh = qykhyhzh;
	}
	
	@ExcelField(title="强制更新", align=2, sort=19)
	public String getIsUpdate() {
		return isUpdate;
	}

	public void setIsUpdate(String isUpdate) {
		this.isUpdate = isUpdate;
	}
	
	public Date getBeginKprq() {
		return beginKprq;
	}
	
	public void setBeginKprq(Date beginKprq) {
		this.beginKprq = beginKprq;
	}
	
	public Date getEndKprq() {
		return endKprq;
	}
	
	public void setEndKprq(Date endKprq) {
		this.endKprq = endKprq;
	}
	
	public String getQymc() {
		return qymc;
	}
	
	public void setQymc(String qymc) {
		this.qymc = qymc;
	}
	@ExcelField(title="开票方地址", align=2, sort=20)
	public String getQydz() {
		return qydz;
	}
	
	public void setQydz(String qydz) {
		this.qydz = qydz;
	}
	
	public Date getXzrq() {
		return xzrq;
	}
	
	public void setXzrq(Date xzrq) {
		this.xzrq = xzrq;
	}
}