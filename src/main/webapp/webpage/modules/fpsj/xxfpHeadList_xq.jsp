<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>发票数据管理</title>
	<meta name="decorator" content="default"/>

	<link href="${ctxStatic}/bootstrap/select/bootstrap-multiselect.css" rel="stylesheet"/>
	<script src="${ctxStatic}/bootstrap/select/bootstrap-multiselect.js"></script>
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
			var beginKprq = $('#beginKprq').val();
			var endKprq = $('#endKprq').val();
			if(!beginKprq){
				$('#beginKprq').val(laydate.now(0,'YYYY-MM-01'));
			}
			if(!endKprq){
				$('#endKprq').val(laydate.now(0, 'YYYY-MM-DD'));
			}

			var qymcId = $('#qymcId').val();
			if(qymcId !='' && qymcId !=null && qymcId != undefined){
				var qymcArr = qymcId.split(",");
				var html = '';
				for(var qymc in qymcArr){
					html += '<option selected="selected" value="'+qymcArr[qymc]+'">'+ qymcArr[qymc]+'</option>';
				}
				$("#qymc").html('');
				$("#qymc").html(html);
				$('#qymc').multiselect({
					buttonWidth: '283px',
					maxHeight:'400px',
					includeSelectAllOption: true
				});

			}else{
				$.ajax({
					type: "POST",
					url: "${ctx}/fpsj/xxfpHead/getXxGsName?time="+ new Date().getTime(),
					dataType: "json",
					success: function(data){
						var html = '';
						$("#qymc").html('');
						if(data){
							for(var cName in data){
								html += '<option value="'+data[cName]+'">'+ data[cName]+'</option>';
							}
						}else{
							html += '<option value="">暂无数据</option>';
						}

						$("#qymc").html(html);

						$('#qymc').multiselect({
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
			<h5>销项发票数据列表 </h5>
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
					<form:form id="searchForm" modelAttribute="xxfpHead" action="${ctx}/fpsj/xxfpHead/listxq" method="post" class="form-inline">
						<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
						<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
						<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
						<div class="form-group">

							<span>开始日期：</span>
							<input id="beginKprq" style="width:120px;" name="beginKprq" type="text"  maxlength="20" class="form-control layer-date input-sm"
							       value="<fmt:formatDate value="${xxfpHead.beginKprq}" pattern="yyyy-MM-dd"/>"/>
							》》》

							<input id="endKprq" style="width:120px;" name="endKprq" type="text" maxlength="20" class=" form-control layer-date input-sm"
							       value="<fmt:formatDate value="${xxfpHead.endKprq}" pattern="yyyy-MM-dd"/>"/>

							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<span>销方名称：</span>
							<%--<form:input path="khmc" htmlEscape="false"  maxlength="255" style="width:283px" class=" form-control input-sm"/>
--%>
							<%--<script type="text/javascript">
								$(function(){
									$('#khmc').multipleSelect();
								});

							</script>--%>
							<form:select path="qymc" id="qymc" style="width:283px" multiple="multiple" class="form-control">
							</form:select>
							<input  id="qymcId" type="hidden" name="qymcId" value="${xxfpHead.qymc}"/>



							</br></br>

							<span>发票号码：</span>
							<form:input path="fphm" htmlEscape="false" maxlength="255" style="width:283px" class=" form-control input-sm"/>

							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

							<span>作废标志：</span>

							<form:select path="zfbz"  class="form-control m-b" style="width:283px" >
								<form:option value="" label=""/>
								<form:options items="${fns:getDictList('fpzf_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
							</form:select>
							</br></br>


							<span>发票类型：</span>
							<form:select path="kplx"  class="form-control m-b" style="width:283px">
								<form:option value="" label=""/>
								<form:options items="${fns:getDictList('fpzf_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
							</form:select>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</form:form>
					<br/>
				</div>
			</div>

			<!-- 工具栏 -->
			<div class="row">
				<div class="col-sm-12">
					<div class="pull-left">
						<div style="display: none"><table:delRow url="${ctx}/fpsj/xxfpHead/deleteAll" id="contentTable"></table:delRow></div>
						<%--<shiro:hasPermission name="fpsj:xxfpHead:add">
							<table:addRow url="${ctx}/fpsj/xxfpHead/form" title="发票数据"></table:addRow><!-- 增加按钮 -->
						</shiro:hasPermission>
						<shiro:hasPermission name="fpsj:xxfpHead:edit">
							<table:editRow url="${ctx}/fpsj/xxfpHead/form" title="发票数据" id="contentTable"></table:editRow><!-- 编辑按钮 -->
						</shiro:hasPermission>
						<shiro:hasPermission name="fpsj:xxfpHead:del">
							<table:delRow url="${ctx}/fpsj/xxfpHead/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
						</shiro:hasPermission>
						<shiro:hasPermission name="fpsj:xxfpHead:import">
							<table:importExcel url="${ctx}/fpsj/xxfpHead/import"></table:importExcel><!-- 导入按钮 -->
						</shiro:hasPermission>--%>
						<shiro:hasPermission name="fpsj:xxfpHead:export">
							<table:exportExcel url="${ctx}/fpsj/xxfpHead/export"></table:exportExcel><!-- 导出按钮 -->
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
					<th  class="sort-column kprq">开票日期</th>

					<th  class="sort-column fphm">发票号码</th>
					<th  class="sort-column fphm">发票代码</th>
					<th  class="sort-column qymc">销方名称</th>
					<th  class="sort-column qykhyhzh">开票方银行账号</th>

					<th  class="sort-column kpr">开票人</th>
					<th  class="sort-column zfbz">作废标志</th>
					<th  class="sort-column kplx">开票类型 </th>
					<th  class="sort-column zbhsje">合计不含税金额</th>
					<th  class="sort-column zse">合计税额</th>
					<%--<th  class="sort-column jshs">合计价税合计</th>--%>
					<th>物品明细</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach items="${page.list}" var="xxfpHead">
					<tr>
						<td> <input type="checkbox" id="${xxfpHead.id}" class="i-checks"></td>
						<td>
							<fmt:formatDate value="${xxfpHead.kprq}" pattern="yyyy-MM-dd"/>
						</td>
						<%--<td><a  href="#" onclick="openDialogView('查看发票数据', '${ctx}/fpsj/xxfpHead/form?id=${xxfpHead.id}','1200px', '700px')">
								${xxfpHead.fphm}
						</a>--%>
						<td>

								${fn:substring(xxfpHead.fphm, 0, 10)}

						</td>
						<td>


									<a href="#" onclick="openDialogView('查看发票数据', '${ctx}/fpsj/xxfpHead/formxx?id=${xxfpHead.id}','800px', '500px')" >${fn:substring(xxfpHead.fphm, 10, 18)}</a>
						</td>
						</td>


						<td>
								${xxfpHead.qymc}
						</td>
						<td>
								${xxfpHead.qykhyhzh}
						</td>

						<td>
								${xxfpHead.kpr}
						</td>

						<td>
								${xxfpHead.zfbz == '1' ? "作废":"正常"}

						</td>
						<td>
									<c:choose>
										<c:when test="${xxfpHead.kplx == 0 }">
											专用
										</c:when>
										<c:when test="${xxfpHead.kplx == 1 }">
											普通
										</c:when>
										<c:otherwise>
											其它
										</c:otherwise>
									</c:choose>
						</td>
						<td>
								${xxfpHead.zbhsje}
						</td>
						<td>
								${xxfpHead.zse}
						</td>

						<td>
						<a href="#" onclick="openDialogView('查看发票数据', '${ctx}/fpsj/xxfpHead/formxx?id=${xxfpHead.id}','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i>发票详情</a>
						</td>
							<%--<td>
								${xxfpHead.jshs}
							</td>--%>
							<%--<td>
								<shiro:hasPermission name="fpsj:xxfpHead:view">
									<a href="#" onclick="openDialogView('查看发票数据', '${ctx}/fpsj/xxfpHead/form?id=${xxfpHead.id}','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
								</shiro:hasPermission>
								<shiro:hasPermission name="fpsj:xxfpHead:edit">
									<a href="#" onclick="openDialog('修改发票数据', '${ctx}/fpsj/xxfpHead/form?id=${xxfpHead.id}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
								</shiro:hasPermission>
								<shiro:hasPermission name="fpsj:xxfpHead:del">
									<a href="${ctx}/fpsj/xxfpHead/delete?id=${xxfpHead.id}" onclick="return confirmx('确认要删除该发票数据吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
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