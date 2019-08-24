package com.jeeplus.test;


import com.alibaba.excel.EasyExcelFactory;
import com.alibaba.excel.metadata.Sheet;
import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.utils.IdGen;
import com.jeeplus.common.utils.StringUtils;
import com.jeeplus.modules.kerz.entity.RcKhzl;
import com.jeeplus.modules.kerz.entity.Tbuy;
import com.jeeplus.modules.kerz.service.RcKhzlService;
import com.jeeplus.modules.kerz.service.TbuyService;
import com.jeeplus.modules.xssj.entity.CCustSale;
import com.jeeplus.modules.xssj.entity.CCustsaleTj;
import com.jeeplus.modules.xssj.entity.CSxeduTj;
import com.jeeplus.modules.xssj.service.CCustSaleService;


import com.jeeplus.modules.xssj.service.CCustsaleTjService;
import com.jeeplus.modules.xssj.service.CSxeduTjService;
import com.jeeplus.modules.xssj.utils.CCustSaleListener;
import com.jeeplus.modules.xssj.utils.ListUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.sql.*;
import java.util.*;
import java.util.Date;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath*:/spring-context.xml","classpath*:/mybatis*.xml"})
public class WebServiceTest {
	
	@Autowired
	private CCustSaleService cCustSaleService;
	
	@Autowired
	private CSxeduTjService cSxeduTjService;
	
	@Autowired
	private CCustsaleTjService cCustsaleTjService;
	
	@Autowired
	private RcKhzlService rcKhzlService;
	
	@Autowired
	private TbuyService tbuyService;
	/**
	 * 销售数据
	 */
	@Test
	public void insertBatch() throws FileNotFoundException {
		long startTime = System.currentTimeMillis();

		FileInputStream fis = new FileInputStream(new File("D:\\excetodb\\2019-06月份销售收入.xlsx"));

		CCustSaleListener excelListener = new CCustSaleListener();
		EasyExcelFactory.readBySax(fis,new Sheet(1, 1), excelListener);
		List<CCustSale> data = excelListener.getData();
		System.out.println(data.size());
		long endTime = System.currentTimeMillis();
		System.out.println("耗时："+(endTime-startTime)/1000+"s");

		List<List<CCustSale>> lists = ListUtils.splitList(data, 10000);
		int sum = 0;
		for(int i=0;i<lists.size();i++){
			long startTime1 = System.currentTimeMillis();
			int count = cCustSaleService.insertBatch(lists.get(i));
			sum += count;
			long endTime2 = System.currentTimeMillis();
			System.out.println("第"+sum+"条数据导入数据库完毕，用时："+(endTime2-startTime1)/1000+"s");
		}

		long endTime3 = System.currentTimeMillis();
		System.out.println("总用时："+(endTime3-startTime)/1000+"s");

	}
	
