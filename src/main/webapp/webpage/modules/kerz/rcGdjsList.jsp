<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>

<html>
<head>
	<title>股东家属管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {

		});
		function toGdxx () {
			location.href = "${ctx}/kerz/rcGdxx/";
		}
		//var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		function openDialog1(title,url,width,height,target){

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
				btn: ['确定', '关闭'],
				yes: function(index, layero){
					var body = top.layer.getChildFrame('body', index);
					var iframeWin = layero.find('iframe')[0]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
					console.info(iframeWin);
					var inputForm = body.find('#inputForm');
					var top_iframe;
					if(target){
						top_iframe = target;//如果指定了iframe，则在改frame中跳转
					}else{
						top_iframe = top.getActiveTab().attr("name");//获取当前active的tab的iframe
					}
					//inputForm.attr("target",top_iframe);//表单提交成功后，从服务器返回的url在当前tab中展示
					if(iframeWin.contentWindow.doSubmit() ){
						setTimeout(function(){
							top.layer.close(index);
							window.location.reload();

					},100);

					}
				},
				cancel: function(index){

				}
			});

		}
		function add1(){
			openDialog1("新增","${ctx}/kerz/rcGdjs/form","${width == null ? '800px' : width }", "${height == null ? '500px': height }");
		}
		function edit1(){

			var size = $("input.i-checks:checked").size();
			if(size == 0 ){
				top.layer.alert('请至少选择一条数据!', {icon: 0, title:'警告'});
				return;
			}

			if(size > 1 ){
				top.layer.alert('只能选择一条数据!', {icon: 0, title:'警告'});
				return;
			}
			var id =  $("input.i-checks:checkbox:checked").attr("id");
			openDialog1("修改","${ctx}/kerz/rcGdjs/form?id="+id,"${ width == null ? '800px' : width}", "${ height == null? '500px' : height}");
		}
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>股东家属列表 </h5>
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
    
    <div class="ibox-content" >
	<sys:message content="${message}"/>
	
	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="searchForm" modelAttribute="rcGdjs" action="${ctx}/kerz/rcGdjs/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="rcGdxx.id" name="rcGdxx.id" type="hidden" value="${rcGdjs.rcGdxx.id}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<%--<div class="form-group">--%>
			<%--<span>股东：</span>--%>
			<%--<form:input path="rcGdxx.gdxm" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>--%>
			<%--<span>姓名：</span>--%>
				<%--<form:input path="jsxm" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>--%>
		 <%--</div>--%>
	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<shiro:hasPermission name="kerz:rcGdjs:add">
				<button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" onclick="add1()" title="添加"><i class="fa fa-plus"></i> ${label == null ? '添加' : label}</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="kerz:rcGdjs:edit">
				<button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" onclick="edit1()" title="修改"><i class="fa fa-file-text-o"></i> ${label == null ? '修改' : label}</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="kerz:rcGdjs:del">
				<table:delRow url="${ctx}/kerz/rcGdjs/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<%--	<shiro:hasPermission name="kerz:rcGdjs:import">
					<table:importExcel url="${ctx}/kerz/rcGdjs/import"></table:importExcel><!-- 导入按钮 -->
				</shiro:hasPermission>
				<shiro:hasPermission name="kerz:rcGdjs:export">
					   <table:exportExcel url="${ctx}/kerz/rcGdjs/export"></table:exportExcel><!-- 导出按钮 -->
				   </shiro:hasPermission>
				  <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
					   <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="toGdxx()" title="返回股东列表"><i class="glyphicon glyphicon-repeat"></i> 返回股东列表</button>
			   --%>
			</div>
		<%--<div class="pull-right">
			<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="search()" ><i class="fa fa-search"></i> 查询</button>
			<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>
		</div>--%>
	</div>
	</div>
	<div style="overflow:scroll;">
	<!-- 表格 -->
	<table id="contentTable" style="min-width:1500px;" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
		<thead>
			<tr>
				<th> <input type="checkbox" class="i-checks"></th>
				<th  class="sort-column rcGdxx.gdxm">股东</th>
				<th  class="sort-column jsgx">关系</th>
				<th  class="sort-column jsxm">姓名</th>
				<th  class="sort-column sfzh">身份证号</th>
				<th  class="sort-column xb">性别</th>
				<th  class="sort-column nl">年龄</th>
				<th  class="sort-column job">职业</th>
				<th  class="sort-column telephone">电话</th>
				<th  class="sort-column isMarry">是否已婚</th>
				<th  class="sort-column isDbr">是否担保</th>
				<th  class="sort-column peiouxm">配偶姓名</th>
				<th  class="sort-column peiousfzh">配偶身份证号</th>
				<th  class="sort-column peiouxb">配偶性别</th>
				<th  class="sort-column peiounl">配偶年龄</th>
				<th  class="sort-column peiouxl">学历</th>
				<th  class="sort-column peioujob">职业</th>
				<th  class="sort-column peioudh">电话</th>
				<th  class="sort-column peiouisdbr">是否担保</th>
				<th  class="sort-column remarks">备注</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="rcGdjs">
			<tr>
				<td> <input type="checkbox" id="${rcGdjs.id}" class="i-checks"></td>
				<td> ${rcGdjs.rcGdxx.gdxm}</td>
				<td><a  href="#" onclick="openDialogView('查看股东家属', '${ctx}/kerz/rcGdjs/form?id=${rcGdjs.id}','800px', '500px')">
					${fns:getDictLabel(rcGdjs.jsgx, 'jtcy_type', '')}
				</a></td>
				<td>
					${rcGdjs.jsxm}
				</td>
				<td>
					${rcGdjs.sfzh}
				</td>
				<td>
					${fns:getDictLabel(rcGdjs.xb, 'sex', '')}

				</td>
				<td>
						${rcGdjs.nl}
				</td>
				<td>
						${rcGdjs.job}
				</td>
				<td>
						${rcGdjs.telephone}

				</td>
				<td>
								${fns:getDictLabel(rcGdjs.isMarry, 'yes_no', '')}
				</td>
				<td>
								${fns:getDictLabel(rcGdjs.isDbr, 'yes_no', '')}
				</td>
				<td>
						${rcGdjs.peiouxm}
				</td>
				<td>
						${rcGdjs.peiousfzh}
				</td>
				<td>
						${fns:getDictLabel(rcGdjs.peiouxb, 'sex', '')}
				</td>
				<td>
					${rcGdjs.peiounl}
			</td>
				<td>
						${rcGdjs.peiouxl}
				</td>
				<td>
						${rcGdjs.peioujob}
				</td>
				<td>
						${rcGdjs.peioudh}
				</td>
				<td>
						${fns:getDictLabel(rcGdjs.peiouisdbr, 'yes_no', '')}
				</td>
				<td>
						${rcGdjs.remarks}
				</td>
				<td>
					<shiro:hasPermission name="kerz:rcGdjs:view">
						<a href="#" onclick="openDialogView('查看股东家属', '${ctx}/kerz/rcGdjs/form?id=${rcGdjs.id}','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="kerz:rcGdjs:edit">
    					<a href="#" onclick="openDialog1('修改股东家属', '${ctx}/kerz/rcGdjs/form?id=${rcGdjs.id}','800px', '500px','${ctx}/kerz/rcGdjs?rcGdxx.id=${rcGdxx.id}')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="kerz:rcGdjs:del">
						<a href="${ctx}/kerz/rcGdjs/delete?id=${rcGdjs.id}" onclick="return confirmx('确认要删除该股东家属吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
					</shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	
		<!-- 分页代码 -->
	<table:page page="${page}"></table:page>
	</div>
	<br/>
	<br/>
	</div>
	</div>
</div>
</body>
</html>