<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>开票汇总统计管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
	        laydate({
	            elem: '#beginKprq', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
	        });
	        laydate({
	            elem: '#endKprq', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
	        });
					
		
		});
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>开票汇总统计列表 </h5>
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
	<form:form id="searchForm" modelAttribute="kphzTj" action="${ctx}/fptj/kphzTj/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<span>项目：</span>
				<form:input path="tjxm" htmlEscape="false" maxlength="255"  class=" form-control input-sm"/>
			<span>开票时间：</span>
				<input id="beginKprq" name="beginKprq" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
					value="<fmt:formatDate value="${kphzTj.beginKprq}" pattern="yyyy-MM-dd HH:mm:ss"/>"/> - 
				<input id="endKprq" name="endKprq" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
					value="<fmt:formatDate value="${kphzTj.endKprq}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
		 </div>	
	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<shiro:hasPermission name="fptj:kphzTj:add">
				<table:addRow url="${ctx}/fptj/kphzTj/form" title="开票汇总统计"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="fptj:kphzTj:edit">
			    <table:editRow url="${ctx}/fptj/kphzTj/form" title="开票汇总统计" id="contentTable"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="fptj:kphzTj:del">
				<table:delRow url="${ctx}/fptj/kphzTj/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="fptj:kphzTj:import">
				<table:importExcel url="${ctx}/fptj/kphzTj/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="fptj:kphzTj:export">
	       		<table:exportExcel url="${ctx}/fptj/kphzTj/export"></table:exportExcel><!-- 导出按钮 -->
	       	</shiro:hasPermission>
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
				<th  class="sort-column tjxm">项目</th>
				<th  class="sort-column yqsl">17税率</th>
				<th  class="sort-column yysl">11税率</th>
				<th  class="sort-column liusl">6税率</th>
				<th  class="sort-column lingsl">0税率</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="kphzTj">
			<tr>
				<td> <input type="checkbox" id="${kphzTj.id}" class="i-checks"></td>
				<td><a  href="#" onclick="openDialogView('查看开票汇总统计', '${ctx}/fptj/kphzTj/form?id=${kphzTj.id}','800px', '500px')">
					${kphzTj.tjxm}
				</a></td>
				<td>
					${kphzTj.yqsl}
				</td>
				<td>
					${kphzTj.yysl}
				</td>
				<td>
					${kphzTj.liusl}
				</td>
				<td>
					${kphzTj.lingsl}
				</td>
				<td>
					<shiro:hasPermission name="fptj:kphzTj:view">
						<a href="#" onclick="openDialogView('查看开票汇总统计', '${ctx}/fptj/kphzTj/form?id=${kphzTj.id}','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="fptj:kphzTj:edit">
    					<a href="#" onclick="openDialog('修改开票汇总统计', '${ctx}/fptj/kphzTj/form?id=${kphzTj.id}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="fptj:kphzTj:del">
						<a href="${ctx}/fptj/kphzTj/delete?id=${kphzTj.id}" onclick="return confirmx('确认要删除该开票汇总统计吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
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