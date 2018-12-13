<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>客户分析</title>
	<meta name="decorator" content="default"/>
	<script  src="${ctxStatic}/echarts-master/echarts.min.js" ></script>

	<script type="text/javascript">
		$(document).ready(function() {
			var myDate = new Date();
			var year = myDate.getFullYear();    //获取完整的年份(4位,1970-????)


			var beginNianfen = $().val();
			for(var i=0;i<5;i++){
				var optionYear = year-i;
				$("#beginNianfen").append("<option value='"+optionYear+"'>"+optionYear+'年'+"</option>");
				$("#endNianfen").append("<option value='"+optionYear+"'>"+optionYear+'年'+"</option>");
			}
			var quYear = year-1;
			$("#beginNianfen").find("option[value = '"+quYear+"']").attr("selected","selected");
			$("#endNianfen").find("option[value = '"+year+"']").attr("selected","selected");

			var myChart1 = echarts.init(document.getElementById('syzjgcJson'));
			var myChart2 = echarts.init(document.getElementById('tshzjjgJson'));
			//生意资金构成
			var syzjgcJson = ${syzjgcJson};
			//重构后的生意资金构成
			var tshzjjgJson = ${tshzjjgJson};


			option1 = {
				title : {
					text: '生意资金构成',
					x:'center'
				},
				tooltip : {
					trigger: 'item',
					formatter: "{a} <br/>{b} : {c} ({d}%)"
				},
				legend: {
					orient: 'vertical',
					left: 'left',
					data: ['银行融资','民间借贷','保理融资','自有资金','其它']
				},
				series : [
					{
						name: '生意资金构成',
						type: 'pie',
						radius : '55%',
						center: ['50%', '60%'],
						data:syzjgcJson,
						itemStyle: {
							emphasis: {
								shadowBlur: 10,
								shadowOffsetX: 0,
								shadowColor: 'rgba(0, 0, 0, 0.5)'
							}
						}
					}
				]
			};

			option2 = {
				title : {
					text: '生意资金构成',
					x:'center'
				},
				tooltip : {
					trigger: 'item',
					formatter: "{a} <br/>{b} : {c} ({d}%)"
				},
				legend: {
					orient: 'vertical',
					left: 'left',
					data:['银行融资','民间借贷','保理融资','自有资金','其它']
				},
				series : [
					{
						name: '生意资金构成',
						type: 'pie',
						radius : '55%',
						center: ['50%', '60%'],
						data:tshzjjgJson,
						itemStyle: {
							emphasis: {
								shadowBlur: 10,
								shadowOffsetX: 0,
								shadowColor: 'rgba(0, 0, 0, 0.5)'
							}
						}
					}
				]
			};
			myChart1.setOption(option1);


			myChart2.setOption(option2);
		});
	</script>
