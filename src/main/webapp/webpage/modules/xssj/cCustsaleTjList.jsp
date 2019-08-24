<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>企业核心销售数据统计管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
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

			var bn = $('#beginNianfen').val();
			var en = $('#endNianfen').val();

			console.info(bn);
			console.info(en);

			var myDate= new Date();
			var startYear=myDate.getFullYear()-10;//起始年份
			var endYear=myDate.getFullYear();//结束年份

			var html1 = "";

			for (var a=startYear;a<=endYear;a++){
				var myDate1= new Date();
				myDate1.setFullYear(a);
				myDate1.setDate(1);
				myDate1.setMonth(0);
				if(a == bn){
					html1 += "<option selected=\"selected\" value='"+ bn +"'>"+bn+"年"+"</option>";
				}{
					html1 +="<option value='"+myDate1.getFullYear().toString()+"'>"+a+"年"+"</option>";
				}
			}

			$('#beginNianfen').append(html1);



			var str = "";

			for (var i=startYear;i<=endYear;i++){
				var myDate2= new Date();
				myDate2.setFullYear(i);
				myDate2.setMonth(11);//12月

				myDate2.setDate((new Date(myDate2.getTime()-1000*60*60*24)).getDate());

				if(i == en){
					html1 += "<option selected=\"selected\" value='"+ en +"'>"+en+"年"+"</option>";
				}else{
					str += "<option value='"+i+"'>"+i+"年"+"</option>";
				}
			}
			$('#endNianfen').append(str);

			var source = new Array();
			var search = $("#ckname");
			search.autocomplete({
				source:source,
				messages: {  //message设置不出现匹配关键字的结果
					noResults: '',
					results: function() {

					}
				}
			});
			search.keyup(function(){
				if(jsonData && jsonData.length>0){
					for(var i in jsonData){
						source[i] = jsonData[i].custName;
						
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
		<h5>企业核心销售数据统计列表 </h5>
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
	<form:form id="searchForm" modelAttribute="cCustsaleTj" action="${ctx}/xssj/cCustsaleTj/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<%--<input id="bn" name="beginNianfen" type="hidden" value="${cCustsaleTj.beginNianfen}"/>
		<input id="en" name="endNianfen" type="hidden" value="${cCustsaleTj.endNianfen}"/>--%>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">

			<%--<span>查询名称，公司名称：</span>
				<form:input path="ckname" htmlEscape="false" maxlength="500"  class=" form-control input-sm"/>--%>

			<span>客户名称：</span>
			<form:input path="ckname" htmlEscape="false"  class=" form-control input-sm"/>



			<span>时间：</span>
				<form:select   path="beginNianfen" class="form-control m-b" style="width:100px">
					<form:option value="${cCustsaleTj.beginNianfen}">
						${cCustsaleTj.beginNianfen}年
					</form:option>
				</form:select>
				--
				<form:select    path="endNianfen" class="form-control m-b" style="width:100px">
					<form:option value="${cCustsaleTj.endNianfen}">
						${cCustsaleTj.endNianfen}年
					</form:option>
				</form:select >



			<span>统计字段<%--,1年销售收入，2净值，3税额，4战略价金额：--%></span>
				<form:select path="tjname"  class="form-control m-b">
					<form:option value="1" label="销售收入"></form:option>
					<form:option value="2" label="净值"></form:option>
					<form:option value="3" label="税额"></form:option>
					<form:option value="4" label="战略价金额"></form:option>

					<%--<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>--%>
				</form:select>


				<button  class="form-control btn btn-white btn-sm" onclick="search()" > 查询</button>
		 </div>	
	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	    <div class="row">
		    <div class="col-sm-12">
			 <%--   <div class="pull-left">
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
				<%--<th> <input type="checkbox" class="i-checks"></th>--%>
					<th  class="sort-column ckname">公司名称</th>
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
		<c:forEach items="${page.list}" var="item">
			<tr>
				<%--<td> <input type="checkbox" id="${cCustsaleTj.id}" class="i-checks"></td>--%>
					<td>

							<%--<a  href="#" onclick="openDialogView('查看企业核心销售数据统计', '${ctx}/xssj/CCustsaleTj/form?id=${cCustsaleTj.id}','800px', '500px')">
							${fns:getDictLabel(cCustsaleTj.nianfen, '', '')}
							</a>--%>

							${item.ckname}

					</td>
					<td>

					<%--<a  href="#" onclick="openDialogView('查看企业核心销售数据统计', '${ctx}/xssj/CCustsaleTj/form?id=${cCustsaleTj.id}','800px', '500px')">
					${fns:getDictLabel(cCustsaleTj.nianfen, '', '')}
					</a>--%>

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
				<%--<td>
					<shiro:hasPermission name="xssj:CCustsaleTj:view">
						<a href="#" onclick="openDialogView('查看企业核心销售数据统计', '${ctx}/xssj/CCustsaleTj/form?id=${CCustsaleTj.id}','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="xssj:CCustsaleTj:edit">
    					<a href="#" onclick="openDialog('修改企业核心销售数据统计', '${ctx}/xssj/CCustsaleTj/form?id=${CCustsaleTj.id}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="xssj:CCustsaleTj:del">
						<a href="${ctx}/xssj/CCustsaleTj/delete?id=${CCustsaleTj.id}" onclick="return confirmx('确认要删除该企业核心销售数据统计吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
					</shiro:hasPermission>
				</td>--%>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	
		<!-- 分页代码 -->
	<table:page page="${page}"></table:page>
	<br/>
	<br/>
	</div>
	</div>
</div>
</body>
</html>