<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>融资信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			laydate({
	            elem: '#rzjssj', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
	        });
			laydate({
	            elem: '#rzkssj', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
	        });
		});
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>融资信息列表 </h5>
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
	<form:form id="searchForm" modelAttribute="keRz" action="${ctx}/kerz/keRz/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<span>融资机构：</span>
				<form:input path="rzjg" htmlEscape="false" maxlength="255"  class=" form-control input-sm"/>
			<span>融资金额：</span>
				<form:input path="rzje" htmlEscape="false" maxlength="255"  class=" form-control input-sm"/>
			<span>开始时间：</span>
			<input id="rzkssj" name="rzkssj" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
			       value="<fmt:formatDate value="${keRz.rzkssj}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
			<span>结束时间：</span>
				<input id="rzjssj" name="rzjssj" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
					value="<fmt:formatDate value="${keRz.rzjssj}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
			<br/><br/>
			<span>是否已经结清：</span>
				<form:radiobuttons class="i-checks" path="isJq" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
		 </div>	
	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<%--<shiro:hasPermission name="kerz:keRz:add">
				<table:addRow url="${ctx}/kerz/keRz/form" title="客户融资"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>--%>
			<shiro:hasPermission name="kerz:keRz:edit">
			    <table:editRow url="${ctx}/kerz/keRz/form" title="客户融资" id="contentTable"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="kerz:keRz:del">
				<table:delRow url="${ctx}/kerz/keRz/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<%--<shiro:hasPermission name="kerz:keRz:import">
				<table:importExcel url="${ctx}/kerz/keRz/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="kerz:keRz:export">
	       		<table:exportExcel url="${ctx}/kerz/keRz/export"></table:exportExcel><!-- 导出按钮 -->
	       	</shiro:hasPermission>--%>
	       <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
		
			</div>
		<div class="pull-right">
			<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="search()" ><i class="fa fa-search"></i> 查询</button>
			<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>
		</div>
	</div>
	</div>
	
	<!-- 表格 -->
	<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
		<thead>
			<tr>
				<th> <input type="checkbox" class="i-checks"></th>
				<th  class="sort-column rckhzl.khmc">客户名称</th>
				<th  class="sort-column rzjg">融资机构</th>
				<th  class="sort-column rzje">融资金额</th>
				<th  class="sort-column rzjssj">融资时间段</th>
				<th  class="sort-column isJq">是否已经结清</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="keRz">
			<tr>
				<td> <input type="checkbox" id="${keRz.id}" class="i-checks"></td>
				<td>
						${keRz.rckhzl.khmc}
				</td>
				<td><a  href="#" onclick="openDialogView('查看客户融资', '${ctx}/kerz/keRz/form?id=${keRz.id}','800px', '500px')">
					${keRz.rzjg}
				</a></td>


				<td>
					${keRz.rzje}
				</td>
				<td>
					<fmt:formatDate value="${keRz.rzjssj}" pattern="yyyy-MM-dd"/>~<fmt:formatDate value="${keRz.rzkssj}" pattern="yyyy-MM-dd"/>
				</td>

				<td>
					${fns:getDictLabel(keRz.isJq, '', '')}
							${keRz.isJq == '0'?'否':'是'}
				</td>
				<td>
					<shiro:hasPermission name="kerz:keRz:view">
						<a href="#" onclick="openDialogView('查看客户融资', '${ctx}/kerz/keRz/form?id=${keRz.id}','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="kerz:keRz:edit">
    					<a href="#" onclick="openDialog('修改客户融资', '${ctx}/kerz/keRz/form?id=${keRz.id}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="kerz:keRz:del">
						<a href="${ctx}/kerz/keRz/delete?id=${keRz.id}" onclick="return confirmx('确认要删除该客户融资吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
					</shiro:hasPermission>
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