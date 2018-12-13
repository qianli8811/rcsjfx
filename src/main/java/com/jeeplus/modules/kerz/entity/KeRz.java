/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.kerz.entity;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import com.jeeplus.common.persistence.DataEntity;
import com.jeeplus.common.utils.excel.annotation.ExcelField;

/**
 * 客户融资Entity
 * @author admin
 * @version 2018-03-10
 */
public class KeRz extends DataEntity<KeRz> {
	
	private static final long serialVersionUID = 1L;
	private RcKhzl rckhzl;//客户资料
	
	private String rzjg;		// 融资机构
	private String rzje;		// 融资金额
	private Date rzjssj;		// 融资结束时间：格式xxxx年xx月xx日
	private Date rzkssj;		// 融资开始时间：格式xxxx年xx月xx日
	private String isJq;		// 是否已经结清
	private String rzlx;        //融资类型：0其它，1银行融资，2民间借贷，3保理融资，4自有资金,
	private Double zyje;        //自由资金推算：中粮销售额/周转次数除以销售占比减去银行融资
	
	public KeRz() {
		super();
	}

	public KeRz(String id){
		super(id);
	}

	@ExcelField(title="融资机构", align=2, sort=1)
	public String getRzjg() {
		return rzjg;
	}

	public void setRzjg(String rzjg) {
		this.rzjg = rzjg;
	}
	
	@ExcelField(title="融资金额", align=2, sort=2)
	public String getRzje() {
		return rzje;
	}

	public void setRzje(String rzje) {
		this.rzje = rzje;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="融资结束时间：格式xxxx年xx月xx日不能为空")
	@ExcelField(title="融资结束时间：格式xxxx年xx月xx日", align=2, sort=3)
	public Date getRzjssj() {
		return rzjssj;
	}

	public void setRzjssj(Date rzjssj) {
		this.rzjssj = rzjssj;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="融资开始时间：格式xxxx年xx月xx日不能为空")
	@ExcelField(title="融资开始时间：格式xxxx年xx月xx日", align=2, sort=4)
	public Date getRzkssj() {
		return rzkssj;
	}

	public void setRzkssj(Date rzkssj) {
		this.rzkssj = rzkssj;
	}
	
	@ExcelField(title="是否已经结清", dictType="", align=2, sort=5)
	public String getIsJq() {
		return isJq;
	}

	public void setIsJq(String isJq) {
		this.isJq = isJq;
	}
	
	public RcKhzl getRckhzl() {
		return rckhzl;
	}
	
	public void setRckhzl(RcKhzl rckhzl) {
		this.rckhzl = rckhzl;
	}
	
	public String getRzlx() {
		return rzlx;
	}
	
	public void setRzlx(String rzlx) {
		this.rzlx = rzlx;
	}
	
	public Double getZyje() {
		return zyje;
	}
	
	public void setZyje(Double zyje) {
		this.zyje = zyje;
	}
}