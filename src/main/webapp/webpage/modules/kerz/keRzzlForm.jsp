<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>客户融资信息添加</title>
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
			
					laydate({
			            elem: '#rzjssj', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
			            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
			        });
					laydate({
			            elem: '#rzkssj', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
			            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
			        });



		});
	</script>
</head>
<body class="hideScroll">
		<form:form id="inputForm" modelAttribute="keRz" action="${ctx}/kerz/rcKhzl/saveKeRzzl" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
		   <tr>
			   <td class="width-15 active"><label class="pull-right"><font color="red">*</font>客户名称：</label></td>
			   <td class="width-35">
				   <input type="hidden" name = "rckhzl.id" id="rcKhzlId" value="${rckhzl.id}" htmlEscape="false"    class="form-control required"/>
				   <input name = "rckhzl.khmc" id="khjm" value="${keRz.rckhzl.khmc}" htmlEscape="false"    class="form-control required"/>
			   </td>
			   <td class="width-15 active"><label class="pull-right"><font color="red">*</font>融资机构：</label></td>
			   <td class="width-35">
				   <form:input path="rzjg" htmlEscape="false"    class="form-control required"/>
			   </td>

		   </tr>
		   <tr>

			   <td class="width-15 active"><label class="pull-right"><font color="red">*</font>融资类型：</label></td>
			   <td class="width-35">
				   <form:select path="rzlx"  class="form-control m-b">
					   <form:options items="${fns:getDictList('rzlx')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				   </form:select>

			   </td>
			   <td class="width-15 active"><label class="pull-right"><font color="red">*</font>融资金额：</label></td>
			   <td class="width-35">
				   <form:input path="rzje" htmlEscape="false"    class="form-control required"/>
			   </td>

		   </tr>
		   <tr>
			   <td class="width-15 active"><label class="pull-right"><font color="red">*</font>开始时间：</label></td>
			   <td class="width-35">
				   <input id="rzkssj" name="rzkssj" type="text" maxlength="20" class="laydate-icon form-control layer-date required"
				          value="<fmt:formatDate value="${keRz.rzkssj}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
			   </td>
			   <td class="width-15 active"><label class="pull-right"><font color="red">*</font>结束时间：</label></td>
			   <td class="width-35">
				   <input id="rzjssj" name="rzjssj" type="text" maxlength="20" class="laydate-icon form-control layer-date required"
				          value="<fmt:formatDate value="${keRz.rzjssj}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
			   </td>
		   </tr>

		   <tr>


					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>结清：</label></td>
					<td class="width-35">
						<form:radiobuttons path="isJq" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="i-checks required"/>
					</td>
			   <td class="width-15 active"><label class="pull-right">自有资金：</label></td>
			   <td class="width-35">

				   <form:input path="zyje" htmlEscape="false"    class="form-control "/>
			   </td>
				</tr>


		 	</tbody>
		</table>
	</form:form>
</body>
</html>