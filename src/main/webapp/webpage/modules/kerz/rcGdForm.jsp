<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>客户管理管理</title>
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
			var gdxm = $("#gdxm ").val();
			$('#gdxm').change(function(){
				var khzlid = $(this).children('option:selected').val();//这就是selected的值
			})

			$("#sfzh").blur(function(){
				var sfzh = $("#sfzh").val();
				var res = CertificateNoParse(sfzh);
				//年龄
				var nl = res.age;
				$("#nl").val(nl);
				//获取性别
				var xb = res.sex;
				if(xb == '男'){
					//$("input:radio[name=xb][value='1']").attr("checked",true);

					$("input[name='xb'][value='2']").attr("checked",false);
					$("input[name='xb'][value='2']").parent().removeClass("checked");

					$("input[name='xb'][value='1']").attr("checked",true);
					$("input[name='xb'][value='1']").parent().addClass("checked");
				}
				if(xb == '女'){
					//$("input:radio[name=xb][value='2']").attr("checked",true);
					$("input[name='xb'][value='1']").attr("checked",false);
					$("input[name='xb'][value='1']").parent().removeClass("checked");

					$("input[name='xb'][value='2']").attr("checked",true);
					$("input[name='xb'][value='2']").parent().addClass("checked");
				}


			});

			$("#name").focus();
			validateForm = $("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
			var khzlId = "${rcGd.rcKhzl.id}";
			if(null == khzlId || '' == khzlId || undefined == khzlId){
				$.ajax({
					type: "POST",
					url: "${ctx}/kerz/rcGd/getGdxm?time="+ new Date().getTime(),
					dataType: "json",
					success: function(data){
						var html = '';
						/*$("#gdxm").html('');*/
						/*console.info(data);*/
						if(data){
							$.each(data, function(idx, obj) {
								html += '<option value="'+obj.id+'">'+ obj.khmc+'</option>';
							});

						}else{
							html += '<option value="">暂无数据</option>';
						}

						$("#gdxm").html(html);

					}
				});
			}

		});

		function CertificateNoParse(certificateNo){
			var pat = /^\d{6}(((19|20)\d{2}(0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])\d{3}([0-9]|x|X))|(\d{2}(0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])\d{3}))$/;
			if(!pat.test(certificateNo))
				return null;

			var parseInner = function(certificateNo, idxSexStart, birthYearSpan){
				var res = {};
				var idxSex = 1 - certificateNo.substr(idxSexStart, 1) % 2;
				res.sex = idxSex == '1' ? '女' : '男';

				var year = (birthYearSpan == 2 ? '19' : '') +
					certificateNo.substr(6, birthYearSpan);
				var month = certificateNo.substr(6 + birthYearSpan, 2);
				var day = certificateNo.substr(8 + birthYearSpan, 2);
				res.birthday = year + '-' + month + '-' + day;

				var d = new Date(); //当然，在正式项目中，这里应该获取服务器的当前时间
				var monthFloor = ((d.getMonth()+1) < parseInt(month,10) || (d.getMonth()+1) == parseInt(month,10) && d.getDate() < parseInt(day,10)) ? 1 : 0;
				res.age = d.getFullYear() - parseInt(year,10) - monthFloor;
				return res;
			};

			return parseInner(certificateNo, certificateNo.length == 15 ? 14 : 16, certificateNo.length == 15 ? 2 : 4);
		};
	</script>

