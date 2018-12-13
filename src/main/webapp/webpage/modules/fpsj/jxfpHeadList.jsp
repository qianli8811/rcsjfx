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
	            event: 'focus'//响应事件。如果没有传入event，则按照默认的click

	        });
	        laydate({
	            elem: '#endKprq', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
	            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
	        });
			/*laydate({
				elem: '#beginJlrq', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
				event: 'focus' //响应事件。如果没有传入event，则按照默认的click
			});
			laydate({
				elem: '#endJlrq', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
				event: 'focus' //响应事件。如果没有传入event，则按照默认的click
			});*/

			var beginKprq = $('#beginKprq').val();
			var endKprq = $('#beginKprq').val();


			if(!beginKprq){
				$('#beginKprq').val(laydate.now(0,'YYYY-MM-01'));
			}
			if(!endKprq){
				$('#endKprq').val(laydate.now(0, 'YYYY-MM-DD'));
			}


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
<body >
	<div class="wrapper wrapper-content">
		<sys:message content="${message}"/>
	<div class="ibox">
	<div class="ibox-title">
		<h5>发票明细列表 </h5>
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

	
	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="searchForm" modelAttribute="jxfpHead" action="${ctx}/fpsj/jxfpHead/list" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<%--<span>记录日期：</span>
				<input id="beginJlrq" style="width:120px;" name="beginJlrq" type="text" maxlength="20" class=" form-control layer-date input-sm"
				       value="<fmt:formatDate value="${jxfpHead.beginJlrq}" pattern="yyyy-MM-dd"/>"/>
				》》》
				<input id="endJlrq" style="width:120px;" name="endJlrq" type="text" maxlength="20" class=" form-control layer-date input-sm"
				       value="<fmt:formatDate value="${jxfpHead.endJlrq}" pattern="yyyy-MM-dd"/>"/>
