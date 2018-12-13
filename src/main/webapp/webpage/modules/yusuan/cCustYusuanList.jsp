<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>客户预算管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {

			var html1 = "";
			var myDate= new Date();
			var startYear = myDate.getFullYear()-5;//起始年份
			var endYear = myDate.getFullYear();//结束年份
			for (var a=startYear;a <= endYear;a++){
				// var myDate1= new Date();
				// myDate1.setFullYear(a);
				// myDate1.setDate(1);
				// myDate1.setMonth(0);
				if(a ==endYear){
					html1 += "<option selected=\"selected\" value='"+a+"'>"+a+"年"+"</option>";
				}else {
					html1 +="<option value='"+a+"'>"+a+"年"+"</option>";
				}
			}
			$('#beginNianfen').append(html1);
		});
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>客户预算列表 </h5>
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
	<form:form id="searchForm" modelAttribute="cCustYusuan" action="${ctx}/yusuan/cCustYusuan/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<span>时间：</span>

			<select  name="nianfen" id="beginNianfen" class="form-control m-b" style="width:100px">

			</select>

			<span>公司名称：</span>
			<input type="text" name="ckname" value="${cCustYusuan.ckname}" class="form-control m-b" />
		 </div>	
	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<shiro:hasPermission name="yusuan:cCustYusuan:add">
				<table:addRow url="${ctx}/yusuan/cCustYusuan/form" title="客户预算"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="yusuan:cCustYusuan:edit">
			    <table:editRow url="${ctx}/yusuan/cCustYusuan/form" title="客户预算" id="contentTable"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="yusuan:cCustYusuan:del">
				<table:delRow url="${ctx}/yusuan/cCustYusuan/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="yusuan:cCustYusuan:import">
				<table:importExcel url="${ctx}/yusuan/cCustYusuan/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="yusuan:cCustYusuan:export">
	       		<table:exportExcel url="${ctx}/yusuan/cCustYusuan/export"></table:exportExcel><!-- 导出按钮 -->
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
				<th  class="sort-column nianfen">时间</th>
				<th  class="sort-column ckname">公司名称</th>
				<th  class="sort-column num">合计</th>
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
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cCustYusuan">
			<tr align="right">
				<td> <input type="checkbox" id="${cCustYusuan.id}" class="i-checks"></td>
				<td><a  href="#" onclick="openDialogView('查看客户预算', '${ctx}/yusuan/cCustYusuan/form?id=${cCustYusuan.id}','800px', '500px')">
					${cCustYusuan.nianfen}
				</a></td>
				<td>
					${cCustYusuan.ckname}
				</td>
				<td>

						<fmt:formatNumber  value="${cCustYusuan.num}"   pattern="#,###,###,###00.00#" />
				</td>
				<td>
						<fmt:formatNumber  value="${cCustYusuan.yiyue}"   pattern="#,###,###,###00.00#" />
				</td>
				<td>
						<fmt:formatNumber  value="${cCustYusuan.eryue}"   pattern="#,###,###,###00.00#" />
				</td>
				<td>
						<fmt:formatNumber  value="${cCustYusuan.sanyue}"   pattern="#,###,###,###00.00#" />
				</td>
				<td>
						<fmt:formatNumber  value="${cCustYusuan.siyue}"   pattern="#,###,###,###00.00#" />
				</td>
				<td>
						<fmt:formatNumber  value="${cCustYusuan.wuyue}"   pattern="#,###,###,###00.00#" />
				</td>
				<td>
						<fmt:formatNumber  value="${cCustYusuan.liuyue}"   pattern="#,###,###,###00.00#" />
				</td>
				<td>
						<fmt:formatNumber  value="${cCustYusuan.qiyue}"   pattern="#,###,###,###00.00#" />
				</td>
				<td>
						<fmt:formatNumber  value="${cCustYusuan.bayue}"   pattern="#,###,###,###00.00#" />
				</td>
				<td>
						<fmt:formatNumber  value="${cCustYusuan.jiuyue}"   pattern="#,###,###,###00.00#" />
				</td>
				<td>
						<fmt:formatNumber  value="${cCustYusuan.shiyue}"   pattern="#,###,###,###00.00#" />
				</td>
				<td>
						<fmt:formatNumber  value="${cCustYusuan.syyyue}"   pattern="#,###,###,###00.00#" />
				</td>
				<td>
						<fmt:formatNumber  value="${cCustYusuan.seyyue}"   pattern="#,###,###,###00.00#" />
				</td>
				<td>
					<shiro:hasPermission name="yusuan:cCustYusuan:view">
						<a href="#" onclick="openDialogView('查看客户预算', '${ctx}/yusuan/cCustYusuan/form?id=${cCustYusuan.id}','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="yusuan:cCustYusuan:edit">
    					<a href="#" onclick="openDialog('修改客户预算', '${ctx}/yusuan/cCustYusuan/form?id=${cCustYusuan.id}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="yusuan:cCustYusuan:del">
						<a href="${ctx}/yusuan/cCustYusuan/delete?id=${cCustYusuan.id}" onclick="return confirmx('确认要删除该客户预算吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
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