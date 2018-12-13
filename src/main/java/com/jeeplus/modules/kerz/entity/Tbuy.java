package com.jeeplus.modules.kerz.entity;


import com.jeeplus.common.persistence.DataEntity;

import java.util.Date;

public class Tbuy extends DataEntity<Tbuy> {
	
	
	private String name  ;
	private String code  ;
	private String city;
	private int areaclass;
	private String address;
	private String postcode;
	private String homepage     ;
	private String linkname     ;
	private String tel     ;
	private String mobile     ;
	private String email     ;
	private String bank     ;
	private String bankno     ;
	private int usertype ;
	private char sfcode     ;
	private int clienttype ;
	private int trackstu ;
	private int yxclass ;
	private Date recorddate;
	private int salerid ;
	private int sex ;
	private String fax     ;
	private String taxcode     ;
	private String sfsn     ;
	private String jgsn     ;
	private String linktel     ;
	private String desp     ;
	private Date trackDate;
	private Date preholdstart;
	private Date preholdend;
	private int clientusefor ;
	private String namejc     ;
	private String fr     ;
	private String zczb     ;
	private String jyfw     ;
	private int ywjbid ;
	private String company     ;
	private int sxtype ;
	private int sxlimit ;
	private Date sxlimitDate;
	private Date sxlimitDatee;
	private int xypjid ;
	private int zdgzstu ;
	private String infofrom     ;
	private int usestu ;
	private Date recDate;
	private int age ;
	private String mainclass     ;
	private String clientclass     ;
	private String hassonvar     ;
	private String isjhvar     ;
	private String tuanduivar     ;
	private String producttypevar     ;
	private String qdvar     ;
	private String xlvar     ;
	private String companyadd     ;
	private String clientcode     ;
	private String largearea     ;
	private String hxgoodsrate     ;
	private String gdnumvar     ;
	
	
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getCode() {
		return code;
	}
	
	public void setCode(String code) {
		this.code = code;
	}
	
	public String getCity() {
		return city;
	}
	
	public void setCity(String city) {
		this.city = city;
	}
	
	public int getAreaclass() {
		return areaclass;
	}
	
	public void setAreaclass(int areaclass) {
		this.areaclass = areaclass;
	}
	
