<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>授信额度统计管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript" src="${ctxStatic}/bootstrap/3.3.4/js/bootstrap3-typeahead.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$.ajax({
				type:"POST",
				url:"${ctx}/xssj/cCustSale/search",
				data:{"searchName":$("#khmc").val()},
				success:function(data){
					var source = data;
					$("#ckname").typeahead({
						minLength: 2,//键入字数多少开始补全
						showHintOnFocus: "true",//将显示所有匹配项
						fitToElement: true,//选项框宽度与输入框一致
						items: "all",//提示数量上限
						autoSelect: true,
						source: source// 数据源
					});
				}
			});
			var yuefen = ${cSxeduTj.yuefen};

			if(yuefen){
				$("#yuefen option[value='${cSxeduTj.yuefen}']").attr("selected","selected");

			}
		});
		function clearInput() {
			$("#ckname").val("");
		}
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>授信额度统计列表 </h5>
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
	<form:form id="searchForm" modelAttribute="cSxeduTj" action="${ctx}/xssj/cSxeduTj/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<span>客户名称：</span>
			<input id="ckname" name="ckName" value="${cSxeduTj.ckName}" autocomplete="off" data-provide="typeahead" class=" form-control input-sm">
			<span>时间：</span>
			<%--<form:select path="yuefen" items="${fns:getDictList('yuefen')}" itemLabel="label" itemValue="value" htmlEscape="false" class=" form-control m-b"/>
--%>
			<select id = "yuefen" name="yuefen" class=" form-control m-b">
				<option value="1" >1月</option>
				<option value="2" >2月</option>
				<option value="3" >3月</option>
				<option value="4" >4月</option>
				<option value="5" >5月</option>
				<option value="6" >6月</option>
				<option value="7" >7月</option>
				<option value="8" >8月</option>
				<option value="9" >9月</option>
				<option value="10" >10月</option>
				<option value="11" >11月</option>
				<option value="12" >12月</option>
			</select>

			<span>合作状态：</span>
			<form:radiobuttons path="sfhz" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required i-checks "/>

			<button  class="btn btn-primary  btn-outline btn-sm " onclick="search()" ><i class="fa fa-search"></i> 查询</button>
			<%--<button  class="btn btn-primary  btn-outline btn-sm " onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>--%>
			<button  class="btn btn-primary  btn-outline btn-sm " onclick="clearInput()" ><i class="fa fa-refresh"></i> 清空</button>
		</div>

	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<span><strong>截至<c:forEach items="${ztds}" var="ztdsMap" >

				${ztdsMap.jzrq}
			</c:forEach> ，</strong></span>
			<span><strong>福临门整体预算达成率：
							<c:forEach items="${ztds}" var="ztdsMap" >
								<fmt:formatNumber  value="${ztdsMap.sydcl}"  type="percent" maxFractionDigits="2" />
							</c:forEach>
						</strong>
			</span>
			<span><strong>福临门整体全年进度：

			<c:forEach items="${ztds}" var="ztdsMap" >
				<fmt:formatNumber  value="${ztdsMap.qnjd}"  type="percent" maxFractionDigits="2" />
			</c:forEach>