	/**
	 * 销售数据
	 */
	@Test
	public void getKeHuTj() {
		Page page = new Page(1,5);
		page.setCall(true);
		CSxeduTj cSxeduTj = new CSxeduTj();
		//cSxeduTj.setCkName("河北福海粮油有限公司");
		cSxeduTj.setNianfen(2018);
		cSxeduTj.setYuefen(11);
		cSxeduTj.setSfhz(1);
		cSxeduTj.setPage(page);
		List<List<HashMap<?,?>>> list = cSxeduTjService.getKeHuTj(cSxeduTj);
		page.setList(list.get(0));
		//page.setCount(Long.valueOf(list.get(1).get(0).get("count")));
		page.setCount(Long.valueOf(list.get(1).get(0).get("count")+""));
		
		System.out.println(list.get(2).get(0).get("maxDate"));
		List<?> keHuTj = page.getList();
		if(null != keHuTj && keHuTj.size()>0){
			for(int i = 0;i<keHuTj.size();i++){
				HashMap o = (HashMap)keHuTj.get(i);
				System.out.println(o.get("ckName"));
			}
		}
		
	}
	/**
	 * 客户资料
	 */
	@Test
	public void getKhzl() {
		Tbuy tbuy = new Tbuy();
		List<Tbuy> list = tbuyService.findList(tbuy);
		if(null != list && list.size()>0){
			for(int j = 0;j<list.size();j++){
				Tbuy tbuy1 = list.get(j);
				RcKhzl rcKhzl1 = new RcKhzl();
				rcKhzl1.setKhmc(tbuy1.getName());
				
				RcKhzl rcKhzl = rcKhzlService.get(rcKhzl1);
				if(null == rcKhzl){
					rcKhzl = new RcKhzl();
				}
					rcKhzl.setKhmc(tbuy1.getName());
					rcKhzl.setGuojia("中国");
					//城市
					String city = "";
					if(StringUtils.isNotBlank(tbuy1.getCity()) && tbuy1.getCity().contains("/")){
						String[] split = tbuy1.getCity().split("/");
						city = split[0]+split[1];
						rcKhzl.setSf(split[0]);
					}else {
						city = tbuy1.getCity();
					}
					rcKhzl.setCity(city);
					//地址
					rcKhzl.setKhdz(tbuy1.getAddress());
					
					//核心产品销售占比
					Double strDouble = 0.00;
					if(StringUtils.isNotBlank(tbuy1.getHxgoodsrate()) && tbuy1.getHxgoodsrate().contains("%")){
						System.out.println(tbuy1.getHxgoodsrate());
						BigDecimal db = new BigDecimal(tbuy1.getHxgoodsrate().replace("%","").trim());
						strDouble = db.setScale(4, BigDecimal.ROUND_HALF_UP).doubleValue();
						System.out.println(strDouble);
					}
					rcKhzl.setFlmzb(strDouble);
					
					//设置客户简码
					/*
					 * 获取数据库中最大的简码，如果没有，则设置简码为：RG00000001
					 */
					RcKhzl maxKhjm = rcKhzlService.getMaxKhjm();
					String str = "";
					if(null != maxKhjm && StringUtils.isNotBlank(maxKhjm.getKhjm())){
						String substring = maxKhjm.getKhjm().substring(2, maxKhjm.getKhjm().length() - 1);
						String subPre = maxKhjm.getKhjm().substring(0, 2);
						if(StringUtils.isNotBlank(substring)){
							Integer kjnum = Integer.valueOf(substring);
							String str1 = (kjnum+1) + "";
							int t = 8 - str1.length();
							for(int i=0;i<t; i++){
								str1 = "0" + str1;
							}
							str = "RG"+ str1;
						}
					}else {
						str ="RG00000001" ;
					}
					if(rcKhzl != null ){
						if(StringUtils.isBlank(rcKhzl.getKhjm())){
							rcKhzl.setKhjm(str);
						}
					}
					rcKhzlService.save(rcKhzl);
				
				
			}
		}
	}
	/**
	 * 重新计算所有销售数据
	 */
	@Test
	public void getSXTJAll(){
		CCustsaleTj cCustsaleTj = new CCustsaleTj();

		cCustsaleTj.setTjname(1);//销售收入
		List<CCustsaleTj> x1 = cCustsaleTjService.getXssjtj(cCustsaleTj);
		System.out.println("销售收入:"+x1.size());

		cCustsaleTj.setTjname(2);//净值
		List<CCustsaleTj> x2 = cCustsaleTjService.getXssjtj(cCustsaleTj);
		System.out.println("净值:"+x2.size());

		cCustsaleTj.setTjname(3);//税额
		List<CCustsaleTj> x3 = cCustsaleTjService.getXssjtj(cCustsaleTj);
		System.out.println("税额:"+x3.size());

		cCustsaleTj.setTjname(4);//战略价金额
		List<CCustsaleTj> x4 = cCustsaleTjService.getXssjtj(cCustsaleTj);
		System.out.println("战略价金额:"+x4.size());


		System.out.println("合计："+(x1.size()+x2.size()+x3.size()+x4.size()));

	}


	/**
	 * 销售数据统计
	 */
	@Test
	public void getSXTJ() {
		cCustsaleTjService.sxeduTjTask();
	}

	@Test
	public void deleteCSxeduTj() {
		CSxeduTj cSxeduTj = new CSxeduTj();
		int year = 2018;
		int month = 12;
		cSxeduTj.setNianfen(year);
		cSxeduTj.setYuefen(month);
		cSxeduTjService.deleteCSxeduTj(cSxeduTj);
	}
	/**
	 * 授信额度
	 */
	@Test
	public void getSX() {
		Calendar date = Calendar.getInstance();	//当前年份
		System.out.println(date.get(Calendar.MONTH));
		CSxeduTj cSxeduTj = new CSxeduTj();
		int year = 2019;
		int month = 1;
		cSxeduTj.setNianfen(year);
		cSxeduTj.setYuefen(month);

		cSxeduTj.setCreateDate(new Date());
		cSxeduTj.setUpdateDate(new Date());
		cSxeduTjService.deleteCSxeduTj(cSxeduTj);
		List<CSxeduTj> list1 = cSxeduTjService.getCSxeduTj(cSxeduTj);
		
		List<CSxeduTj> list2 = new ArrayList<>();
		for(CSxeduTj cSxeduTj1: list1){
			if(StringUtils.isBlank(cSxeduTj1.getId())){
				cSxeduTj1.setId(IdGen.uuid());
				if(null == cSxeduTj1.getYuefen()){
					cSxeduTj1.setNianfen(year);
				}
				if(null == cSxeduTj1.getYuefen()){
					cSxeduTj1.setYuefen(month);
				}
				list2.add(cSxeduTj1);
			}
		}
		cSxeduTjService.insertBatchCSxeduTj(list2);
		System.out.println(list1);
	}
	