	public String getAddress() {
		return address;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getPostcode() {
		return postcode;
	}
	
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	
	public String getHomepage() {
		return homepage;
	}
	
	public void setHomepage(String homepage) {
		this.homepage = homepage;
	}
	
	public String getLinkname() {
		return linkname;
	}
	
	public void setLinkname(String linkname) {
		this.linkname = linkname;
	}
	
	public String getTel() {
		return tel;
	}
	
	public void setTel(String tel) {
		this.tel = tel;
	}
	
	public String getMobile() {
		return mobile;
	}
	
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getBank() {
		return bank;
	}
	
	public void setBank(String bank) {
		this.bank = bank;
	}
	
	public String getBankno() {
		return bankno;
	}
	
	public void setBankno(String bankno) {
		this.bankno = bankno;
	}
	
	public int getUsertype() {
		return usertype;
	}
	
	public void setUsertype(int usertype) {
		this.usertype = usertype;
	}
	
	public char getSfcode() {
		return sfcode;
	}
	
	public void setSfcode(char sfcode) {
		this.sfcode = sfcode;
	}
	
	public int getClienttype() {
		return clienttype;
	}
	
	public void setClienttype(int clienttype) {
		this.clienttype = clienttype;
	}
	
	public int getTrackstu() {
		return trackstu;
	}
	
	public void setTrackstu(int trackstu) {
		this.trackstu = trackstu;
	}
	
	public int getYxclass() {
		return yxclass;
	}
	
	public void setYxclass(int yxclass) {
		this.yxclass = yxclass;
	}
	
	public Date getRecorddate() {
		return recorddate;
	}
	
	public void setRecorddate(Date recorddate) {
		this.recorddate = recorddate;
	}
	
	public int getSalerid() {
		return salerid;
	}
	
	public void setSalerid(int salerid) {
		this.salerid = salerid;
	}
	
	public int getSex() {
		return sex;
	}
	
	public void setSex(int sex) {
		this.sex = sex;
	}
	
	public String getFax() {
		return fax;
	}
	
	public void setFax(String fax) {
		this.fax = fax;
	}
	
	public String getTaxcode() {
		return taxcode;
	}
	
	public void setTaxcode(String taxcode) {
		this.taxcode = taxcode;
	}
	
	public String getSfsn() {
		return sfsn;
	}
	
	public void setSfsn(String sfsn) {
		this.sfsn = sfsn;
	}
	
	public String getJgsn() {
		return jgsn;
	}
	
	public void setJgsn(String jgsn) {
		this.jgsn = jgsn;
	}
	
	public String getLinktel() {
		return linktel;
	}
	
	public void setLinktel(String linktel) {
		this.linktel = linktel;
	}
	
	public String getDesp() {
		return desp;
	}
	
	public void setDesp(String desp) {
		this.desp = desp;
	}
	
	public Date getTrackDate() {
		return trackDate;
	}
	
	public void setTrackDate(Date trackDate) {
		this.trackDate = trackDate;
	}
	
	public Date getPreholdstart() {
		return preholdstart;
	}
	
	public void setPreholdstart(Date preholdstart) {
		this.preholdstart = preholdstart;
	}
	
	public Date getPreholdend() {
		return preholdend;
	}
	
	public void setPreholdend(Date preholdend) {
		this.preholdend = preholdend;
	}
	
	public int getClientusefor() {
		return clientusefor;
	}
	
	public void setClientusefor(int clientusefor) {
		this.clientusefor = clientusefor;
	}
	
	public String getNamejc() {
		return namejc;
	}
	
	public void setNamejc(String namejc) {
		this.namejc = namejc;
	}
	
	public String getFr() {
		return fr;
	}
	
	public void setFr(String fr) {
		this.fr = fr;
	}
	
	public String getZczb() {
		return zczb;
	}
	
	public void setZczb(String zczb) {
		this.zczb = zczb;
	}
	
	public String getJyfw() {
		return jyfw;
	}
	
	public void setJyfw(String jyfw) {
		this.jyfw = jyfw;
	}
	
	public int getYwjbid() {
		return ywjbid;
	}
	
	public void setYwjbid(int ywjbid) {
		this.ywjbid = ywjbid;
	}
	
	public String getCompany() {
		return company;
	}
	
	public void setCompany(String company) {
		this.company = company;
	}
	
	public int getSxtype() {
		return sxtype;
	}
	
	public void setSxtype(int sxtype) {
		this.sxtype = sxtype;
	}
	
	public int getSxlimit() {
		return sxlimit;
	}
	
	public void setSxlimit(int sxlimit) {
		this.sxlimit = sxlimit;
	}
	
	public Date getSxlimitDate() {
		return sxlimitDate;
	}
	
	public void setSxlimitDate(Date sxlimitDate) {
		this.sxlimitDate = sxlimitDate;
	}
	
	public Date getSxlimitDatee() {
		return sxlimitDatee;
	}
	
	public void setSxlimitDatee(Date sxlimitDatee) {
		this.sxlimitDatee = sxlimitDatee;
	}
	
	public int getXypjid() {
		return xypjid;
	}
	
	public void setXypjid(int xypjid) {
		this.xypjid = xypjid;
	}
	
	public int getZdgzstu() {
		return zdgzstu;
	}
	
	public void setZdgzstu(int zdgzstu) {
		this.zdgzstu = zdgzstu;
	}
	
	public String getInfofrom() {
		return infofrom;
	}
	
	public void setInfofrom(String infofrom) {
		this.infofrom = infofrom;
	}
	
	public int getUsestu() {
		return usestu;
	}
	
	public void setUsestu(int usestu) {
		this.usestu = usestu;
	}
	
	public Date getRecDate() {
		return recDate;
	}
	
	public void setRecDate(Date recDate) {
		this.recDate = recDate;
	}
	
	public int getAge() {
		return age;
	}
	
	public void setAge(int age) {
		this.age = age;
	}
	
	public String getMainclass() {
		return mainclass;
	}
	
	public void setMainclass(String mainclass) {
		this.mainclass = mainclass;
	}
	
	public String getClientclass() {
		return clientclass;
	}
	
	public void setClientclass(String clientclass) {
		this.clientclass = clientclass;
	}
	
	public String getHassonvar() {
		return hassonvar;
	}
	
	public void setHassonvar(String hassonvar) {
		this.hassonvar = hassonvar;
	}
	
	public String getIsjhvar() {
		return isjhvar;
	}
	
	public void setIsjhvar(String isjhvar) {
		this.isjhvar = isjhvar;
	}
	
	public String getTuanduivar() {
		return tuanduivar;
	}
	
	public void setTuanduivar(String tuanduivar) {
		this.tuanduivar = tuanduivar;
	}
	
	public String getProducttypevar() {
		return producttypevar;
	}
	
	public void setProducttypevar(String producttypevar) {
		this.producttypevar = producttypevar;
	}
	
	public String getQdvar() {
		return qdvar;
	}
	
	public void setQdvar(String qdvar) {
		this.qdvar = qdvar;
	}
	
	public String getXlvar() {
		return xlvar;
	}
	
	public void setXlvar(String xlvar) {
		this.xlvar = xlvar;
	}
	
	public String getCompanyadd() {
		return companyadd;
	}
	
	public void setCompanyadd(String companyadd) {
		this.companyadd = companyadd;
	}
	
	public String getClientcode() {
		return clientcode;
	}
	
	public void setClientcode(String clientcode) {
		this.clientcode = clientcode;
	}
	
	public String getLargearea() {
		return largearea;
	}
	
	public void setLargearea(String largearea) {
		this.largearea = largearea;
	}
	
	public String getHxgoodsrate() {
		return hxgoodsrate;
	}
	
	public void setHxgoodsrate(String hxgoodsrate) {
		this.hxgoodsrate = hxgoodsrate;
	}
	
	public String getGdnumvar() {
		return gdnumvar;
	}
	
	public void setGdnumvar(String gdnumvar) {
		this.gdnumvar = gdnumvar;
	}
}
