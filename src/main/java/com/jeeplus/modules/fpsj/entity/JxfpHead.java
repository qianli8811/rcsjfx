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
public class JxfpHead extends DataEntity<JxfpHead> {
	
	private static final long serialVersionUID = 1L;
	private String fpdm;		// 发票代码
	private String fphm;		// 发票号码
	
	private String rzbz;        //是否已经认证 ，1为已经认证，其他为未认证
	private String rzssy;       //认证月份 格式： 201802
	
	private Date beginRzssy;		// 开始 认证日期  2017-09-22
	private Date endRzssy;		// 结束 认证日期  2017-09-22
	
	private String fpzf;		// 作废 0--正常  1--作废
	private String kplx;		// 开票类型 0--专票  1--普票
	private String gmfmc;		// 购买方名称
	private String gmfsh;		// 购买方税号
	private String gmfdz;		// 购买方地址
	private String gmfyhzh;		// 购买方银行账号
	private String hjbhsje;		// 合计不含税金额 发票金额
	private String hjhsje;		// 合计含税金额
	private String hjse;		// 合计税额 发票税额
	private Date kprq;		// 开票日期  2017-09-22
	//private String xsfh;		// 销方税号
	private String xsfmc;		// 销方名称
	private String xsfsh;		// 销方税号
	private String xsfdz;		// 销方地址
	private String xsyhzh;		// 销方银行账号
	private String bz;		// 备注
	private String isUpdate;		// 强制更新  0--不强制更新  1--强制更新
	private Date beginKprq;		// 开始 开票日期  2017-09-22
	private Date endKprq;		// 结束 开票日期  2017-09-22
	
	private Date beginJlrq;// 开始 记录日期
	private Date endJlrq;// 结束 记录日期
	
	private Date xzrq;//下载日期
	
	public JxfpHead() {
		super();
	}

	public JxfpHead(String id){
		super(id);
	}

	@ExcelField(title="发票代码", align=2, sort=1)
	public String getFpdm() {
		return fpdm;
	}

	public void setFpdm(String fpdm) {
		this.fpdm = fpdm;
	}
	
	@ExcelField(title="发票号码", align=2, sort=2)
	public String getFphm() {
		return fphm;
	}

	public void setFphm(String fphm) {
		this.fphm = fphm;
	}
	
	
	
	@ExcelField(title="作废标志", align=2, sort=3)
	public String getFpzf() {
		return fpzf;
	}

	public void setFpzf(String fpzf) {
		this.fpzf = fpzf;
	}
	
	@ExcelField(title="开票类型", align=2, sort=4)
	public String getKplx() {
		return kplx;
	}

	public void setKplx(String kplx) {
		this.kplx = kplx;
	}
	
	@ExcelField(title="购买方名称", align=2, sort=5)
	public String getGmfmc() {
		return gmfmc;
	}

	public void setGmfmc(String gmfmc) {
		this.gmfmc = gmfmc;
	}
	
	@ExcelField(title="购买方税号", align=2, sort=6)
	public String getGmfsh() {
		return gmfsh;
	}

	public void setGmfsh(String gmfsh) {
		this.gmfsh = gmfsh;
	}
	
	@ExcelField(title="购买方地址", align=2, sort=7)
	public String getGmfdz() {
		return gmfdz;
	}

	public void setGmfdz(String gmfdz) {
		this.gmfdz = gmfdz;
	}
	
	@ExcelField(title="购买方银行账号", align=2, sort=8)
	public String getGmfyhzh() {
		return gmfyhzh;
	}

	public void setGmfyhzh(String gmfyhzh) {
		this.gmfyhzh = gmfyhzh;
	}
	
	@ExcelField(title="合计不含税金额", align=2, sort=9)
	public String getHjbhsje() {
		return hjbhsje;
	}

	public void setHjbhsje(String hjbhsje) {
		this.hjbhsje = hjbhsje;
	}
	
	@ExcelField(title="合计含税金额", align=2, sort=10)
	public String getHjhsje() {
		return hjhsje;
	}

	public void setHjhsje(String hjhsje) {
		this.hjhsje = hjhsje;
	}
	
	@ExcelField(title="合计税额", align=2, sort=11)
	public String getHjse() {
		return hjse;
	}

	public void setHjse(String hjse) {
		this.hjse = hjse;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="开票日期  2017-09-22不能为空")
	@ExcelField(title="开票日期", align=2, sort=12)
	public Date getKprq() {
		return kprq;
	}

	public void setKprq(Date kprq) {
		this.kprq = kprq;
	}
	
	/*@ExcelField(title="销方税号", align=2, sort=14)
	public String getXsfh() {
		return xsfh;
	}

	public void setXsfh(String xsfh) {
		this.xsfh = xsfh;
	}*/
	
	@ExcelField(title="销方名称", align=2, sort=15)
	public String getXsfmc() {
		return xsfmc;
	}

	public void setXsfmc(String xsfmc) {
		this.xsfmc = xsfmc;
	}
	
	@ExcelField(title="用户头像", align=2, sort=16)
	public String getXsfsh() {
		return xsfsh;
	}

	public void setXsfsh(String xsfsh) {
		this.xsfsh = xsfsh;
	}
	
	@ExcelField(title="销方地址", align=2, sort=17)
	public String getXsfdz() {
		return xsfdz;
	}

	public void setXsfdz(String xsfdz) {
		this.xsfdz = xsfdz;
	}
	
	@ExcelField(title="销方银行账号", align=2, sort=18)
	public String getXsyhzh() {
		return xsyhzh;
	}

	public void setXsyhzh(String xsyhzh) {
		this.xsyhzh = xsyhzh;
	}
	
	@ExcelField(title="备注", align=2, sort=19)
	public String getBz() {
		return bz;
	}

	public void setBz(String bz) {
		this.bz = bz;
	}
	
	@ExcelField(title="是否更新", align=2, sort=20)
	public String getIsUpdate() {
		return isUpdate;
	}
	
	public String getRzbz() {
		return rzbz;
	}
	
	public void setRzbz(String rzbz) {
		this.rzbz = rzbz;
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
	
	public Date getBeginJlrq() {
		return beginJlrq;
	}
	
	public void setBeginJlrq(Date beginJlrq) {
		this.beginJlrq = beginJlrq;
	}
	
	public Date getEndJlrq() {
		return endJlrq;
	}
	
	public void setEndJlrq(Date endJlrq) {
		this.endJlrq = endJlrq;
	}
	
	public String getRzssy() {
		return rzssy;
	}
	
	public void setRzssy(String rzssy) {
		this.rzssy = rzssy;
	}
	
	public Date getBeginRzssy() {
		return beginRzssy;
	}
	
	public void setBeginRzssy(Date beginRzssy) {
		this.beginRzssy = beginRzssy;
	}
	
	public Date getEndRzssy() {
		return endRzssy;
	}
	
	public void setEndRzssy(Date endRzssy) {
		this.endRzssy = endRzssy;
	}
	
	public Date getXzrq() {
		return xzrq;
	}
	
	public void setXzrq(Date xzrq) {
		this.xzrq = xzrq;
	}
}