</head>
<body class="gray-bg">
<form:form id="searchForm" modelAttribute="rcKhzl" action="${ctx}/kerz/rcKhzl/getKhfx" method="post" class="form-inline">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h1>客户分析 </h1>
		<div class="ibox-tools">
			<a class="collapse-link">
				<i class="fa fa-chevron-up"></i>
			</a>
			<a class="dropdown-toggle" data-toggle="dropdown" href="#">
				<i class="fa fa-wrench"></i>
			</a>
			<ul class="dropdown-menu dropdown-user">
				<li><a href="#">选项1</a>
				</li>
				<li><a href="#">选项2</a>
				</li>
			</ul>
			<a class="close-link">
				<i class="fa fa-times"></i>
			</a>
		</div>
	</div>
    
    <div class="ibox-content">
	<sys:message content="${message}"/>
	
	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">

		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/>
		<div class="form-group">
			<span>客户简码：</span>
				<form:input path="khjm" htmlEscape="false" maxlength="255"  class=" form-control input-sm"/>
			<span>客户名称：</span>
			<form:input path="khmc" htmlEscape="false" maxlength="255"  class=" form-control input-sm"/>

			<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="search()" ><i class="fa fa-search"></i> 查询</button>
			<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>
		 </div>

	<br/>
	</div>
	</div>
	    <br/>
	    <br/>
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<h3>客户资料</h3>
	</div>
	</div>
	    <br/>

	    <table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		    <tbody>
		    <tr>
			    <td class="width-15 active"><label class="pull-right">客户简码：</label></td>
			    <td class="width-35">
				  ${rcKhzl1.khjm}
			    </td>
			    <td class="width-15 active"><label class="pull-right">客户名称：</label></td>
			    <td class="width-35">
				    ${rcKhzl1.khmc}
			    </td>
		    </tr>
		    <tr>
			    <td class="width-15 active"><label class="pull-right">福临门油销售占比(百分比)：</label></td>
			    <td class="width-35">
				    ${rcKhzl1.flmzb}
			    </td>
			    <td class="width-15 active"><label class="pull-right">资金周转次数：</label></td>
			    <td class="width-35" >
				    ${rcKhzl1.zjzzcs}
			    </td>
		    </tr>
		    <tr>
			    <td class="width-15 active"><label class="pull-right">可负债比例(百分比)：</label></td>
			    <td class="width-35">
				    ${rcKhzl1.kfzbl}
			    </td>
			    <td class="width-15 active"><label class="pull-right">国家：</label></td>
			    <td class="width-35">
				    ${rcKhzl1.guojia}
			    </td>
		    </tr>
		    <tr>
			    <td class="width-15 active"><label class="pull-right">省份/州/自治区/直辖市：</label></td>
			    <td class="width-35">
				    ${rcKhzl1.sf}
			    </td>
			    <td class="width-15 active"><label class="pull-right">城市：</label></td>
			    <td class="width-35">
				    ${rcKhzl1.city}
			    </td>
		    </tr>
		    <tr>
			    <td class="width-15 active"><label class="pull-right">详细地址：</label></td>
			    <td class="width-35">
				    ${rcKhzl1.khdz}
			    </td>
			    <td class="width-15 active"><label class="pull-right"></label></td>
			    <td class="width-35">
			    </td>
		    </tr>
		    </tbody>
	    </table>
	    <br/><br/>
	    <div class="row">
		    <div class="col-sm-12">
			    <h3>股东信息</h3>
		    </div>
	    </div>
	    <br/>
	    <table id="gdTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
		    <thead>
		    <tr>
			    <th  rowspan="2" class="sort-column khmc">类型</th>
			    <th  rowspan="2" class="sort-column khmc">姓名</th>
			    <th   rowspan="2" class="sort-column guojia">身份证号</th>
			    <th   rowspan="2" class="sort-column zjzzcs">性别</th>
			    <th  rowspan="2" class="sort-column flmzb">年龄</th>
			    <th  rowspan="2" class="sort-column khjm">占股比</th>
			    <th colspan="6" class="sort-column guojia">家属信息</th>
		    </tr>
		    <tr>
			    <th class="sort-column khmc">与股东的关系</th>
			    <th class="sort-column khmc">姓名</th>
			    <th class="sort-column guojia">身份证号</th>
			    <th class="sort-column zjzzcs">性别</th>
			    <th class="sort-column flmzb">年龄</th>
			    <th class="sort-column khjm">占股比</th>
		    </tr>
		    </thead>
		    <tbody>

		    <c:forEach items="${gdMap}" var="gdMap" >
			    <c:if test="${gdMap.key.khlx == '1'}" >
				    <c:if test="${not empty gdMap.value}" >
					    <c:set var="gdMapValue" value="${gdMap.value}"/>
				    </c:if>
				    <tr>
					    <td rowspan="${gdMapValue.size()}">
						    <c:if test="${gdMap.key.khlx == '1'}">
							    股东
						    </c:if>
					    </td>
					    <td rowspan="${gdMapValue.size()}">  <c:out value="${gdMap.key.gdxm}" /></td>
					    <td rowspan="${gdMapValue.size()}"> <c:out value="${gdMap.key.sfzh}" /> </td>
					    <td rowspan="${gdMapValue.size()}">  <c:out value="${gdMap.key.xb}" /> </td>
					    <td rowspan="${gdMapValue.size()}">  <c:out value="${gdMap.key.nl}" /> </td>
					    <td rowspan="${gdMapValue.size()}"> <c:out value="${gdMap.key.zgb}" /> </td>
				    </tr>
						    <c:if test="${empty gdMap.value}">

							   <td>

							   </td>
							   <td>

							   </td>
							   <td>

							   </td>
							   <td>

							   </td>
							   <td>

							   </td>
							   <td>

							   </td>
						   </c:if>
						   <c:forEach items="${gdMap.value}" var="gdList">

							   <td>
								   <c:if test="${gdMap.key.jtcy == '0'}">
									   本人
								   </c:if>
								   <c:if test="${gdMap.key.jtcy == '1'}">
									   配偶
								   </c:if>
								   <c:if test="${gdMap.key.jtcy == '2'}">
									   女儿
								   </c:if>
								   <c:if test="${gdMap.key.jtcy == '3'}">
									   儿子
								   </c:if>
								   <c:if test="${gdMap.key.jtcy == '4'}">
									   兄弟
								   </c:if>
								   <c:if test="${gdMap.key.jtcy == '5'}">
									   姐妹
								   </c:if>
								   <c:if test="${gdMap.key.jtcy == '6'}">
									   父母
								   </c:if>
								   <c:if test="${gdMap.key.jtcy == '7'}">
									   朋友
								   </c:if>
								   <c:if test="${gdMap.key.jtcy == '8'}">
									   其它
								   </c:if>
							   </td>
							   <td>
								   <c:out value="${gdList.gdxm}" />
							   </td>
							   <td>
								   <c:out value="${gdList.sfzh}" />
							   </td>
							   <td>
								   <c:out value="${gdList.xb}" />
							   </td>
							   <td>
								   <c:out value="${gdList.nl}" />
							   </td>
							   <td>
								   <c:out value="${gdList.zgb}" />
							   </td>

						   </c:forEach>

				   </c:if>
			   </c:forEach>
		    </tbody>
	    </table>
	 <br/>
	<div class="row">
	    <div class="col-sm-12">
		    <h3>生意资金构成:</h3>
	    </div>
	</div>
	    <br/>

	    <br/>
	    <div id="syzjgcJson" style="width:800px; height: 500px"> </div>
	    <br/>
	    <span>	客户承诺自有资金投入 xx元，按生意规模判断自有资金投入xx元，差异金额多少，推算后：</span>
	    <br/>
	    <div id="tshzjjgJson" style="width:800px; height: 500px"></div>
	    <br/>
	<br/>
	    <div class="row">
		    <div class="col-sm-12">
			    <h3>未结清款项明细</h3>
		    </div>
	    </div>
	    <br/>
	    <table id="wjqkxmxTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
		    <thead>
		    <tr>
			    <th  rowspan="2" class="sort-column khmc">融资机构</th>
			    <th  rowspan="2" class="sort-column khmc">融资金额</th>
			    <th   rowspan="2" class="sort-column guojia">融资时间段</th>

		    </tr>
		    </thead>
		    <tbody>
				<c:forEach items="${keRzlist}" var="keRz">
					<tr>
						<td>${keRz.rzjg}</td>
						<td>${keRz.rzje}</td>
						<td><fmt:formatDate pattern="yyyy-MM-dd" value="${keRz.rzkssj}" /> ~ <fmt:formatDate pattern="yyyy-MM-dd"
						                                                                value="${keRz.rzjssj}" /></td>
					</tr>
				</c:forEach>

		    </tbody>
	    </table>

	    <br/>
	    <div class="row">
		    <div class="col-sm-12">
			    <h3>客户销售数据明细汇总</h3>
			    <br/>
			    <span>时间：</span>
			    <select name="beginNianfen" id="beginNianfen"  class="form-control input-sm"  style="width: 120px;display: inline" >
			    </select>~
			    <select name="endNianfen" id="endNianfen"  class="form-control input-sm"  style="width: 120px;display: inline" >
			    </select>

			    <span>统计字段</span>
			    <select name="tjName"  class="form-control m-b" style="width: 120px;display: inline">
				    <option value="1" label="销售收入"></option>
				    <option value="2" label="净值"></option>
				    <option value="3" label="税额"></option>
				    <option value="4" label="战略价金额"></option>
			    </select>
			    <button  style="width: 150px;display: inline;" class="form-control btn btn-white btn-sm" onclick="search()" > 查询</button>
		    </div>
	    </div>

	    <br/>

	    <table id="khxssjhzTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
		    <thead>
		    <tr>
			    <th  class="sort-column nianfen">年份</th>
			    <th  class="sort-column num">总计</th>
			    <th  class="sort-column yiyue">1月</th>
			    <th  class="sort-column eryue">2月</th>
			    <th  class="sort-column sanyue">3月</th>
			    <th  class="sort-column siyue">4月</th>
			    <th  class="sort-column wuyue">5月</th>
			    <th  class="sort-column liuyue">6月</th>
			    <th  class="sort-column qiyue">7月</th>
			    <th  class="sort-column bayue">8月</th>
			    <th  class="sort-column jiuyue">9月</th>
			    <th  class="sort-column shiyue">10月</th>
			    <th  class="sort-column syyyue">11月</th>
			    <th  class="sort-column seyyue">12月</th>
			    <%--<th>操作</th>--%>
		    </tr>
		    </thead>
		    <tbody>
		    <c:forEach items="${xssjhzlist}" var="item">
			    <tr>
				    <td>
						    ${item.nianfen}
				    </td>
				    <td>
					    <fmt:formatNumber  value="${item.num/10000}"  pattern="#,###,###,###"/>
				    </td>
				    <td>
					    <fmt:formatNumber  value="${item.yiyue/10000}"  pattern="#,###,###,###"/>
				    </td>
				    <td>
					    <fmt:formatNumber  value="${item.eryue/10000}"  pattern="#,###,###,###"/>
				    </td>
				    <td>
					    <fmt:formatNumber  value="${item.sanyue/10000}"  pattern="#,###,###,###"/>
				    </td>
				    <td>
					    <fmt:formatNumber  value="${item.siyue/10000}"  pattern="#,###,###,###"/>
				    </td>
				    <td>
					    <fmt:formatNumber  value="${item.wuyue/10000}"  pattern="#,###,###,###"/>
				    </td>
				    <td>
					    <fmt:formatNumber  value="${item.liuyue/10000}"  pattern="#,###,###,###"/>
				    </td>
				    <td>
					    <fmt:formatNumber  value="${item.qiyue/10000}"  pattern="#,###,###,###"/>
				    </td>
				    <td>
					    <fmt:formatNumber  value="${item.bayue/10000}"  pattern="#,###,###,###"/>
				    </td>
				    <td>
					    <fmt:formatNumber  value="${item.jiuyue/10000}"  pattern="#,###,###,###"/>
				    </td>
				    <td>
					    <fmt:formatNumber  value="${item.shiyue/10000}"  pattern="#,###,###,###"/>
				    </td>
				    <td>
					    <fmt:formatNumber  value="${item.syyyue/10000}"  pattern="#,###,###,###"/>
				    </td>
				    <td>
					    <fmt:formatNumber  value="${item.seyyue/10000}"  pattern="#,###,###,###"/>
				    </td>

			    </tr>
		    </c:forEach>
		    </tbody>
	    </table>
	    <br/><br/>
	    <div class="row">
		    <div class="col-sm-12">
			    <h3>目标核心企业进货未开票数据情况： 中粮福临门</h3>
		    </div>
	    </div>
	    <br/>

	   <%-- <div class="row">
		    <div class="col-sm-12">
			    <h3>销售客户明细：时间段：2018-1-1至今    销售额降序排列</h3>
		    </div>
	    </div>
	    <br/>



	    <div class="row">
		    <div class="col-sm-12">
			    <h3>近3个月前5大客户开票数据（数据取自发票数据金税发票接口-销项）</h3>
		    </div>
	    </div>
	    <br/>





	    <div class="row">
		    <div class="col-sm-12">
			    <h3>供应商明细：</h3>
		    </div>
	    </div>
	    <br/>



	    <div class="row">
		    <div class="col-sm-12">
			    <h3>供应商开票数据（数据取自发票数据金税发票接口-进项）</h3>
		    </div>
	    </div>
	    <br/>


	    <div class="row">
		    <div class="col-sm-12">
			    <h3> 供应商开票数据（数据取自发票数据金税发票接口-进项）</h3>
		    </div>
	    </div>
	    <br/>

	    <div class="row">
		    <div class="col-sm-12">
			    <h3> 开给各供应商的费用发票情况：（来源：发票接口-销项）</h3>
		    </div>
	    </div>
	    <br/>



	    <div class="row">
		    <div class="col-sm-12">
			    <h3>  客户授信额度建议：（年份为动态年份，计算平均销售取近3年平均销售额,当年实时销售单列）</h3>
		    </div>
	    </div>
	    <br/>




--%>





	    <br/>
	    <br/>
	</div>
	</div>
</div>
</form:form>
</body>
</html>