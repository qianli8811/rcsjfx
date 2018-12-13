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
public class JxfpItem extends DataEntity<JxfpItem> {
	
	private static final long serialVersionUID = 1L;
	private JxfpHead jxfpHead;		// 进项发票head编号
	private String hxmh;        //行目行号，与发票head编号 确立唯一性
	private String hwmc;		// 货物名称
	private String ggxh;		// 规格型号
	private String bhsje;		// 不含税金额
	private String bhsdj;		// 不含税单价
	private String hsdj;		// 含税单价
	private String hsje;		// 含税金额
	private String se;		// 税额
	private String xmsl;		// 数量
	private String dw;		// 单位
	private String sl;		// 税率
	
	public JxfpItem() {
		super();
	}

	public JxfpItem(String id){
		super(id);
	}
	
	public JxfpHead getJxfpHead() {
		return jxfpHead;
	}
	
	public void setJxfpHead(JxfpHead jxfpHead) {
		this.jxfpHead = jxfpHead;
	}
	
	
	@ExcelField(title="行目行号", align=2, sort=2)
	public String getHxmh() {
		return hxmh;
	}
	
	public void setHxmh(String hxmh) {
		this.hxmh = hxmh;
	}
	
	@ExcelField(title="货物名称", align=2, sort=3)
	public String getHwmc() {
		return hwmc;
	}

	public void setHwmc(String hwmc) {
		this.hwmc = hwmc;
	}
	
	@ExcelField(title="规格型号", align=2, sort=4)
	public String getGgxh() {
		return ggxh;
	}

	public void setGgxh(String ggxh) {
		this.ggxh = ggxh;
	}
	
	@ExcelField(title="不含税金额", align=2, sort=5)
	public String getBhsje() {
		return bhsje;
	}

	public void setBhsje(String bhsje) {
		this.bhsje = bhsje;
	}
	
	@ExcelField(title="不含税单价", align=2, sort=6)
	public String getBhsdj() {
		return bhsdj;
	}

	public void setBhsdj(String bhsdj) {
		this.bhsdj = bhsdj;
	}
	
	@ExcelField(title="含税单价", align=2, sort=7)
	public String getHsdj() {
		return hsdj;
	}

	public void setHsdj(String hsdj) {
		this.hsdj = hsdj;
	}
	
	@ExcelField(title="含税金额", align=2, sort=8)
	public String getHsje() {
		return hsje;
	}

	public void setHsje(String hsje) {
		this.hsje = hsje;
	}
	
	@ExcelField(title="税额", align=2, sort=9)
	public String getSe() {
		return se;
	}

	public void setSe(String se) {
		this.se = se;
	}
	
	@ExcelField(title="数量", align=2, sort=10)
	public String getXmsl() {
		return xmsl;
	}

	public void setXmsl(String xmsl) {
		this.xmsl = xmsl;
	}
	
	@ExcelField(title="单位", align=2, sort=11)
	public String getDw() {
		return dw;
	}

	public void setDw(String dw) {
		this.dw = dw;
	}
	
	@ExcelField(title="税率", align=2, sort=12)
	public String getSl() {
		return sl;
	}

	public void setSl(String sl) {
		this.sl = sl;
	}
	
	
}