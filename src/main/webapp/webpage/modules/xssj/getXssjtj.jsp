<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<jsp:useBean id="CCustsaleTj"  class="com.jeeplus.modules.xssj.entity.CCustsaleTj" scope="request" ></jsp:useBean>
<html>
<head>
	<title>企业核心数据管理</title>
	<meta name="decorator" content="default"/>

	<script type="text/javascript">

		$(function () {

			var myDate= new Date();
			var startYear=myDate.getFullYear()-10;//起始年份
			var endYear=myDate.getFullYear();//结束年份

			var html1 = "";

			for (var a=startYear;a<=endYear;a++){
				var myDate1= new Date();
				myDate1.setFullYear(a);
				myDate1.setDate(1);
				myDate1.setMonth(0);
				if(a == (endYear-1)){
					html1 += "<option selected=\"selected\" value='"+myDate1+"'>"+a+"年"+"</option>";
				}else {
					html1 +="<option value='"+myDate1+"'>"+a+"年"+"</option>";
				}
			}
			$('#beginNianfen').append(html1);
			var str = "";

			for (var i=startYear;i<=endYear;i++){
				var myDate2= new Date();
				myDate2.setFullYear(i);
				myDate2.setMonth(11);//12月
				myDate2.setDate((new Date(myDate2.getTime()-1000*60*60*24)).getDate());
				if(i == endYear){
					var date = new Date();
					str += "<option selected=\"selected\" value='"+date+"'>"+i+"年"+"</option>";
				}else{
					var myDate3 = myDate2.getFullYear()+"-"+myDate2.getMonth()+"-"+myDate2.getDate()+" 23:59:59";
					str += "<option value='"+myDate3+"'>"+i+"年"+"</option>";
				}
			}
			$("#endNianfen").append(str);
		});
		var jsonData ;
		$(document).ready(function() {
			$.ajax({
				type:"POST",
				url:"${ctx}/xssj/cCustSale/search",
				data:{searchName:$("#ckname").val()},
				success:function(data) {
					jsonData = eval(data); //将json转换为对象的方法
				}
			});






			var source = new Array();
			var search = $("#ckname");
			search.autocomplete({
				source:source,
				messages: {  //message设置不出现匹配关键字的结果
					noResults: '',
					results: function() {}
				}
			});
			search.keyup(function(){
				if(jsonData && jsonData.length>0){
					for(var i in jsonData){
						if(jsonData[i].hasOwnProperty("custName")){
							source[i] = jsonData[i].custName;
						}

					}
				}
			});

		});
	</script>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content">
	<div class="ibox">
		<div class="ibox-title">
			<h5>销售数据年月分析 </h5>
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
					<form:form id="searchForm" modelAttribute="cCustsaleTj" action="${ctx}/xssj/cCustSale/getXssjtj" method="post" class="form-inline">

						<div class="form-group">
							<span>客户名称：</span>
							<form:input path="ckname" htmlEscape="false"  class=" form-control input-sm"/>

							<span>统计字段：</span>
							<form:select path="tjname" class=" form-control m-b">
								<form:option value="1" label="销售收入"></form:option>
								<form:option value="2" label="净值"></form:option>
								<form:option value="3" label="税额"></form:option>
								<form:option value="4" label="战略价金额"></form:option>
							</form:select>

							<span>发票日期：</span>
							<%--<input id="beginNianfen" name="beginNianfen" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
							       value="<fmt:formatDate value="${CCustsaleTj.beginNianfen}" pattern="yyyy"/>"/> -
							<input id="endNianfen" name="endNianfen" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
							       value="<fmt:formatDate value="${CCustsaleTj.endNianfen}" pattern="yyyy"/>"/>--%>

							<select  name="beginNianfen" id="beginNianfen" class="form-control m-b" style="width:100px">

							</select>
							--
							<select   name="endNianfen" id="endNianfen"  class="form-control m-b" style="width:100px">

							</select>

							<button  class="form-control btn btn-white btn-sm" onclick="search()" > 查询</button>
						</div>
					</form:form>
					<%--<button  class="btn btn-white btn-sm" onclick="search()" ><i class="fa fa-search"></i> 查询</button>
					<button  class="btn btn-white btn-sm" onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>
					<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
--%>
				</div>
			</div>

			<!-- 工具栏 -->
			<%--<div class="row">
				<div class="col-sm-12">
					<button  class="btn btn-white btn-sm" onclick="search()" ><i class="fa fa-search"></i> 查询</button>
					<button  class="btn btn-white btn-sm" onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>
					<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>


				</div>
			</div>--%>
<br/>
			<div class="row">
				<div class="col-sm-12">
					<%--<div class="pull-left">
						&nbsp;&nbsp;&nbsp;&nbsp; 平均年度销售额：0万元，推荐授信额度为：0万元（公式：年均销售额/6）
					</div>
					<div class="pull-right">
					(单位：万元) &nbsp;&nbsp;&nbsp;&nbsp;
					</div>--%>
				</div>
			</div>
			<!-- 表格 -->
			<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
				<thead>
				<tr>

					<th  class="sort-column nianfen">年份</th>
					<th  class="sort-column num">总计</th>
					<th  class="sort-column yiyue">1月份</th>
					<th  class="sort-column eryue">2月份</th>
					<th  class="sort-column sanyue">3月份</th>
					<th  class="sort-column siyue">4月份</th>
					<th  class="sort-column wuyue">5月份</th>
					<th  class="sort-column liuyue">6月份</th>
					<th  class="sort-column qiyue">7月份</th>
					<th  class="sort-column bayue">8月份</th>
					<th  class="sort-column jiuyue">9月份</th>
					<th  class="sort-column shiyue">10月份</th>
					<th  class="sort-column syyyue">11月份</th>
					<th  class="sort-column seyyue">12月份</th>

				</tr>
				</thead>
				<tbody>
				<c:forEach items="${cctjList}" var="item">

					<tr>
						<td>
								${item.nianfen}

						</td>
						<td>
						<c:if test="${cCustsaleTj.tjname == '1'}">
							<fmt:formatNumber  value="${item.numyi/10000}"  pattern="#,###,###,###"/>
						</c:if>

						<c:if test="${cCustsaleTj.tjname == '2'}">
							<fmt:formatNumber  value="${item.numer/10000}"  pattern="#,###,###,###"/>

						</c:if>
						<c:if test="${cCustsaleTj.tjname == '3'}">
							<fmt:formatNumber  value="${item.numsan/10000}"  pattern="#,###,###,###"/>

						</c:if>
						<c:if test="${item.tjname == '4'}">

							<fmt:formatNumber  value="${item.numsi/10000}"  pattern="#,###,###,###"/>
						</c:if>
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
							<fmt:formatNumber  value="	${item.seyyue/10000}"  pattern="#,###,###,###"/>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>


			<br/>
			<br/>
		</div>
	</div>
</div>
</body>
</html>