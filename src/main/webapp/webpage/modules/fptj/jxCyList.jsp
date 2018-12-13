<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>进项抽样统计管理</title>
	<meta name="decorator" content="default"/>
	<link href="${ctxStatic}/bootstrap/select/bootstrap-multiselect.css" rel="stylesheet"/>
	<script src="${ctxStatic}/bootstrap/select/bootstrap-multiselect.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {


			var gmfmcId = $('#gmfmcId').val();
			if(gmfmcId !='' && gmfmcId !=null && gmfmcId != undefined){
				var gmfmcArr = gmfmcId.split(",");
				var html = '';
				for(var gmfmc in gmfmcArr){
					html += '<option selected="selected" value="'+gmfmcArr[gmfmc]+'">'+ gmfmcArr[gmfmc]+'</option>';
				}
				$("#gmfmc").html('');
				$("#gmfmc").html(html);
				$('#gmfmc').multiselect({
					buttonWidth: '283px',
					maxHeight:'400px',
					includeSelectAllOption: true
				});

			}else{
				$.ajax({
					type: "POST",
					url: "${ctx}/fpsj/jxfpHead/getJxGsName?time="+ new Date().getTime(),
					dataType: "json",
					success: function(data){
						var html = '';
						$("#gmfmc").html('');
						if(data){
							for(var cName in data){
								html += '<option value="'+data[cName]+'">'+ data[cName]+'</option>';
							}
						}else{
							html += '<option value="">暂无数据</option>';
						}

						$("#gmfmc").html(html);

						$('#gmfmc').multiselect({
							buttonWidth: '283px',
							maxHeight:'400px',
							includeSelectAllOption: true
						});

					}
				});
			}
		});



	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>进项抽样统计列表 </h5>
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
	<form:form id="searchForm" modelAttribute="jxCy" action="${ctx}/fptj/jxCy/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<span >销方名称：</span>
			<input  id="xsfmcId" type="hidden" value="${jxCy.gmfmc}"/>
			<select id ="gmfmc"  name="gmfmc" multiple="multiple"   style="background-color:#FFFFFF;border-radius: 1px;width:283px">


			</select>
		 </div>
	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<div style="display: none"><table:delRow url="${ctx}/fpsj/jxfpHead/deleteAll" id="contentTable"></table:delRow></div>
<%--			<shiro:hasPermission name="fptj:jxCy:add">
				<table:addRow url="${ctx}/fptj/jxCy/form" title="进项抽样统计"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="fptj:jxCy:edit">
			    <table:editRow url="${ctx}/fptj/jxCy/form" title="进项抽样统计" id="contentTable"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="fptj:jxCy:del">
				<table:delRow url="${ctx}/fptj/jxCy/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="fptj:jxCy:import">
				<table:importExcel url="${ctx}/fptj/jxCy/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>--%>
			<shiro:hasPermission name="fptj:jxCy:export">
	       		<table:exportExcel url="${ctx}/fptj/jxCy/export"></table:exportExcel><!-- 导出按钮 -->
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
				<th  class="sort-column xsfh">税号</th>
				<th  class="sort-column xsfmc">名称</th>
				<th  class="sort-column jsplx">金税盘类型</th>
				<th  class="sort-column zhcqrq">最后抽取日期</th>
				<%--<th>操作</th>--%>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="jxCy">
			<tr>
				<td> <input type="checkbox" id="${jxCy.id}" class="i-checks"></td>
				<td><a  href="#" onclick="openDialogView('查看进项抽样统计', '${ctx}/fptj/jxCy/form?id=${jxCy.id}','800px', '500px')">
					${jxCy.xsfh}
				</a></td>
				<td>
					${jxCy.gmfmc}
				</td>
				<td>
							${jxCy.jsplx == '1' ? "专票":"普票"}

				</td>
				<td>
					<fmt:formatDate value="${jxCy.zhcqrq}" pattern="yyyy-MM-dd"/>
				</td>
				<%--<td>
					<shiro:hasPermission name="fptj:jxCy:view">
						<a href="#" onclick="openDialogView('查看进项抽样统计', '${ctx}/fptj/jxCy/form?id=${jxCy.id}','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="fptj:jxCy:edit">
    					<a href="#" onclick="openDialog('修改进项抽样统计', '${ctx}/fptj/jxCy/form?id=${jxCy.id}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="fptj:jxCy:del">
						<a href="${ctx}/fptj/jxCy/delete?id=${jxCy.id}" onclick="return confirmx('确认要删除该进项抽样统计吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
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