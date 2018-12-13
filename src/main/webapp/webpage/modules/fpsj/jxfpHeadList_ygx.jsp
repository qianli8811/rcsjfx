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
				elem: '#beginRzssy', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
				format: 'YYYYMM',
				event: 'focus' //响应事件。如果没有传入event，则按照默认的click
			});
			laydate({
				elem: '#endRzssy', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
				format: 'YYYYMM',
				event: 'focus' //响应事件。如果没有传入event，则按照默认的click
			});
			var beginKprq = $('#beginRzssy').val();
			var endKprq = $('#endRzssy').val();
			if(!beginKprq){
				$('#beginRzssy').val(laydate.now(0,'YYYYMM'));
			}
			if(!endKprq){
				$('#endRzssy').val(laydate.now(0, 'YYYYMM'));
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
<body class="gray-bg">
<div class="wrapper wrapper-content">
	<div class="ibox">
		<div class="ibox-title">
			<h5>已认证明细列表 </h5>
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
					<form:form id="searchForm" modelAttribute="jxfpHead" action="${ctx}/fpsj/jxfpHead/listygx" method="post" class="form-inline">
						<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
						<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
						<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
						<div class="form-group">

							<span>认证日期：</span>
							<input id="beginRzssy" style="width:120px;"  name="beginRzssy" type="text" maxlength="20" class="form-control layer-date input-sm"
							       value="<fmt:formatDate value="${jxfpHead.beginRzssy}" pattern="yyyyMM"/>"/>
							》》》
							<input id="endRzssy" style="width:120px;"  name="endRzssy" type="text" maxlength="20" class="form-control layer-date input-sm"
							       value="<fmt:formatDate value="${jxfpHead.endRzssy}" pattern="yyyyMM"/>"/>

							<span style="margin-left:80px">销方名称：</span>
							<form:input path="xsfmc" htmlEscape="false" style="width:283px" maxlength="255"  class=" form-control input-sm"/>

							</br></br>

							<span >发票号码：</span>
							<form:input path="fphm" htmlEscape="false" maxlength="255" style="width:120px;"  class=" form-control input-sm"/>
							》》》

							<form:input path="fpdm" htmlEscape="false" maxlength="255" style="width:120px;"  class=" form-control input-sm"/>



							<span style="margin-left:80px">购方名称：</span>
							<%--<form:input path="gmfmc" htmlEscape="false" style="width:283px" maxlength="255"  class=" form-control input-sm"/>
--%>
							<input  id="gmfmcId" type="hidden" value="${jxfpHead.gmfmc}"/>



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
						<div style="display: none">
							<table:delRow url="${ctx}/fpsj/jxfpHead/deleteAll" id="contentTable"></table:delRow>
						</div>
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
			<div style="overflow:scroll;" >
				<!-- 表格 -->
				<table id="contentTable" style="overflow-x:scroll;" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
					<thead>
					<tr>
						<th> <input type="checkbox" class="i-checks"></th>
						<th  class="sort-column rzssy">认证日期</th>
						<th  class="sort-column kprq">开票日期</th>

						<th  class="sort-column fphm">发票号码</th>
						<th  class="sort-column fpdm">发票代码</th>
						<th  class="sort-column kprq">开票日期</th>
						<th title="销方名称" class="sort-column xsfmc">销方名称</th>
						<th title="销方名称" class="sort-column xsfmc">购方名称</th>

						<th title="合计不含税金额"  class="sort-column hjbhsje">发票金额</th>
						<th title="合计含税金额"  class="sort-column hjhsje">含税金额</th>

						<th  title="作废标记" class="sort-column fpzf">作废标记</th>

					</tr>
					</thead>
					<tbody>
					<c:forEach items="${page.list}" var="jxfpHead">
						<tr>
							<td> <input type="checkbox" id="${jxfpHead.id}" class="i-checks"></td>

							<td>
									${jxfpHead.rzssy}
							</td>
							<td>

										<fmt:formatDate value="${jxfpHead.kprq}" pattern="yyyy-MM-dd"/>
							</td>
							<td>
								<a  href="#" onclick="openDialogView('查看发票数据', '${ctx}/fpsj/jxfpHead/formjx?id=${jxfpHead.id}&pageNo=1&pageSize=10','800px', '500px')">

												${jxfpHead.fphm}
								</a>
							</td>
							<td >
								<%--<c:if test="${fn:length(jxfpHead.fphm)=='18'}">
									${fn:substring(jxfpHead.fphm,10,18)}
								</c:if>
								<c:if test="${fn:length(jxfpHead.fphm)<'18'}">
									${jxfpHead.fpdm}
								</c:if>--%>
									${jxfpHead.fpdm}
							</td>
							<td>
								<fmt:formatDate value="${jxfpHead.kprq}" pattern="yyyy-MM-dd"/>
							</td>


							<td >
									${jxfpHead.xsfmc}
							</td>

							<td>
									${jxfpHead.gmfmc}
							</td>


							<td>
									${jxfpHead.hjbhsje}
							</td>
							<td>
									${jxfpHead.hjhsje}
							</td>
							<%--<td>
									${jxfpHead.hjse}
							</td>--%>

							<td>
									${jxfpHead.fpzf == '1' ? "作废":"正常"}

							</td>

						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
			<!-- 分页代码 -->
			<table:page page="${page}"></table:page>
			<br/>
			<br/>
		</div>
	</div>
</div>
</body>
</html>