--%>
			<span >开票日期：</span>
				<input id="beginKprq" style="width:120px;" name="beginKprq" type="text" maxlength="20" class="form-control layer-date input-sm"
				       value="<fmt:formatDate value="${jxfpHead.beginKprq}" pattern="yyyy-MM-dd"/>"/>
				》》》
				<input id="endKprq" style="width:120px;" name="endKprq" type="text" maxlength="20" class="form-control layer-date input-sm"
				       value="<fmt:formatDate value="${jxfpHead.endKprq}" pattern="yyyy-MM-dd"/>"/>



			<span style="margin-left:50px">发票号码：</span>
			<form:input path="fphm" style="width:120px;" htmlEscape="false" maxlength="255"  class=" form-control"/>
			》》》
			<form:input path="fpdm" style="width:120px;" htmlEscape="false" maxlength="255"  class=" form-control "/>

				<br/><br/>

				<span>销方名称：</span>
				<form:input path="xsfmc" htmlEscape="false" style="width:283px" maxlength="255"  class=" form-control "/>

				<span style="margin-left:50px">购方名称：</span>
					<%--<form:input path="gmfmc" htmlEscape="false" style="width:283px" maxlength="255"  class=" form-control "/>--%>
				<input  id="gmfmcId" type="hidden" name="gmfmcId" value="${jxfpHead.gmfmc}"/>
				<select id ="gmfmc"  name="gmfmc" multiple="multiple" class="form-control"  style="width:283px">

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
			<div style="display: none"><table:delRow url="${ctx}/fpsj/jxfpHead/deleteAll" id="contentTable"> </table:delRow></div>
			<%--<shiro:hasPermission name="fpsj:jxfpHead:add">
				<table:addRow url="${ctx}/fpsj/jxfpHead/form" title="发票数据"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="fpsj:jxfpHead:edit">
			    <table:editRow url="${ctx}/fpsj/jxfpHead/form" title="发票数据" id="contentTable"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="fpsj:jxfpHead:del">
				<table:delRow url="${ctx}/fpsj/jxfpHead/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="fpsj:jxfpHead:import">
				<table:importExcel url="${ctx}/fpsj/jxfpHead/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>--%>
			<shiro:hasPermission name="fpsj:jxfpHead:export">
	       		<table:exportExcel url="${ctx}/fpsj/jxfpHead/export"></table:exportExcel><!-- 导出按钮 -->
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
	<table id="contentTable"  class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
		<thead>
			<tr>
				<th> <input type="checkbox" class="i-checks"></th>

				<th  class="sort-column kprq">开票日期</th>

				<th  class="sort-column fphm">发票号码</th>
				<th  class="sort-column fpdm">发票代码</th>
				<th title="销方名称" class="sort-column xsfmc">销方名称</th>
				<th title="销方税号"  class="sort-column gmfmc">销方税号</th>
				<th title="销方地址" class="sort-column gmfmc">销方地址</th>
				<th title="销方银行账户" class="sort-column gmfmc">销方银行账户</th>
				<%--<th title="购买方名称" class="sort-column xsfmc">购买方名称</th>
				<th title="购买方税号" class="sort-column gmfmc">购买方税号</th>
				<th title="购买方地址"  class="sort-column gmfmc">购买方地址</th>
				<th  title="购买方银行账号" class="sort-column gmfmc">购买方银行账号</th>--%>
				<th title="合计不含税金额"  class="sort-column hjbhsje">合计不含税金额</th>
				<th title="合计含税金额"  class="sort-column hjhsje">合计含税金额</th>
				<th title="合计税额"  class="sort-column hjse">合计税额</th>
				<%--<th title="备注"  class="sort-column hjse">备注</th>--%>
				<th  title="作废标记" class="sort-column fpzf">作废标记</th>
				<%--<th title="物品详情"  class="sort-column fpzf">物品详情</th>--%>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="jxfpHead">
				<td> <input type="checkbox" id="${jxfpHead.id}" class="i-checks"></td>
				<td>
					<fmt:formatDate value="${jxfpHead.kprq}" pattern="yyyy-MM-dd"/>
				</td>

				<td><a  href="#" onclick="openDialogView('查看发票数据', '${ctx}/fpsj/jxfpHead/formjx?id=${jxfpHead.id}&pageNo=1&pageSize=10','800px', '500px')">

							${jxfpHead.fphm}
				</a>
				</td>
				<td >
						${jxfpHead.fpdm}
						<%--<c:if test="${fn:length(jxfpHead.fphm)>'8'}">
							${fn:substring(jxfpHead.fphm,10,18)}
						</c:if>
						<c:if test="${fn:length(jxfpHead.fpdm)<='8'}">
							${jxfpHead.fpdm}
						</c:if>--%>
				</td>
				<td >
					${jxfpHead.xsfmc}
				</td>
				<td>
					${jxfpHead.xsfsh}
				</td>

				<td>
						${jxfpHead.xsfdz}
				</td>
				<td>
						${jxfpHead.xsyhzh}
				</td>


				<%--<td>
						${jxfpHead.gmfmc}
				</td>
				<td>
						${jxfpHead.gmfsh}
				</td>
				<td>
						${jxfpHead.gmfyhzh}
				</td>
				<td>
						${jxfpHead.gmfdz}
				</td>--%>

				<td>
						${jxfpHead.hjbhsje}
				</td>
				<td>
						${jxfpHead.hjhsje}
				</td>
				<td>
						${jxfpHead.hjse}
				</td>
				<%--<td>
						${jxfpHead.bz}
				</td>--%>
				<td>
						${jxfpHead.fpzf == '1' ? "作废":"正常"}

				</td>
				<%--<td>
					<a href="#" onclick="openDialogView('查看发票数据', '${ctx}/fpsj/jxfpHead/form?id=${jxfpHead.id}','1200px', '700px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i>物品详情</a>

				</td>--%>
				<%--<td>

					${jxfpHead.kplx == '1' ? "普票":"专票"}
				</td>--%>



				<%--<td>
					<shiro:hasPermission name="fpsj:jxfpHead:view">
						<a href="#" onclick="openDialogView('查看发票数据', '${ctx}/fpsj/jxfpHead/form?id=${jxfpHead.id}','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="fpsj:jxfpHead:edit">
    					<a href="#" onclick="openDialog('修改发票数据', '${ctx}/fpsj/jxfpHead/form?id=${jxfpHead.id}','800px', '500px')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="fpsj:jxfpHead:del">
						<a href="${ctx}/fpsj/jxfpHead/delete?id=${jxfpHead.id}" onclick="return confirmx('确认要删除该发票数据吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
					</shiro:hasPermission>
				</td>--%>
			</tr>
		</c:forEach>
		</tbody>
	</table>

		<!-- 分页代码 -->
	<table:page page="${page}"></table:page>
</div>

</body>
</html>