	@Test
	public void getDate() {
		Calendar date = Calendar.getInstance();	//当前年份
		System.out.println(date.get(Calendar.MONTH));
	}
	private static Connection getConn() {
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://127.0.0.1:3306/rcsjfx?useUnicode=true&characterEncoding=utf-8&useServerPrepStmts=false&rewriteBatchedStatements=true";
		String username = "root";
		String password = "root";
		Connection conn = null;
		try {
			Class.forName(driver); //classLoader,加载对应驱动
			conn = (Connection) DriverManager.getConnection(url, username, password);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	@Test
	public void testGetJdbc(){
		Connection conn = getConn();
		String sql = "SELECT a.id AS \"id\", a.gongchang AS \"gongchang\", a.daqu AS \"daqu\", a.chengshi AS \"chengshi\", a.yewuyuan AS \"yewuyuan\", a.cust_no AS \"custNo\", a.cust_name AS \"custName\", a.dapinleimiaoshu AS \"dapinleimiaoshu\", a.yijipinleimiaoshu AS \"yijipinleimiaoshu\", a.erjipinleimiaoshu AS \"erjipinleimiaoshu\", a.sanjipinleimiaoshu AS \"sanjipinleimiaoshu\", a.chanpinxianmiaoshu AS \"chanpinxianmiaoshu\", a.wuliaobianma AS \"wuliaobianma\", a.wuliaomiaoshu AS \"wuliaomiaoshu\", a.xiang AS \"xiang\", a.dun AS \"dun\", a.xiaoshoushouru AS \"xiaoshoushouru\", a.jingzhi AS \"jingzhi\", a.shuie AS \"shuie\", a.zhanlvjine AS \"zhanlvjine\", a.zhekoujine AS \"zhekoujine\", a.zhekoubili AS \"zhekoubili\", a.shoudafangjiancheng AS \"shoudafangjiancheng\", a.fapiaoshiqi AS \"fapiaoshiqi\", a.dingdanbianhao AS \"dingdanbianhao\", a.danjuriqi AS \"danjuriqi\", a.kucundidian AS \"kucundidian\", a.caigoubianhao AS \"caigoubianhao\", a.create_by AS \"createBy.id\", a.create_date AS \"createDate\", a.update_by AS \"updateBy.id\", a.update_date AS \"updateDate\", a.remarks AS \"remarks\", a.del_flag AS \"delFlag\" FROM c_cust_sale a WHERE a.del_flag = '0' ORDER BY a.fapiaoshiqi DESC,a.danjuriqi DESC limit 20";
		PreparedStatement pstmt;
		try {
			pstmt = (PreparedStatement)conn.prepareStatement(sql);
			pstmt.setFetchSize(1000);

			Long start = System.currentTimeMillis();
			System.out.println("开始计时："+ start);
			ResultSet rs = pstmt.executeQuery();
			Long end = System.currentTimeMillis();

			System.out.println("开始结束："+ end);
			System.out.println("耗时："+ (end-start) +"毫秒"+",合计"+((end-start)/1000)+"秒");
			int col = rs.getMetaData().getColumnCount();
			System.out.println("============================");
			while (rs.next()) {
				for (int i = 1; i <= col; i++) {
					System.out.print(rs.getString(i) + "\t");
					if ((i == 2) && (rs.getString(i).length() < 8)) {
						System.out.print("\t");
					}
				}
				System.out.println("");
			}
			System.out.println("============================");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	@Test
	public void testGetSql() {
//		Page<CCustSale> page = new Page<CCustSale>();
//		page.setPageNo(1);
//		page.setPageSize(20);
//		CCustSale c = new CCustSale();
//		c.setDelFlag("0");
//
//		//CCustSaleService cCustSaleService = SpringContextHolder.getBean("cCustSaleService");
//		Long start = System.currentTimeMillis();
//		Page<CCustSale> page1 = cCustSaleService.findPage(page, c);
//		Long end = System.currentTimeMillis();
//		System.out.println("耗时："+(end-start)+"毫秒,"+((end-start)/1000)+"秒");
//		if(null!=page1){
//			List<CCustSale> list = page1.getList();
//			if(null!=list && list.size()>0){
//				for (CCustSale cCustSale : list){
//					System.out.println(cCustSale.getCustName());
//				}
//			}
//
//		}

	}
	@Test
	public void getZhr(){
//		JaxWsProxyFactoryBean factory = new JaxWsProxyFactoryBean();
//		factory.setServiceClass(ZHROAPA001.class);
//		factory.setAddress("http://localhost:8181/rcsjfx/services/FpsjService?wsdl");
//		ZHROAPA001 zhrService = (ZHROAPA001) factory.create();
//
//		Client client = ClientProxy.getClient(zhrService);
//		HTTPConduit http = (HTTPConduit) client.getConduit();
//		HTTPClientPolicy hcp = new HTTPClientPolicy();
//
//		http.setClient(hcp);
//
//		ProxyAuthorizationPolicy proxyAuthorization = new ProxyAuthorizationPolicy();
//		proxyAuthorization.setUserName("");
//		proxyAuthorization.setPassword("");
//		http.setProxyAuthorization(proxyAuthorization);
//
//		client.setConduitSelector((ConduitSelector)http);
//		try {
//			Object[] objects = client.invoke("ZhroaPa001", "");
//
//			String res = "";
//			if(objects != null && objects.length != 0){
//				res = objects[0].toString();
//				System.out.println(res);
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
//	}

//	@Test
//	public void getFpsjjx() throws DocumentException {
//		/*JaxWsProxyFactoryBean factory = new JaxWsProxyFactoryBean();
//		factory.setServiceClass(FpsjServiceImplService.class);
//		factory.setAddress("http://localhost:8181/rcsjfx/services/FpsjService?wsdl");
//		FpsjServiceImplService fpsjService = (FpsjServiceImplService) factory.create();*/
//
//		/*FpsjServiceImplService fpsjService1 = new FpsjServiceImplService();
//		String str = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:web=\"http://webservices.fpsj.modules.jeeplus.com/\">\n" +
//				"   <soapenv:Header/>\n" +
//				"   <soapenv:Body>\n" +
//				"      <web:getJxfp>\n" +
//				"         <arg0>\n" +
//				"              <jxfp>\n" +
//				"   <head>\n" +
//				"               <fpdm>3200174130</fpdm>   \n" +
//				"               <fphm>05671608</fphm>    \n" +
//				"               <fpzf>0</fpzf>   \n" +
//				"               <kplx>0</kplx>   \n" +
//				"        <gmfmc>江苏金色晨野网络科技有限公司</gmfmc>   \n" +
//				"        <gmfsh>91320106751275734J</gmfsh>   \n" +
//				"        <gmfdz>南京市鼓楼区广州路213号 025-86660933</gmfdz>   \n" +
//				"        <gmfyhzh>平安银行南京江宁支行 11006638331304</gmfyhzh>  \n" +
//				"               <hjbhsje>29099.1</hjbhsje>  \n" +
//				"               <hjhsje>32300</hjhsje>  \n" +
//				"               <hjse>3200.9</hjse>   \n" +
//				"               <kprq>2018-01-30</kprq>   \n" +
//				"               <xsfmc>中粮福临门食品营销有限公司南京分公司</xsfmc>   \n" +
//				"               <xsfsh>91320191MA1MNRW1X7</xsfsh>   \n" +
//				"               <xsfdz>南京高新开发区惠达路9号 025-68213088</xsfdz>   \n" +
//				"               <xsyhzh>中信银行北京中粮广场支行 8110701013300644917</xsyhzh>  \n" +
//				"               <bz>ASO1801150531 1000355093 9000422364</bz>   \n" +
//				"               <update>0</update>\n" +
//				"</head>\n" +
//				"<item>               \n" +
//				"   <hxmh>1</hxmh>  \n" +
//				"   <hwmc>*植物油*福临门一级大豆油900ml*12</hwmc>   \n" +
//				"   <ggxh>900ml*12</ggxh>   \n" +
//				"   <bhsje>3873.87</bhsje>   \n" +
//				"   <bhsdj>77.4774</bhsdj>   \n" +
//				"   <hsdj>86.00</hsdj>   \n" +
//				"   <hsje>4300.00</hsje>   \n" +
//				"   <se>426.13</se>   \n" +
//				"   <xmsl>50</xmsl>   \n" +
//				"   <dw>箱</dw>   \n" +
//				"   <sl>11</sl>   \n" +
//				"</item><item>               \n" +
//				"   <hxmh>2</hxmh>  \n" +
//				"   <hwmc>*植物油*福临门葵花籽原香食用调和油5L*4</hwmc>   \n" +
//				"   <ggxh>5L*4</ggxh>   \n" +
//				"   <bhsje>25225.23</bhsje>   \n" +
//				"   <bhsdj>126.126150</bhsdj>   \n" +
//				"   <hsdj>140.00</hsdj>   \n" +
//				"   <hsje>28000.00</hsje>   \n" +
//				"   <se>2774.77</se>   \n" +
//				"   <xmsl>200</xmsl>   \n" +
//				"   <dw>箱</dw>   \n" +
//				"   <sl>11</sl>   \n" +
//				"</item>\n" +
//				"</jxfp>\n" +
//				"         </arg0>\n" +
//				"      </web:getJxfp>\n" +
//				"   </soapenv:Body>\n" +
//				"</soapenv:Envelope>";
//		String jxfp = fpsjService1.getFpsjServiceImplPort().getJxfp(str);
//		System.out.println(jxfp);
//		*//*Document doc = DocumentHelper.parseText(str);
//		Element node =   doc.getRootElement();
//		getNodes(node);*//*
//		*//*String text = doc.asXML();
//		DefaultXPath xpath = new DefaultXPath("//web:getJxfp");
//		//xpath.setNamespaceURIs(Collections.singletonMap("ns2","http://www.ustcsoft.com"));
//		//获取根节点
//		Element root = doc.getRootElement();
//
//		//获取根节点下的所有元素
//		Element jxfp = root.element("jxfp");
//		//jxfp.asXML().toString();
//		Document doc2 =  DocumentHelper.parseText(jxfp.asXML().toString());*//*
//
//		*/
//	}
//	private void getNodes(final Element node) {
//
//		if(node.element("jxfp")!=null){
//			Element jxfp = node.element("jxfp");
//			String jxfp1 = jxfp.asXML();
//			System.out.println(jxfp1);
//			Jxfp jxfp2 = JaxbMapper.fromXml(jxfp1, Jxfp.class);
//
//			System.out.println(jxfp2.getHead().getFphm());
//
//		}
//		final List<Element> listElement = node.elements();// 所有一级子节点的list
//		for (final Element e : listElement) {// 遍历所有一级子节点
//			getNodes(e);// 递归
//		}
//
//	}
//	@Test
//	public void getFpsj(){
//		/*JaxWsProxyFactoryBean factory = new JaxWsProxyFactoryBean();
//		factory.setServiceClass(FpsjServiceImplService.class);
//		factory.setAddress("http://localhost:8181/rcsjfx/services/FpsjService?wsdl");
//		FpsjServiceImplService fpsjService = (FpsjServiceImplService) factory.create();*/
//
//
//		String str = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:web=\"http://webservices.fpsj.modules.jeeplus.com/\">\n" +
//				"   <soapenv:Header/>\n" +
//				"   <soapenv:Body>\n" +
//				"      <web:getXxfp>\n" +
//				"         <arg0>\n" +
//				"            <xxfp>\n" +
//				"  <head>\n" +
//				"  <fphm>320018113005584416</fphm>\t\t\t\t\t\n" +
//				"  <kprq>2018-01-31</kprq>\t\t\t\t\t\t\n" +
//				"  <khsh>913201067283573016</khsh>\t\t\t\t\t\n" +
//				"  <khmc>南京金堡超市有限责任公司</khmc>\t\t\t\t\t\n" +
//				"  <khdz>南京市玄武区红山路157号101 025-85436003</khdz>\t\n" +
//				"  <khkhyhzh>工行燕江路分理处 4301011709000000739</khkhyhzh>\t\t\n" +
//				"  <bz></bz>\t\t\t\t\t\t\t\t\n" +
//				"  <kpr>江思佳</kpr>\t\t\t\t\t\t\t\n" +
//				"  <skr></skr>\t\t\t\t\t\t\t\t\n" +
//				"  <fhr></fhr>\t\t\t\t\t\t\t\t\n" +
//				"  <zfbz>0</zfbz>\t\t\t\t\t\t\t\n" +
//				"  <zbhsje>6441.44</zbhsje>\t\t\t\t\t\t\n" +
//				"  <zse>708.56</zse>\t\t\t\t\t\t\t\n" +
//				"  <jshj>7150</jshj>\t\t\t\t\t\t\t\n" +
//				"  <skjbh>00</skjbh>\t\t\t\t\t\t\t\n" +
//				"  <qysh>91320106751275734J</qysh>\t\t\t\t\t\t\t\n" +
//				"  <qykhyhzh>平安银行南京江宁支行 11006638331304</qykhyhzh>\t\t\n" +
//				"  <update>0</update>\t\t\t\t\t\t\t\n" +
//				"</head>\n" +
//				"<item>  \n" +
//				" <fphm>320018113005584416</fphm>\t\t\t\t\t\n" +
//				" <mxxh>1</mxxh>\t\t\t\t\t\t\t\n" +
//				" <cpmc>*植物油*福临门黄金产地玉米油</cpmc>\t\t\t\t\t\t\t\n" +
//				" <cpxh>1.8L</cpxh>\t\t\t\t\t\t\t\n" +
//				" <cpdw>箱</cpdw>\t\t\t\t\t\t\t\n" +
//				" <cpsl>1</cpsl>\t\t\t\t\t\t\t\t\n" +
//				" <cpdj>0</cpdj>\t\t\t\t\t\t\t\n" +
//				" <bhsje>130.63</bhsje>\t\t\t\t\t\t\t\n" +
//				" <sl>11</sl>\t\t\t\t\t\t\t\t\n" +
//				" <se>14.37</se>\t\t\t\t\t\t\t\t\n" +
//				" <hsje>145.00</hsje>\t\t\t\t\t\t\t\t\n" +
//				"</item><item>  \n" +
//				" <fphm>320018113005584416</fphm>\t\t\t\t\t\n" +
//				" <mxxh>2</mxxh>\t\t\t\t\t\t\t\n" +
//				" <cpmc>*谷物加工品*福临门东北大米</cpmc>\t\t\t\t\t\t\t\n" +
//				" <cpxh>10KG</cpxh>\t\t\t\t\t\t\t\n" +
//				" <cpdw>箱</cpdw>\t\t\t\t\t\t\t\n" +
//				" <cpsl>3</cpsl>\t\t\t\t\t\t\t\t\n" +
//				" <cpdj>0</cpdj>\t\t\t\t\t\t\t\n" +
//				" <bhsje>543.24</bhsje>\t\t\t\t\t\t\t\n" +
//				" <sl>11</sl>\t\t\t\t\t\t\t\t\n" +
//				" <se>59.76</se>\t\t\t\t\t\t\t\t\n" +
//				" <hsje>603.00</hsje>\t\t\t\t\t\t\t\t\n" +
//				"</item><item>  \n" +
//				" <fphm>320018113005584416</fphm>\t\t\t\t\t\n" +
//				" <mxxh>3</mxxh>\t\t\t\t\t\t\t\n" +
//				" <cpmc>*植物油*福临门一级大豆油</cpmc>\t\t\t\t\t\t\t\n" +
//				" <cpxh>5L</cpxh>\t\t\t\t\t\t\t\n" +
//				" <cpdw>箱</cpdw>\t\t\t\t\t\t\t\n" +
//				" <cpsl>1</cpsl>\t\t\t\t\t\t\t\t\n" +
//				" <cpdj>0</cpdj>\t\t\t\t\t\t\t\n" +
//				" <bhsje>126.13</bhsje>\t\t\t\t\t\t\t\n" +
//				" <sl>11</sl>\t\t\t\t\t\t\t\t\n" +
//				" <se>13.87</se>\t\t\t\t\t\t\t\t\n" +
//				" <hsje>140.00</hsje>\t\t\t\t\t\t\t\t\n" +
//				"</item><item>  \n" +
//				" <fphm>320018113005584416</fphm>\t\t\t\t\t\n" +
//				" <mxxh>4</mxxh>\t\t\t\t\t\t\t\n" +
//				" <cpmc>*植物油*福临门一级非转大豆油</cpmc>\t\t\t\t\t\t\t\n" +
//				" <cpxh>5L</cpxh>\t\t\t\t\t\t\t\n" +
//				" <cpdw>箱</cpdw>\t\t\t\t\t\t\t\n" +
//				" <cpsl>22</cpsl>\t\t\t\t\t\t\t\t\n" +
//				" <cpdj>0</cpdj>\t\t\t\t\t\t\t\n" +
//				" <bhsje>4063.06</bhsje>\t\t\t\t\t\t\t\n" +
//				" <sl>11</sl>\t\t\t\t\t\t\t\t\n" +
//				" <se>446.94</se>\t\t\t\t\t\t\t\t\n" +
//				" <hsje>4510.00</hsje>\t\t\t\t\t\t\t\t\n" +
//				"</item><item>  \n" +
//				" <fphm>320018113005584416</fphm>\t\t\t\t\t\n" +
//				" <mxxh>5</mxxh>\t\t\t\t\t\t\t\n" +
//				" <cpmc>*植物油*福临门一级大豆油</cpmc>\t\t\t\t\t\t\t\n" +
//				" <cpxh>1.8L</cpxh>\t\t\t\t\t\t\t\n" +
//				" <cpdw>箱</cpdw>\t\t\t\t\t\t\t\n" +
//				" <cpsl>1</cpsl>\t\t\t\t\t\t\t\t\n" +
//				" <cpdj>0</cpdj>\t\t\t\t\t\t\t\n" +
//				" <bhsje>85.59</bhsje>\t\t\t\t\t\t\t\n" +
//				" <sl>11</sl>\t\t\t\t\t\t\t\t\n" +
//				" <se>9.41</se>\t\t\t\t\t\t\t\t\n" +
//				" <hsje>95.00</hsje>\t\t\t\t\t\t\t\t\n" +
//				"</item><item>  \n" +
//				" <fphm>320018113005584416</fphm>\t\t\t\t\t\n" +
//				" <mxxh>6</mxxh>\t\t\t\t\t\t\t\n" +
//				" <cpmc>*植物油*福临门天天五谷调和油</cpmc>\t\t\t\t\t\t\t\n" +
//				" <cpxh>1.8L</cpxh>\t\t\t\t\t\t\t\n" +
//				" <cpdw>箱</cpdw>\t\t\t\t\t\t\t\n" +
//				" <cpsl>1</cpsl>\t\t\t\t\t\t\t\t\n" +
//				" <cpdj>0</cpdj>\t\t\t\t\t\t\t\n" +
//				" <bhsje>112.61</bhsje>\t\t\t\t\t\t\t\n" +
//				" <sl>11</sl>\t\t\t\t\t\t\t\t\n" +
//				" <se>12.39</se>\t\t\t\t\t\t\t\t\n" +
//				" <hsje>125.00</hsje>\t\t\t\t\t\t\t\t\n" +
//				"</item><item>  \n" +
//				" <fphm>320018113005584416</fphm>\t\t\t\t\t\n" +
//				" <mxxh>7</mxxh>\t\t\t\t\t\t\t\n" +
//				" <cpmc>*植物油*福临门纯香菜籽油（三级菜）</cpmc>\t\t\t\t\t\t\t\n" +
//				" <cpxh>5L</cpxh>\t\t\t\t\t\t\t\n" +
//				" <cpdw>箱</cpdw>\t\t\t\t\t\t\t\n" +
//				" <cpsl>1</cpsl>\t\t\t\t\t\t\t\t\n" +
//				" <cpdj>0</cpdj>\t\t\t\t\t\t\t\n" +
//				" <bhsje>162.16</bhsje>\t\t\t\t\t\t\t\n" +
//				" <sl>11</sl>\t\t\t\t\t\t\t\t\n" +
//				" <se>17.84</se>\t\t\t\t\t\t\t\t\n" +
//				" <hsje>180.00</hsje>\t\t\t\t\t\t\t\t\n" +
//				"</item><item>  \n" +
//				" <fphm>320018113005584416</fphm>\t\t\t\t\t\n" +
//				" <mxxh>8</mxxh>\t\t\t\t\t\t\t\n" +
//				" <cpmc>*植物油*福临门黄金产地玉米油</cpmc>\t\t\t\t\t\t\t\n" +
//				" <cpxh>5L</cpxh>\t\t\t\t\t\t\t\n" +
//				" <cpdw>箱</cpdw>\t\t\t\t\t\t\t\n" +
//				" <cpsl>1</cpsl>\t\t\t\t\t\t\t\t\n" +
//				" <cpdj>0</cpdj>\t\t\t\t\t\t\t\n" +
//				" <bhsje>211.71</bhsje>\t\t\t\t\t\t\t\n" +
//				" <sl>11</sl>\t\t\t\t\t\t\t\t\n" +
//				" <se>23.29</se>\t\t\t\t\t\t\t\t\n" +
//				" <hsje>235.00</hsje>\t\t\t\t\t\t\t\t\n" +
//				"</item><item>  \n" +
//				" <fphm>320018113005584416</fphm>\t\t\t\t\t\n" +
//				" <mxxh>9</mxxh>\t\t\t\t\t\t\t\n" +
//				" <cpmc>*谷物加工品*福临门东北大米</cpmc>\t\t\t\t\t\t\t\n" +
//				" <cpxh>5KG</cpxh>\t\t\t\t\t\t\t\n" +
//				" <cpdw>箱</cpdw>\t\t\t\t\t\t\t\n" +
//				" <cpsl>2</cpsl>\t\t\t\t\t\t\t\t\n" +
//				" <cpdj>0</cpdj>\t\t\t\t\t\t\t\n" +
//				" <bhsje>252.25</bhsje>\t\t\t\t\t\t\t\n" +
//				" <sl>11</sl>\t\t\t\t\t\t\t\t\n" +
//				" <se>27.75</se>\t\t\t\t\t\t\t\t\n" +
//				" <hsje>280.00</hsje>\t\t\t\t\t\t\t\t\n" +
//				"</item><item>  \n" +
//				" <fphm>320018113005584416</fphm>\t\t\t\t\t\n" +
//				" <mxxh>10</mxxh>\t\t\t\t\t\t\t\n" +
//				" <cpmc>*谷物加工品*福临门盘锦生态米</cpmc>\t\t\t\t\t\t\t\n" +
//				" <cpxh>10KG</cpxh>\t\t\t\t\t\t\t\n" +
//				" <cpdw>箱</cpdw>\t\t\t\t\t\t\t\n" +
//				" <cpsl>1</cpsl>\t\t\t\t\t\t\t\t\n" +
//				" <cpdj>0</cpdj>\t\t\t\t\t\t\t\n" +
//				" <bhsje>183.78</bhsje>\t\t\t\t\t\t\t\n" +
//				" <sl>11</sl>\t\t\t\t\t\t\t\t\n" +
//				" <se>20.22</se>\t\t\t\t\t\t\t\t\n" +
//				" <hsje>204.00</hsje>\t\t\t\t\t\t\t\t\n" +
//				"</item><item>  \n" +
//				" <fphm>320018113005584416</fphm>\t\t\t\t\t\n" +
//				" <mxxh>11</mxxh>\t\t\t\t\t\t\t\n" +
//				" <cpmc>*植物油*福临门黄金产地玉米油</cpmc>\t\t\t\t\t\t\t\n" +
//				" <cpxh>5L</cpxh>\t\t\t\t\t\t\t\n" +
//				" <cpdw>箱</cpdw>\t\t\t\t\t\t\t\n" +
//				" <cpsl>1</cpsl>\t\t\t\t\t\t\t\t\n" +
//				" <cpdj>0</cpdj>\t\t\t\t\t\t\t\n" +
//				" <bhsje>207.21</bhsje>\t\t\t\t\t\t\t\n" +
//				" <sl>11</sl>\t\t\t\t\t\t\t\t\n" +
//				" <se>22.79</se>\t\t\t\t\t\t\t\t\n" +
//				" <hsje>230.00</hsje>\t\t\t\t\t\t\t\t\n" +
//				"</item><item>  \n" +
//				" <fphm>320018113005584416</fphm>\t\t\t\t\t\n" +
//				" <mxxh>12</mxxh>\t\t\t\t\t\t\t\n" +
//				" <cpmc>*谷物加工品*福临门盘锦生态米</cpmc>\t\t\t\t\t\t\t\n" +
//				" <cpxh>5KG</cpxh>\t\t\t\t\t\t\t\n" +
//				" <cpdw>箱</cpdw>\t\t\t\t\t\t\t\n" +
//				" <cpsl>1</cpsl>\t\t\t\t\t\t\t\t\n" +
//				" <cpdj>0</cpdj>\t\t\t\t\t\t\t\n" +
//				" <bhsje>187.39</bhsje>\t\t\t\t\t\t\t\n" +
//				" <sl>11</sl>\t\t\t\t\t\t\t\t\n" +
//				" <se>20.61</se>\t\t\t\t\t\t\t\t\n" +
//				" <hsje>208.00</hsje>\t\t\t\t\t\t\t\t\n" +
//				"</item><item>  \n" +
//				" <fphm>320018113005584416</fphm>\t\t\t\t\t\n" +
//				" <mxxh>13</mxxh>\t\t\t\t\t\t\t\n" +
//				" <cpmc>*谷物加工品*福临门东北大米</cpmc>\t\t\t\t\t\t\t\n" +
//				" <cpxh>10KG</cpxh>\t\t\t\t\t\t\t\n" +
//				" <cpdw>箱</cpdw>\t\t\t\t\t\t\t\n" +
//				" <cpsl>1</cpsl>\t\t\t\t\t\t\t\t\n" +
//				" <cpdj>0</cpdj>\t\t\t\t\t\t\t\n" +
//				" <bhsje>175.68</bhsje>\t\t\t\t\t\t\t\n" +
//				" <sl>11</sl>\t\t\t\t\t\t\t\t\n" +
//				" <se>19.32</se>\t\t\t\t\t\t\t\t\n" +
//				" <hsje>195.00</hsje>\t\t\t\t\t\t\t\t\n" +
//				"</item>\n" +
//				"</xxfp>\n" +
//				"           </arg0>\n" +
//				"      </web:getXxfp>\n" +
//				"   </soapenv:Body>\n" +
//				"</soapenv:Envelope>\n";
//
//		/*FpsjServiceImplService fpsjService1 = new FpsjServiceImplService();
//		String jxfp = fpsjService1.getFpsjServiceImplPort().getXxfp(str);
//		System.out.println(jxfp);*/
//
//	}
	}
}
