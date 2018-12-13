<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>发票数据管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		var validateForm;
		function doSubmit(){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
		  if(validateForm.form()){
			  $("#inputForm").submit();
			  return true;
		  }
	
		  return false;
		}
		$(document).ready(function() {
			validateForm = $("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
			
		});
	</script>
</head>
<body class="hideScroll">
		<form:form id="inputForm" modelAttribute="jxfpHead" action="${ctx}/fpsj/jxfpHead/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
		   <tr>
			   <td class="width-15 active"><label class="pull-right"><font color="red">*</font>开票日期：</label></td>
			   <td class="width-35">
				   <input id="kprq" name="kprq" type="text" maxlength="20" class="form-control required"
				          value="<fmt:formatDate value="${jxfpHead.kprq}" pattern="yyyy-MM-dd"/>"/>
			   </td>
			   <td class="width-15 active"><label class="pull-right"><font color="red">*</font>发票代码：</label></td>
			   <td class="width-35">
				   <form:input path="fpdm" htmlEscape="false"    class="form-control required"/>
			   </td>

		   </tr>
		   <tr>

			   <td class="width-15 active"><label class="pull-right"><font color="red">*</font>发票号码：</label></td>
			   <td class="width-35">
				   <form:input path="fphm" htmlEscape="false"    class="form-control required"/>
			   </td>
			   <td class="width-15 active"><label class="pull-right"><font color="red">*</font>开票类型：</label></td>
			   <td class="width-35">

				   <%--<input name="kplx" value="${jxfpHead.kplx == 0?'普票':'专票'}" htmlEscape="false"    class="form-control required"/>--%>
			   </td>
		   </tr>

		   <tr>
			   <td class="width-15 active"><label class="pull-right"><font color="red">*</font>购买方名称：</label></td>
			   <td class="width-35">
				   <form:input path="gmfmc" htmlEscape="false"    class="form-control required"/>
			   </td>
			   <td class="width-15 active"><label class="pull-right"><font color="red">*</font>购买方税号：</label></td>
			   <td class="width-35" >
				   <form:input path="gmfsh" htmlEscape="false"    class="form-control required"/>

			   </td>
		   </tr>
		   <tr>
			   <td class="width-15 active"><label class="pull-right"><font color="red">*</font>购买方银行账号：</label></td>
			   <td class="width-35">
				   <form:input path="gmfyhzh" htmlEscape="false"    class="form-control required"/>
			   </td>
			   <td class="width-15 active"><label class="pull-right"><font color="red">*</font>购买方地址：</label></td>
			   <td class="width-35">
				   <form:input path="gmfdz" htmlEscape="false"    class="form-control required"/>
			   </td>

		   </tr>
		   <tr>
			   <td class="width-15 active"><label class="pull-right"><font color="red">*</font>销方税号：</label></td>
			   <td class="width-35" >
				   <form:input path="xsfsh" htmlEscape="false"    class="form-control required"/>
			   </td>
			   <td class="width-15 active"><label class="pull-right"><font color="red">*</font>销方名称：</label></td>
			   <td class="width-35">
				   <form:input path="xsfmc" htmlEscape="false"    class="form-control required"/>
			   </td>

		   </tr>
		   <tr>
			   <td class="width-15 active"><label class="pull-right"><font color="red">*</font>销方银行账号：</label></td>
			   <td class="width-35">

				   <form:input path="xsyhzh" htmlEscape="false"    class="form-control required"/>
			   </td>
			   <td class="width-15 active"><label class="pull-right"><font color="red">*</font>销方地址：</label></td>
			   <td class="width-35" >
				   <form:input path="xsfdz" htmlEscape="false"    class="form-control required"/>
			   </td>

		   </tr>
		   <tr>

			   <td class="width-15 active"><label class="pull-right"><font color="red">*</font>合计不含税金额：</label></td>
			   <td class="width-35">
				   <form:input path="hjbhsje" htmlEscape="false"    class="form-control required"/>
			   </td>
			   <td class="width-15 active"><label class="pull-right"><font color="red">*</font>合计含税金额：</label></td>
			   <td class="width-35">
				   <form:input path="hjhsje" htmlEscape="false"    class="form-control required"/>
			   </td>
		   </tr>
		   <tr>
			   <td class="width-15 active"><label class="pull-right"><font color="red">*</font>合计税额：</label></td>
			   <td class="width-35" >
				   <form:input path="hjse" htmlEscape="false"    class="form-control required"/>
			   </td>
			   <td class="width-15 active"><label class="pull-right"><font color="red">*</font>备注：</label></td>
			   <td class="width-35" >
				   <form:textarea path="bz" htmlEscape="false" rows="4"    class="form-control "/>
			   </td>
		   </tr>

		 	</tbody>
		</table>
	</form:form>


		<div class="tabs-container">
			<ul class="nav nav-tabs">
				<li class="active"><a data-toggle="tab" href="#tab-1" aria-expanded="true"> 进项物品明细列表</a>
				</li>
			</ul>
			<div class="tab-content">
				<div id="tab-1" class="tab-pane active">
					<div class="panel-body">
						<table id="contentTable1" class="table table-striped table-bordered table-hover  dataTables-example dataTable">
							<thead>
							<tr>
								<th >行项目号</th>
								<th>货物名称</th>
								<th >规格型号</th>
								<th >不含税金额</th>
								<th >不含税单价</th>
								<th >含税单价</th>
								<th >含税金额</th>
								<th >税额</th>
								<th >数量</th>
								<th >单位</th>
								<th >税率</th>
							</tr>
							</thead>
							<tbody>

							<c:forEach items="${jxfpItemList}" var="jxfpItem"  varStatus="idx">
								<tr>
									<td>
											${jxfpItem.hxmh}
									</td>
									<td>
											${jxfpItem.hwmc}
									</td>
									<td>
											${jxfpItem.ggxh}
									</td>
									<td>
											${jxfpItem.bhsje}
									</td>
									<td>
											${jxfpItem.bhsdj}
									</td>
									<td>
											${jxfpItem.hsdj}
									</td>
									<td>
											${jxfpItem.hsje}
									</td>
									<td>
											${jxfpItem.se}
									</td>
									<td>
											${jxfpItem.xmsl}
									</td>
									<td>
											${jxfpItem.dw}
									</td>
									<td>
											${jxfpItem.sl}
									</td>
								</tr>
							</c:forEach>



							</tbody>
						</table>
					</div>
				</div>

			</div>

		</div>


</body>
</html>