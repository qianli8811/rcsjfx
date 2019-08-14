/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.jeeplus.modules.kerz.entity;


import com.jeeplus.common.persistence.TreeEntity;
import com.jeeplus.common.utils.StringUtils;

/**
 * 客户管理Entity
 * @author admin
 * @version 2018-03-16
 */
public class RcGd extends TreeEntity<RcGd> {
	
	private static final long serialVersionUID = 1L;
	/*private RcGd parent;		// 父级编号
	private String parentIds;		// 所有父级编号*/
	private RcKhzl rcKhzl;		// 客户资料id
	private String khlx;		// 类型：0无，1股东，2实际控股人，3法人
	private String zgb;		// 占股比
	private String gdxm;		// 姓名
	private String sfzh;		// 身份证号
	private String xb;		// 性别,1男，2女
	private String nl;		// 年龄
	private String isDbr;		// 是否是担保
	private String jtcy;		// 股东家属信息：0本人，1配偶，2女儿，3儿子，4兄弟，5姐妹，6父母，7表兄弟，8表姐妹
	
	public String getKhlxName(){
		if(StringUtils.isNotBlank(khlx)){
			if(khlx.equals("0")){
				return "";
			}else if(khlx.equals("1")){
				return "股东";
			}else if(khlx.equals("2")){
				return "实际控股人";
			}else if(khlx.equals("3")){
				return "法人";
			}
		}
		return "";
	}
	
	public String getXbName(){
		if(StringUtils.isNotBlank(xb)){
			if(xb.equals("1")){
				return "男";
			}else if(xb.equals("2")){
				return "女";
			}
		}
		return "";
	}
	public String getJtcyName(){
		if(StringUtils.isNotBlank(jtcy)){
			if(jtcy.equals("0")){
				return "本人";
			}else if(jtcy.equals("1")){
				return "配偶";
			}else if(jtcy.equals("2")){
				return "女儿";
			}else if(jtcy.equals("3")){
				return "儿子";
			}}else if(jtcy.equals("4")){
				return "兄弟";
			}else if(jtcy.equals("5")){
				return "姐妹";
			}else if(jtcy.equals("6")){
				return "父母";
			}else if(jtcy.equals("7")){
				return "朋友";
			}else {
				return "其它";
			}
		return "";
	}
	public String getIsDbrName(){
		if(StringUtils.isNotBlank(isDbr)){
			if(isDbr.equals("1")){
				return "是";
			}else if(isDbr.equals("0")){
				return "否";
			}
		}
		return "";
	}
	
	public RcGd() {
		super();
	}

	public RcGd(String id){
		super(id);
	}

	public RcGd getParent() {
		return parent;
	}

	public void setParent(RcGd parent) {
		this.parent = parent;
	}
	
	public String getParentIds() {
		return parentIds;
	}

	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}
	
	public RcKhzl getRcKhzl() {
		return rcKhzl;
	}

	public void setKhzl(RcKhzl rcKhzl) {
		this.rcKhzl = rcKhzl;
	}
	
	public String getKhlx() {
		return khlx;
	}

	public void setKhlx(String khlx) {
		this.khlx = khlx;
	}
	
	public String getZgb() {
		return zgb;
	}

	public void setZgb(String zgb) {
		this.zgb = zgb;
	}
	
	public String getGdxm() {
		return gdxm;
	}

	public void setGdxm(String gdxm) {
		this.gdxm = gdxm;
	}
	
	public String getSfzh() {
		return sfzh;
	}

	public void setSfzh(String sfzh) {
		this.sfzh = sfzh;
	}
	
	public String getXb() {
		return xb;
	}

	public void setXb(String xb) {
		this.xb = xb;
	}
	
	public String getNl() {
		return nl;
	}

	public void setNl(String nl) {
		this.nl = nl;
	}
	
	public String getIsDbr() {
		return isDbr;
	}

	public void setIsDbr(String isDbr) {
		this.isDbr = isDbr;
	}
	
	public String getJtcy() {
		return jtcy;
	}

	public void setJtcy(String jtcy) {
		this.jtcy = jtcy;
	}
	
	public String getParentId() {
		return parent != null && parent.getId() != null ? parent.getId() : "0";
	}
	
	public void setRcKhzl(RcKhzl rcKhzl) {
		this.rcKhzl = rcKhzl;
	}

	@Override
	public String toString() {
		return "RcGd{" +
				"rcKhzl=" + rcKhzl +
				", khlx='" + khlx + '\'' +
				", zgb='" + zgb + '\'' +
				", gdxm='" + gdxm + '\'' +
				", sfzh='" + sfzh + '\'' +
				", xb='" + xb + '\'' +
				", nl='" + nl + '\'' +
				", isDbr='" + isDbr + '\'' +
				", jtcy='" + jtcy + '\'' +
				'}';
	}
}