</head>
<body class="hideScroll">
	<form:form id="inputForm" modelAttribute="rcGd" action="${ctx}/kerz/rcGd/save" method="post" class="form-horizontal" target="_parent">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
		   <tr>
			   <td class="width-15 active"><label class="pull-right">客户名称:</label></td>
			   <td class="width-35">
				  <%-- <form:select  path="rcKhzl.gdxm"    style="width:446px" >
					   <form:option value="" label=""/>
					   <form:options items="${fns:getDictList('rcgd_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				   </form:select>--%>
					  <c:if test="${not empty rcGd.rcKhzl.id }">
						  <select id ="gdxm"  name="rcKhzl.id"  class="form-control m-b" required >
								<option value="${rcGd.rcKhzl.id}" selected >${rcGd.rcKhzl.khmc}</option>
						  </select>
					  </c:if>
					  <c:if test="${empty rcGd.rcKhzl.id }">
						  <select id ="gdxm"  name="rcKhzl.id"  class="form-control m-b" required >

						  </select>
					  </c:if>
			   </td>
			   <input type="hidden" name="rcKhzl.id" value="${rcGd.rcKhzl.id}"/>
			   <input type="hidden" name="rcGd.id" value="${rcGd.id}"/>
			   <input type="hidden" name="parent.id" value="${rcGd.parent.id}"/>
		   </tr>
			<tr>
				<input type="hidden" name="rcKhzl.id" value="${rcGd.rcKhzl.id}"/>
				<input type="hidden" name="rcGd.id" value="${rcGd.id}"/>
				<input type="hidden" name="parent.id" value="${rcGd.parent.id}"/>
				<td class="width-15 active"><label class="pull-right">亲属:</label></td>
				<td>
					<c:if test="${empty rcGd.parent.id}">
						无
					</c:if>
					<c:if test="${not empty rcGd.parent.id}">
						${rcGd.parent.name}
					</c:if>
				</td>
				<%--<td class="width-35">--%>
					<%--<sys:treeselect id="parent" name="parent.id" value="${rcGd.parent.id}" labelName="parent.name" labelValue="${rcGd.parent.name}"--%>
						<%--title="上级亲属名称" url="/kerz/rcGd/treeData?rcKhzl.id=${rcGd.rcKhzl.id}" extId="${rcGd.id}" cssClass="form-control " allowClear="true" />--%>
				<%--</td>--%>
			</tr>
		   <tr>
			   <td class="width-15 active"><label class="pull-right">亲属关系:</label></td>
			   <td class="width-35">
				   <form:select path="jtcy"   class="form-control m-b" style="width:446px" >
					   <form:option value="" label=""/>
					   <form:options items="${fns:getDictList('jtcy_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				   </form:select>
			   </td>
		   </tr>
		   <tr>
			   <td class="width-15 active"><label class="pull-right">是否是担保人:</label></td>
			   <td class="width-35">
				   <form:select path="isDbr"   class="form-control m-b" style="width:446px" >
					   <form:option value="" label=""/>
					   <form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				   </form:select>
			   </td>
		   </tr>
			<tr>
				<td class="width-15 active"><label class="pull-right">类型:</label></td>
				<td class="width-35">
					<form:select path="khlx"   class="form-control m-b" style="width:446px"  >
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('rcgd_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</td>
			</tr>
			<tr>
				<td class="width-15 active"><label class="pull-right">占股比:</label></td>
				<td class="width-35">
					<form:input path="zgb" class="form-control"  />
				</td>
			</tr>
			<tr>
				<td class="width-15 active"><label class="pull-right">姓名:</label></td>
				<td class="width-35">
					<form:input path="gdxm" class="form-control"  />
				</td>
			</tr>
			<tr>
				<td class="width-15 active"><label class="pull-right">身份证号:</label></td>
				<td class="width-35">
					<form:input path="sfzh" class="form-control"  />
				</td>
			</tr>
			<tr>
				<td class="width-15 active"><label class="pull-right">性别:</label></td>
				<td class="width-35">
					<form:radiobuttons path="xb" items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required i-checks "/>
				</td>
			</tr>
			<tr>
				<td class="width-15 active"><label class="pull-right">年龄:</label></td>
				<td class="width-35">
					<form:input path="nl" class="form-control"  />
				</td>
			</tr>


		</tbody>
	</table>
	</form:form>
</body>
</html>