</strong></span>
			<%--<shiro:hasPermission name="xssj:cSxeduTj:add">--%>
				<%--<table:addRow url="${ctx}/xssj/cSxeduTj/form" title="授信额度统计"></table:addRow><!-- 增加按钮 -->--%>
			<%--</shiro:hasPermission>--%>
			<%--<shiro:hasPermission name="xssj:cSxeduTj:edit">--%>
			    <%--<table:editRow url="${ctx}/xssj/cSxeduTj/form" title="授信额度统计" id="contentTable"></table:editRow><!-- 编辑按钮 -->--%>
			<%--</shiro:hasPermission>--%>
			<%--<shiro:hasPermission name="xssj:cSxeduTj:del">--%>
				<%--<table:delRow url="${ctx}/xssj/cSxeduTj/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->--%>
			<%--</shiro:hasPermission>--%>
			<%--<shiro:hasPermission name="xssj:cSxeduTj:import">--%>
				<%--<table:importExcel url="${ctx}/xssj/cSxeduTj/import"></table:importExcel><!-- 导入按钮 -->--%>
			<%--</shiro:hasPermission>--%>

			</div>
		<div class="pull-right">

			<shiro:hasPermission name="xssj:cSxeduTj:export">
				<table:exportExcel url="${ctx}/xssj/cSxeduTj/export"></table:exportExcel><!-- 导出按钮 -->
			</shiro:hasPermission>
			<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>

		</div>
	</div>
	</div>
	
	<!-- 表格 -->
	<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
		<thead>
			<tr>
				<%--<th rowspan="2"> <input type="checkbox" class="i-checks"></th>--%>

				<th  rowspan="2" class="sort-column ckName">融资单位</th>
					<th  rowspan="2"  style="text-align:center" >是否合作</th>
				<th  colspan="6"  style="text-align:center" >销售收入情况</th>

				<th  rowspan="2" class="sort-column ljys">累计预算</th>
				<th  rowspan="2" class="sort-column qnys">全年预算</th>
					<th  rowspan="2" class="sort-column dcl">预算达成率</th>
				<th  rowspan="2" class="sort-column qnjd">全年进度</th>

				<th  rowspan="2" class="sort-column flmzb">福临门占比</th>

				<th  rowspan="2" class="sort-column rzje">外部融资</th>
				<th colspan="2"  style="text-align: center">授信额度</th>

			</tr>
		<tr>

			<th  class="sort-column dsyear">${cSxeduTj.nianfen-3}年</th>
			<th  class="sort-column deyear">${cSxeduTj.nianfen-2}年</th>
			<th  class="sort-column dyyear">${cSxeduTj.nianfen-1}年</th>
			<th  class="sort-column sanyear">近三年平均</th>
			<th  class="sort-column dyear">${cSxeduTj.nianfen}年</th>
			<th  class="sort-column qntqljxs">${cSxeduTj.nianfen-1}年同期</th>
			<th  class="sort-column sxsxed">上限</th>
			<th  class="sort-column sxxxed">下限</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cSxeduTj">
			<tr>
				<%--<td> <input type="checkbox" id="${cSxeduTj.id}" class="i-checks"></td>--%>

				<td>
					${cSxeduTj.ckName}
				</td>
					<td>
								<c:if test="${cSxeduTj.sfhz=='1'}">
									是
								</c:if>
								<c:if test="${cSxeduTj.sfhz=='0'}">
									否
								</c:if>
					</td>
				<td>
						<fmt:formatNumber  value="${cSxeduTj.dsyear/10000}"  pattern="#,###,###,###"/>
				</td>
				<td>
					<fmt:formatNumber  value="${cSxeduTj.deyear/10000}"  pattern="#,###,###,###"/>
				</td>
				<td>
						<fmt:formatNumber  value="${cSxeduTj.dyyear/10000}"  pattern="#,###,###,###"/>
				</td>
				<td>
					<fmt:formatNumber  value="${cSxeduTj.sanyear/10000}"  pattern="#,###,###,###"/>
				</td>
				<td>
						<fmt:formatNumber  value="${cSxeduTj.dyear/10000}"  pattern="#,###,###,###"/>
				</td>
				<td>
						<fmt:formatNumber  value="${cSxeduTj.qntqljxs/10000}"  pattern="#,###,###,###"/>
				</td>
				<td>
						<fmt:formatNumber  value="${cSxeduTj.ljys/10000}"  pattern="#,###,###,###"/>
				</td>

				<td>
						<fmt:formatNumber  value="${cSxeduTj.qnys/10000}"  pattern="#,###,###,###"/>
				</td>
					<td>
						<fmt:formatNumber  value="${cSxeduTj.dcl}"   type="percent" maxFractionDigits="2" />
					</td>
				<td>
					<fmt:formatNumber  value="${cSxeduTj.qnjd}"  type="percent" maxFractionDigits="2" />
				</td>
				<td>
						<fmt:formatNumber  value="${cSxeduTj.flmzb}"   type="percent" maxFractionDigits="2" />
				</td>
				<td>
						<fmt:formatNumber  value="${cSxeduTj.rzje/10000}"  pattern="#,###,###,###"/>
				</td>
				<td>
						<fmt:formatNumber  value="${cSxeduTj.sxsxed/10000}"  pattern="#,###,###,###"/>
				</td>
				<td>
						<fmt:formatNumber  value="${cSxeduTj.sxxxed/10000}"  pattern="#,###,###,###"/>
				</td>
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