/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.fpsj.entity;


import com.jeeplus.common.persistence.DataEntity;
import com.jeeplus.common.utils.excel.annotation.ExcelField;

/**
 * 发票数据Entity
 * @author admin
 * @version 2018-02-24
 */
public class XxfpItem extends DataEntity<XxfpItem> {
	
	private static final long serialVersionUID = 1L;
	private XxfpHead xxfpHead;		// 销项发票head编号
	
	private String fphm;		// 金税发票号码
	private String mxxh;		// 明细行号
	private String cpmc;		// 商品名称
	private String cpxh;		// 规格型号
	private String cpdw;		// 单位
	private String cpsl;		// 数量
	private String cpdj;		// 不含税单价
	private String bhsje;		// 不含税金额
	private String sl;		// 税率
	private String se;		// 税额
	private String hsje;		// 含税金额
	
	public XxfpItem() {
		super();
	}

	public XxfpItem(String id){
		super(id);
	}
	
	public XxfpHead getXxfpHead() {
		return xxfpHead;
	}
	
	public void setXxfpHead(XxfpHead xxfpHead) {
		this.xxfpHead = xxfpHead;
	}
	
	@ExcelField(title="金税发票号码", align=2, sort=2)
	public String getFphm() {
		return fphm;
	}

	public void setFphm(String fphm) {
		this.fphm = fphm;
	}
	
	@ExcelField(title="明细行号", align=2, sort=3)
	public String getMxxh() {
		return mxxh;
	}

	public void setMxxh(String mxxh) {
		this.mxxh = mxxh;
	}
	
	@ExcelField(title="商品名称", align=2, sort=4)
	public String getCpmc() {
		return cpmc;
	}

	public void setCpmc(String cpmc) {
		this.cpmc = cpmc;
	}
	
	@ExcelField(title="规格型号", align=2, sort=5)
	public String getCpxh() {
		return cpxh;
	}

	public void setCpxh(String cpxh) {
		this.cpxh = cpxh;
	}
	
	@ExcelField(title="单位", align=2, sort=6)
	public String getCpdw() {
		return cpdw;
	}

	public void setCpdw(String cpdw) {
		this.cpdw = cpdw;
	}
	
	@ExcelField(title="数量", align=2, sort=7)
	public String getCpsl() {
		return cpsl;
	}

	public void setCpsl(String cpsl) {
		this.cpsl = cpsl;
	}
	
	@ExcelField(title="不含税单价", align=2, sort=8)
	public String getCpdj() {
		return cpdj;
	}

	public void setCpdj(String cpdj) {
		this.cpdj = cpdj;
	}
	
	@ExcelField(title="不含税金额", align=2, sort=9)
	public String getBhsje() {
		return bhsje;
	}

	public void setBhsje(String bhsje) {
		this.bhsje = bhsje;
	}
	
	@ExcelField(title="税率", align=2, sort=10)
	public String getSl() {
		return sl;
	}

	public void setSl(String sl) {
		this.sl = sl;
	}
	
	@ExcelField(title="税额", align=2, sort=11)
	public String getSe() {
		return se;
	}

	public void setSe(String se) {
		this.se = se;
	}
	
	@ExcelField(title="含税金额", align=2, sort=12)
	public String getHsje() {
		return hsje;
	}

	public void setHsje(String hsje) {
		this.hsje = hsje;
	}
	
	
}