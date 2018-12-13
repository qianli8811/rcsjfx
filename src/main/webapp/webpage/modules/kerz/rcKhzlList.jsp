<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>客户管理管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {

		});
		function openDialogJx(title,url,width,height,target){

			if(navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i)){//如果是移动端，就使用自适应大小弹窗
				width='auto';
				height='auto';
			}else{//如果是PC端，根据用户设置的width和height显示。

			}
			top.layer.open({
				type: 2,
				area: [width, height],
				title: title,
				maxmin: true, //开启最大化最小化按钮
				content: url ,
				btn: ['确定', '继续','关闭'],
				yes: function(index, layero){
					var body = top.layer.getChildFrame('body', index);
					var iframeWin = layero.find('iframe')[0]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
					var inputForm = body.find('#inputForm');
					var top_iframe;
					if(target){
						top_iframe = target;//如果指定了iframe，则在改frame中跳转
					}else{
						top_iframe = top.getActiveTab().attr("name");//获取当前active的tab的iframe
					}
					inputForm.attr("target",top_iframe);//表单提交成功后，从服务器返回的url在当前tab中展示

					if(iframeWin.contentWindow.doSubmit() ){
						// top.layer.close(index);//关闭对话框。
						setTimeout(function(){top.layer.close(index)}, 100);//延时0.1秒，对应360 7.1版本bug
					}

				},
				btn2: function(index, layero){
					var body = top.layer.getChildFrame('body', index);
					var iframeWin = layero.find('iframe')[0]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
					var inputForm = body.find('#inputForm');
					var top_iframe;
					if(target){
						top_iframe = target;//如果指定了iframe，则在改frame中跳转
					}else{
						top_iframe = top.getActiveTab().attr("name");//获取当前active的tab的iframe
					}
					inputForm.attr("target",top_iframe);//表单提交成功后，从服务器返回的url在当前tab中展示

					if(iframeWin.contentWindow.doSubmit() ){
						// top.layer.close(index);//关闭对话框。
						openDialogJx(title,url,width,height,target);//延时0.1秒，对应360 7.1版本bug
					}

				},
				cancel: function(index){
				}
			});

		}
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>客户管理列表 </h5>
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
	<form:form id="searchForm" modelAttribute="rcKhzl" action="${ctx}/kerz/rcKhzl/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<span>客户简码：</span>
				<form:input path="khjm" htmlEscape="false" maxlength="255"  class=" form-control input-sm"/>

			<%--<span style="margin-left: 50px">福临门油销售占比(百分比)：</span>--%>
				<%--<form:input path="flmzb" htmlEscape="false" maxlength="255"  class=" form-control input-sm"/>--%>
			<%--<br/><br/>--%>
			<span>客户名称：</span>
			<form:input path="khmc" htmlEscape="false" maxlength="255"  class=" form-control input-sm"/>
			<%--<span>国家：</span>
				<form:input path="guojia" htmlEscape="false" maxlength="255"  class=" form-control input-sm"/>
			<span>省份/州/自治区/直辖市：</span>
				<form:input path="sf" htmlEscape="false" maxlength="255"  class=" form-control input-sm"/>
			<span>城市：</span>
				<form:input path="city" htmlEscape="false" maxlength="255"  class=" form-control input-sm"/>
			<span>详细地址，xxx县(区)xxx镇(乡)xxx村xxx号：</span>
				<form:input path="khdz" htmlEscape="false" maxlength="255"  class=" form-control input-sm"/>--%>
		 </div>	
	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<shiro:hasPermission name="kerz:rcKhzl:add">
				<table:addRow url="${ctx}/kerz/rcKhzl/form" title="客户管理"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="kerz:rcKhzl:edit">
			    <table:editRow url="${ctx}/kerz/rcKhzl/form" title="客户管理" id="contentTable"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="kerz:rcKhzl:del">
				<table:delRow url="${ctx}/kerz/rcKhzl/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="kerz:rcKhzl:import">
				<table:importExcel url="${ctx}/kerz/rcKhzl/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="kerz:rcKhzl:export">
	       		<table:exportExcel url="${ctx}/kerz/rcKhzl/export"></table:exportExcel><!-- 导出按钮 -->
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
				<th  class="sort-column khjm">客户简码</th>
				<th  class="sort-column khmc">客户名称</th>
				<%--<th  class="sort-column guojia">股东信息</th>--%>
				<th  class="sort-column zjzzcs">资金周转次数</th>
				<th  class="sort-column flmzb">福临门油销售占比(百分比)</th>
				<th  class="sort-column guojia">地址</th>

				<%--<th  class="sort-column gd" rowspan="6">股东信息</th>--%>

				<%--<th  class="sort-column sf">省份/州/自治区/直辖市</th>
				<th  class="sort-column city">城市</th>
				<th  class="sort-column khdz">详细地址，xxx县(区)xxx镇(乡)xxx村xxx号</th>--%>
				<th>操作</th>
				<th>融资信息</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="rcKhzl">
			<tr>
				<td> <input type="checkbox" id="${rcKhzl.id}" class="i-checks"></td>
				<td><a  href="#" onclick="openDialogView('查看客户管理', '${ctx}/kerz/rcKhzl/form?id=${rcKhzl.id}','800px', '500px')">
					${rcKhzl.khjm}
				</a></td>
				<td>
					${rcKhzl.khmc}
				</td>
				<%--<td>
						&lt;%&ndash;${rcKhzl.guojia}-${rcKhzl.sf}-${rcKhzl.city}：${rcKhzl.khdz}&ndash;%&gt;
				</td>--%>
				<td>
						${rcKhzl.zjzzcs}
				</td>
				<td>
					${rcKhzl.flmzb}
				</td>
				<td>
					${rcKhzl.guojia}${rcKhzl.sf}${rcKhzl.city}${rcKhzl.khdz}
				</td>
				<%--<td>
					<a href="#" id="gdxxgl" onclick="openDialog('股东信息管理', '${ctx}/kerz/rcGd/?rcKhzl.id=${rcKhzl.id}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 股东信息管理</a>

				</td>--%>


				<%--<td>

				</td>
				<td>

				</td>
				<td>

				</td>--%>
				<td>
					<shiro:hasPermission name="kerz:rcKhzl:view">
						<a href="#" onclick="openDialogView('查看客户管理', '${ctx}/kerz/rcKhzl/form?id=${rcKhzl.id}','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="kerz:rcKhzl:edit">
    					<a href="#" onclick="openDialog('修改客户管理', '${ctx}/kerz/rcKhzl/form?id=${rcKhzl.id}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="kerz:rcKhzl:del">
						<a href="${ctx}/kerz/rcKhzl/delete?id=${rcKhzl.id}" onclick="return confirmx('确认要删除该客户管理吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
					</shiro:hasPermission>


				</td>
			<td>
				<shiro:hasPermission name="kerz:rcKhzl:edit">
					<a href="#" onclick="openDialogJx('添加', '${ctx}/kerz/rcKhzl/keRzzlForm?rckhzl.id=${rcKhzl.id}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 添加</a>
				</shiro:hasPermission>
				<shiro:hasPermission name="kerz:rcKhzl:edit">
					<a href="${ctx}/kerz/keRz/list?rckhzl.id=${rcKhzl.id} " class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 查看</a>
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