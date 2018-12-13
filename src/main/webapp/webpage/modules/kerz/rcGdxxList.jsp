<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>股东信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$.ajax({
				type: "POST",
				url: "${ctx}/kerz/rcKhzl/getRcKhzlmc?time="+ new Date().getTime(),
				dataType: "json",
				success: function(data){

					data = eval(data);
					var html = '';
					$("#rcKhzlId").html('');
					if(data){
						html += '<option value=""></option>';
						for (var i = 0; i < data.length; i++) {

							html += '<option value="'+data[i].id+'">'+ data[i].khmc+'</option>';
						}

					}else{
						html += '<option value=""></option>';
					}

					$("#rcKhzlId").html(html);
				}
			});
		});
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>股东信息列表 </h5>
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
	<form:form id="searchForm" modelAttribute="rcGdxx" action="${ctx}/kerz/rcGdxx/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<span>客户名称：</span>

			<select id="rcKhzlId" name="rcKhzl.id"  class="form-control m-b">

			</select>

			<span>类型：</span>
				<form:select path="khlx"  class="form-control m-b">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('rcgd_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			<span>姓名：</span>
				<form:input path="gdxm" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
			<span>是否已婚：</span>
				<form:radiobuttons class="i-checks" path="isMarry" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			<span>是否是担保：</span>
				<form:radiobuttons class="i-checks" path="isDbr" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
		 </div>	
	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<shiro:hasPermission name="kerz:rcGdxx:add">
				<table:addRow url="${ctx}/kerz/rcGdxx/form" title="股东信息"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="kerz:rcGdxx:edit">
			    <table:editRow url="${ctx}/kerz/rcGdxx/form" title="股东信息" id="contentTable"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="kerz:rcGdxx:del">
				<table:delRow url="${ctx}/kerz/rcGdxx/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="kerz:rcGdxx:import">
				<table:importExcel url="${ctx}/kerz/rcGdxx/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="kerz:rcGdxx:export">
	       		<table:exportExcel url="${ctx}/kerz/rcGdxx/export"></table:exportExcel><!-- 导出按钮 -->
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
				<th  class="sort-column khzlId">客户名称</th>
				<th  class="sort-column khlx">类型：</th>
				<th  class="sort-column gdxm">姓名</th>
				<th  class="sort-column sfzh">身份证号</th>
				<th  class="sort-column xb">性别</th>
				<th  class="sort-column nl">年龄</th>
				<th  class="sort-column zgb">占股比</th>
				<th  class="sort-column isMarry">是否已婚</th>
				<th  class="sort-column isDbr">是否是担保</th>
				<th>操作</th>
				<th>家属信息</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="rcGdxx">
			<tr>
				<td> <input type="checkbox" id="${rcGdxx.id}" class="i-checks"></td>
				<td><a  href="#" onclick="openDialogView('查看股东信息', '${ctx}/kerz/rcGdxx/form?id=${rcGdxx.id}','800px', '500px')">
					${rcGdxx.rcKhzl.khmc}
				</a></td>
				<td>
					${fns:getDictLabel(rcGdxx.khlx, 'rcgd_type', '')}
				</td>
				<td>
					${rcGdxx.gdxm}
				</td>
				<td>
					${rcGdxx.sfzh}
				</td>
				<td>
					${fns:getDictLabel(rcGdxx.xb, 'sex', '')}
				</td>
				<td>
					${rcGdxx.nl}
				</td>
				<td>
					${rcGdxx.zgb}
				</td>
				<td>
					${fns:getDictLabel(rcGdxx.isMarry, 'yes_no', '')}
				</td>
				<td>
					${fns:getDictLabel(rcGdxx.isDbr, 'yes_no', '')}
				</td>
				<td>
					<shiro:hasPermission name="kerz:rcGdxx:view">
						<a href="#" onclick="openDialogView('查看股东信息', '${ctx}/kerz/rcGdxx/form?id=${rcGdxx.id}','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="kerz:rcGdxx:edit">
    					<a href="#" onclick="openDialog('修改股东信息', '${ctx}/kerz/rcGdxx/form?id=${rcGdxx.id}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="kerz:rcGdxx:del">
						<a href="${ctx}/kerz/rcGdxx/delete?id=${rcGdxx.id}" onclick="return confirmx('确认要删除该股东信息吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
					</shiro:hasPermission>
				</td>
				<td>
					<%--<shiro:hasPermission name="kerz:rcGdxx:view">--%>
						<%--<a href="${ctx}/kerz/rcGdjs?id=${rcGdxx.id}"  class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>--%>
					<%--</shiro:hasPermission>--%>
					<shiro:hasPermission name="kerz:rcGdxx:edit">
						<a href="#" onclick="openDialogView('股东家属信息管理', '${ctx}/kerz/rcGdjs?rcGdxx.id=${rcGdxx.id}','1200px', '600px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 家属管理</a>
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