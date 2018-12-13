<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>股东列表</title>
	<meta name="decorator" content="default"/>
	<%@include file="/webpage/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
			var data = ${fns:toJson(page.list)}, ids = [], rootIds = [];
			for (var i=0; i<data.length; i++){
				ids.push(data[i].id);
			}
			ids = ',' + ids.join(',') + ',';
			for (var i=0; i<data.length; i++){
				if (ids.indexOf(','+data[i].parentId+',') == -1){
					if ((','+rootIds.join(',')+',').indexOf(','+data[i].parentId+',') == -1){
						rootIds.push(data[i].parentId);
					}
				}
			}
			for (var i=0; i<rootIds.length; i++){
				addRow("#treeTableList", tpl, data, rootIds[i], true);
			}
			$("#treeTable").treeTable({expandLevel : 5});



			$("a[id^='editQs1span_']").each(function(){


				var arr1 = $(this).attr('id').split("_");
				var gdPid = arr1[1].split("@")[0];
				if(gdPid==0){
					$(this).show();
				}else{
					$(this).hide();
				}

			});



		});
		function addRow(list, tpl, data, pid, root){
			for (var i=0; i<data.length; i++){
				var row = data[i];
				if ((${fns:jsGetVal('row.parentId')}) == pid){
					$(list).append(Mustache.render(tpl, {
						dict: {
						blank123:0}, pid: (root?0:pid), row: row
					}));
					addRow(list, tpl, data, row.id);
				}
			}
		}
		
		function refresh(){//刷新
			
			window.location="${ctx}/kerz/rcGd/";
		}
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
				<a class="dropdown-toggle" data-toggle="dropdown" href="form_basic.html#">
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
	<form:form id="searchForm" modelAttribute="rcGd" action="${ctx}/kerz/rcGd/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<div class="form-group">
			<span>客户简码：</span>
			<form:input path="rcKhzl.khjm" htmlEscape="false" maxlength="255"  class=" form-control input-sm"/>

			<span>客户名称：</span>
			<form:input path="rcKhzl.khmc" htmlEscape="false" maxlength="255"  class=" form-control input-sm"/>

			<span>姓名：</span>
			<form:input path="gdxm" htmlEscape="false" maxlength="255"  class=" form-control input-sm"/>

		</div>
	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<table:addRow url="${ctx}/kerz/rcGd/form?rcKhzl.id=${rcGd.rcKhzl.id}" title="股东管理"></table:addRow>

			<%--<shiro:hasPermission name="kerz:rcGd:add">
				<table:addRow url="${ctx}/kerz/rcGd/form" title="客户管理"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>--%>
	       <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="refresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
		</div>
		<div class="pull-right">
			<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="search()" ><i class="fa fa-search"></i> 查询</button>
			<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>
		</div>
	</div>
	</div>
	
	<table id="treeTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
		<thead>
			<tr>
				<th>客户编码</th>
				<th>客户名称</th>
				<th>类型</th>
				<th>占股比</th>
				<th>姓名</th>
				<th>身份证号</th>
				<th>性别</th>
				<th>年龄</th>
				<th>是否是担保人</th>
				<th>家属信息</th>
				<th>操作</th>

			</tr>
		</thead>
		<tbody id="treeTableList"></tbody>
	</table>
	<script type="text/template" id="treeTableTpl">
		<tr id="{{row.id}}" pId="{{pid}}">
			<td>{{row.rcKhzl.khjm}}</td>
			<td>{{row.rcKhzl.khmc}}</td>
			<td>{{row.khlxName}}</td>
			<td>{{row.zgb}}</td>
			<td>{{row.gdxm}}</td>
			<td>{{row.sfzh}}</td>
			<td>{{row.xbName}}</td>
			<td>{{row.nl}}</td>
			<td>{{row.isDbrName}}</td>
			<td>{{row.jtcyName}}</td>
			<td>
				<a href="#" onclick="openDialogView('查看家属信息', '${ctx}/kerz/rcGd/form?id={{row.id}}','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i>  查看</a>
				<a href="#" id="editQs" onclick="openDialog('修改家属信息', '${ctx}/kerz/rcGd/form?id={{row.id}}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
				<a href="${ctx}/kerz/rcGd/delete?id={{row.id}}" onclick="return confirmx('确认要删除该股东及所有亲属信息吗？', this.href)" class="btn btn-danger btn-xs" ><i class="fa fa-trash"></i> 删除</a>

				<a href="#" id="editQs1span_{{pid}}@" onclick="openDialog('添加家属信息', '${ctx}/kerz/rcGd/form?parent.id={{row.id}}&rcKhzl.id={{row.rcKhzl.id}}','800px', '500px')" class="btn btn-primary btn-xs" ><i class="fa fa-plus"></i> 添加亲属信息</a>

				<%--<shiro:hasPermission name="kerz:rcGd:view">
				<a href="#" onclick="openDialogView('查看客户管理', '${ctx}/kerz/rcGd/form?id={{row.id}}','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i>  查看</a>
				</shiro:hasPermission>
			<shiro:hasPermission name="kerz:rcGd:edit">
   				<a href="#" onclick="openDialog('修改客户管理', '${ctx}/kerz/rcGd/form?id={{row.id}}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
   			</shiro:hasPermission>
   			<shiro:hasPermission name="kerz:rcGd:del">
				<a href="${ctx}/kerz/rcGd/delete?id={{row.id}}" onclick="return confirmx('确认要删除该客户管理及所有子客户管理吗？', this.href)" class="btn btn-danger btn-xs" ><i class="fa fa-trash"></i> 删除</a>
			</shiro:hasPermission>
   			<shiro:hasPermission name="kerz:rcGd:add">
				<a href="#" onclick="openDialog('添加下级客户管理', '${ctx}/kerz/rcGd/form?parent.id={{row.id}}','800px', '500px')" class="btn btn-primary btn-xs" ><i class="fa fa-plus"></i> 添加下级客户管理</a>
			</shiro:hasPermission>--%>
			</td>
		</tr>
	</script>
		<table:page page="${page}"></table:page>
		<br/>
		<br/>
</body>
</html>