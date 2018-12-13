/**
 * Copyright &copy; 2015-2020 <a href="http://www.xiaostarstar.com/">XSS</a> All rights reserved.
 */
package com.jeeplus.modules.fptj.entity;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import com.jeeplus.common.persistence.DataEntity;
import com.jeeplus.common.utils.excel.annotation.ExcelField;

/**
 * 开票汇总统计Entity
 * @author admin
 * @version 2018-03-12
 */
public class KphzTj extends DataEntity<KphzTj> {
	
	private static final long serialVersionUID = 1L;
	private String tjxm;		// 项目
	private String yqsl;		// 17税率
	private String yysl;		// 11税率
	private String liusl;		// 6税率
	private String lingsl;		// 0税率
	private Date kprq;		// 开票时间
	private Date beginKprq;		// 开始 开票时间
	private Date endKprq;		// 结束 开票时间
	
	public KphzTj() {
		super();
	}

	public KphzTj(String id){
		super(id);
	}

	@ExcelField(title="项目", align=2, sort=1)
	public String getTjxm() {
		return tjxm;
	}

	public void setTjxm(String tjxm) {
		this.tjxm = tjxm;
	}
	
	@ExcelField(title="17税率", align=2, sort=2)
	public String getYqsl() {
		return yqsl;
	}

	public void setYqsl(String yqsl) {
		this.yqsl = yqsl;
	}
	
	@ExcelField(title="11税率", align=2, sort=3)
	public String getYysl() {
		return yysl;
	}

	public void setYysl(String yysl) {
		this.yysl = yysl;
	}
	
	@ExcelField(title="6税率", align=2, sort=4)
	public String getLiusl() {
		return liusl;
	}

	public void setLiusl(String liusl) {
		this.liusl = liusl;
	}
	
	@ExcelField(title="0税率", align=2, sort=5)
	public String getLingsl() {
		return lingsl;
	}

	public void setLingsl(String lingsl) {
		this.lingsl = lingsl;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="开票时间不能为空")
	@ExcelField(title="开票时间", align=2, sort=6)
	public Date getKprq() {
		return kprq;
	}

	public void setKprq(Date kprq) {
		this.kprq = kprq;
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
		
}