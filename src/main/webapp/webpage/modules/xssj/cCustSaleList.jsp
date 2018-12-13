<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<jsp:useBean id="cCustSale"  class="com.jeeplus.modules.xssj.entity.CCustSale" scope="request" ></jsp:useBean>
<html>
<head>
	<title>企业核心数据管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
	        laydate({
	            elem: '#beginFapiaoshiqi', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
	        });
	        laydate({
	            elem: '#endFapiaoshiqi', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
	        });


		});
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>企业核心数据列表 </h5>
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
	<form:form id="searchForm" modelAttribute="cCustSale" action="${ctx}/xssj/cCustSale/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<span>客户名称：</span>
				<form:input path="custName" htmlEscape="false"  class=" form-control input-sm"/>


			<span>出具发票日期：</span>
				<input id="beginFapiaoshiqi" name="beginFapiaoshiqi" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
					value="<fmt:formatDate value="${cCustSale.beginFapiaoshiqi}" pattern="yyyy-MM-dd HH:mm:ss"/>"/> -
				<input id="endFapiaoshiqi" name="endFapiaoshiqi" type="text" maxlength="20" class="laydate-icon form-control layer-date input-sm"
					value="<fmt:formatDate value="${cCustSale.endFapiaoshiqi}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
		 </div>	
	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<shiro:hasPermission name="xssj:cCustSale:add">
				<table:addRow url="${ctx}/xssj/cCustSale/form" title="企业核心数据"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="xssj:cCustSale:edit">
			    <table:editRow url="${ctx}/xssj/cCustSale/form" title="企业核心数据" id="contentTable"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="xssj:cCustSale:del">
				<table:delRow url="${ctx}/xssj/cCustSale/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="xssj:cCustSale:import">
				<table:importExcel url="${ctx}/xssj/cCustSale/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="xssj:cCustSale:export">
	       		<table:exportExcel url="${ctx}/xssj/cCustSale/export"></table:exportExcel><!-- 导出按钮 -->
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
				<th  class="sort-column dingdanbianhao">订单号码</th>
				<th  class="sort-column custNo">客户代码</th>
				<th  class="sort-column custName">客户名称</th>
				<th  class="sort-column daqu">大区</th>


				<th  class="sort-column dapinleimiaoshu">大品类描述</th>
				<th  class="sort-column xiang">箱</th>
				<th  class="sort-column dun">吨</th>
				<th  class="sort-column xiaoshoushouru">销售收入</th>
				<th  class="sort-column jingzhi">净值</th>
				<th  class="sort-column shuie">税额</th>
				<th  class="sort-column zhanlvjine">战略价金额</th>
				<th  class="sort-column zhekoujine">折扣金额</th>
				<th  class="sort-column zhekoubili">折扣百分比</th>
				<th  class="sort-column shoudafangjiancheng">售达方简称</th>
				<th  class="sort-column fapiaoshiqi">发票日期</th>

				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cCustSale">
			<tr>
				<td> <input type="checkbox" id="${cCustSale.id}" class="i-checks"></td>
				<td>
					<a  href="#" onclick="openDialogView('查看企业核心数据', '${ctx}/xssj/cCustSale/form?id=${cCustSale.id}','800px', '500px')">
						${cCustSale.dingdanbianhao}
					</a>
				</td>
				<td>
						${cCustSale.custNo}
				</td>
				<td>
						${cCustSale.custName}
				</td>
				<td>
					${cCustSale.daqu}
				</td>


				<td>
					${cCustSale.dapinleimiaoshu}
				</td>
				<td>
					${cCustSale.xiang}
				</td>
				<td>
					${cCustSale.dun}
				</td>
				<td>
					${cCustSale.xiaoshoushouru}
				</td>
				<td>
					${cCustSale.jingzhi}
				</td>
				<td>
					${cCustSale.shuie}
				</td>
				<td>
					${cCustSale.zhanlvjine}
				</td>
				<td>
					${cCustSale.zhekoujine}
				</td>
				<td>
					${cCustSale.zhekoubili}
				</td>
				<td>
					${cCustSale.shoudafangjiancheng}
				</td>
				<td>
					<fmt:formatDate value="${cCustSale.fapiaoshiqi}" pattern="yyyy-MM-dd"/>
				</td>

				<td>
					<shiro:hasPermission name="xssj:cCustSale:view">
						<a href="#" onclick="openDialogView('查看企业核心数据', '${ctx}/xssj/cCustSale/form?id=${cCustSale.id}','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="xssj:cCustSale:edit">
    					<a href="#" onclick="openDialog('修改企业核心数据', '${ctx}/xssj/cCustSale/form?id=${cCustSale.id}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="xssj:cCustSale:del">
						<a href="${ctx}/xssj/cCustSale/delete?id=${cCustSale.id}" onclick="return confirmx('确认要删除该企业核心数据吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
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