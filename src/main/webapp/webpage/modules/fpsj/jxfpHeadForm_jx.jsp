<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>发票数据管理</title>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<%--<meta name="viewport" content="width=device-width, initial-scale=1.0" />--%>
	<%--<meta name="decorator" content="default"/>--%>
	<link rel="stylesheet" href="${ctxStatic}/awesome/4.4/css/font-awesome.min.css" />
	<link href="${ctxStatic}/ace/assets/css/bootstrap.css" rel="stylesheet" />
	<link rel="stylesheet" href="${ctxStatic}/ace/assets/css/chosen.css" />
	<link rel="stylesheet" href="${ctxStatic}/dataTables/dataTables.bootstrap.css" />
	<link rel="stylesheet" href="${ctxStatic}/ace/assets/css/bootstrap-datetimepicker.css" />
	<link rel="stylesheet" href="${ctxStatic}/ace/assets/css/ace.css" />
	<%--<link rel="stylesheet" href="${ctxStatic}/ace/assets/css/jstree.css" />--%>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/ace/assets/css/wbox.css" />
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/main.css" />
	<link rel="stylesheet" href="${ctxStatic}/fpview.css" />


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
<div class="main-container" id="main-container">
	<div class="main-container-inner" style="margin-top:0px">


		<!--content begin-->
		<div id="content" class="clearfix">
			<div id="tabPage2">
				<div id="tabPage-zzszyfp">
					<h1 id="fpcc_zp" style="color:#574B9D;padding:5px 0px 5px 0px; text-align:center;">
						<c:choose>
							<c:when test="${jxfpHead.kplx == 0 }">
								增值税专用发票
							</c:when>
							<c:when test="${jxfpHead.kplx == 1 }">
								增值税普通发票
							</c:when>
							<c:otherwise>
								增值税其它发票
							</c:otherwise>
						</c:choose>

						</h1>

					<table border="0" cellpadding="0" cellspacing="0" style="width:100%">
						<tbody>
						<tr height="30">
							<td class="align_left">发票号码：<span class="content_td_blue" id="fpdm">${jxfpHead.fpdm}${jxfpHead.fphm}</span></td>
							<td>&nbsp;</td>
							<td class="align_left"></td>
							<td>&nbsp;</td>
							<td class="align_left"></td>
							<td>&nbsp;</td>
							<td class="align_left"></td>
							<td>&nbsp;</td>
							<td class="align_left" id="jqxx_zp" style="">开票日期：<span class="content_td_blue" id="kprq_zp"><fmt:formatDate value="${jxfpHead.kprq}" pattern="yyyy-MM-dd HH:mm:ss.SSS"/></span></td>
							<td align=right><a target="" href="${ctx}/fpsj/jxfpHead/export">下载</a></td>
						</tr>
						</tbody>
					</table>
					<table style="width:100%" border="0" cellspacing="0" cellpadding="0" class="fppy_table">
						<tbody>
						<tr>
							<td rowspan="4" class="align_center" width="20">
								<p>购</p>
								<p>买</p>
								<p>方</p>
							</td>
							<td class="align_left borderNo" width="105">名称：</td>
							<td nowrap="" class="align_left borderNo bgcolorWhite"><span class="content_td_blue" id="gfmc_zp">${jxfpHead.gmfmc}</span></td>
							<td rowspan="4" class="align_center" width="20">
								<p>密</p>
								<p>码</p>
								<p>区</p>
							</td>
							<td id="password_zp" rowspan="4" nowrap="" class="align_left " width="350">&nbsp;</td>
						</tr>
						<tr>
							<td class="align_left borderNo">纳税人识别号：</td>
							<td nowrap="" class="align_left borderNo"><span class="content_td_blue" id="gfsbh_zp">${jxfpHead.gmfsh}</span></td>
						</tr>
						<tr>
							<td class="align_left borderNo" valign="top">地址、电话：</td>
							<td class="align_left borderNo" valign="top"><span class="content_td_blue" id="gfdzdh_zp">${jxfpHead.gmfdz}</span></td>
						</tr>
						<tr>
							<td class="align_left borderNo" valign="top">开户行及账号：</td>
							<td class="align_left borderNo" valign="top"><span class="content_td_blue" id="gfyhzh_zp">${jxfpHead.gmfyhzh} </span></td>
						</tr>

						<!--表头-->
						<tr>
							<td colspan="5">
								<table cellspacing="0" cellpadding="0" style="width:100%;" class="fppy_table_box">
									<tbody>
									<tr id="tab_head_zp">
										<td class="align_center borderRight" width="30%">货物或应税劳务名称</td>
										<td class="align_center borderRight" width="10%">规格型号</td>
										<td class="align_center borderRight" width="5%">单位</td>
										<td class="align_center borderRight" width="10%">数量</td>
										<td class="align_center borderRight" width="10%">单价</td>
										<td class="align_center borderRight" width="15%">金额</td>
										<td class="align_center borderRight" width="5%">税率</td>
										<td class="align_center" width="15%">税额</td>
									</tr>
										<c:forEach items="${jxfpItemList}" var="jxfpItem"  varStatus="idx">
											<tr >
												<td class="align_center borderRight">
													<span class="content_td_blue" >${jxfpItem.hwmc}</span>
												</td>
												<td class="align_center borderRight" width="10%">
													<span class="content_td_blue" >${jxfpItem.ggxh}</span>

												</td>
												<td class="align_center borderRight" width="5%">
													<span class="content_td_blue" >${jxfpItem.dw}</span>

												</td>
												<td class="align_center borderRight" width="10%">
													<span class="content_td_blue" >${jxfpItem.xmsl}</span>

												</td>

												<td class="align_center borderRight" width="10%">
													<span class="content_td_blue" >${jxfpItem.bhsdj}</span>

												</td>
												<td class="align_center borderRight" width="15%">
													<span class="content_td_blue" >${jxfpItem.bhsje}</span>

												</td>
												<td class="align_center borderRight" width="5%">
													<span class="content_td_blue" >${jxfpItem.sl}</span>

												</td>
												<td class="align_center borderRight" width="15%">
													<span class="content_td_blue" >${jxfpItem.se}</span>

												</td>
											</tr>
										</c:forEach>





									<tr id="xiaoji" name="xiaoji">
										<td class="align_center borderRight">合计</td>
										<td class="align_center borderRight">&nbsp;</td>
										<td class="align_center borderRight">&nbsp;</td>
										<td class="align_center borderRight">&nbsp;</td>
										<td class="align_center borderRight">&nbsp;</td>
										<td class="align_right borderRight"><span class="content_td_blue" id="je_zp">￥${jxfpHead.hjbhsje}</span></td>
										<td class="align_center borderRight">&nbsp;</td>
										<td class="align_right"><span class="content_td_blue" id="se_zp">￥${jxfpHead.hjse}</span></td>
									</tr>
									<tr>
										<td class="align_center borderRight borderTop">价税合计（大写）</td>
										<td colspan="4" class="align_left borderTop"><span class="content_td_blue" id="jshjdx_zp"></span></td>
										<td colspan="3" class="align_left borderTop"><span style="padding:0 20px;">（小写）</span><span class="content_td_blue" id="jshjxx_zp">￥${jxfpHead.hjhsje}</span></td>
									</tr>
									</tbody>
								</table>
							</td>
						</tr>
						<!--表头结束-->
						<tr>
							<td rowspan="4" class="align_center">
								<p>销</p>
								<p>售</p>
								<p>方</p>
							</td>
							<td class="align_left borderNo">名称：</td>
							<td class="align_left borderNo"><span class="content_td_blue" id="xfmc_zp">${jxfpHead.xsfmc}</span></td>
							<td rowspan="4" class="align_center" width="20">
								<p>备</p>
								<p>注</p>
							</td>
							<td rowspan="4" class="align_left content_td_blue" width="350" id="bz_zp" valign="top"><div style="width:350px;height:150px;overflow:scroll">${jxfpHead.bz}</div></td>
						</tr>
						<tr>
							<td class="align_left borderNo">纳税人识别号：</td>
							<td class="align_left borderNo"><span class="content_td_blue" id="xfsbh_zp">${jxfpHead.xsfsh}</span></td>
						</tr>
						<tr>
							<td class="align_left borderNo">地址、电话：</td>
							<td class="align_left borderNo"><span class="content_td_blue" id="xfdzdh_zp">${jxfpHead.xsfdz}</span></td>
						</tr>
						<tr>
							<td class="align_left borderNo">开户行及账号：</td>
							<td class="align_left borderNo"><span class="content_td_blue" id="xfyhzh_zp">${jxfpHead.xsyhzh}</span></td>
						</tr>
						</tbody>
					</table>

				</div>
			</div>
		</div>


	</div>
</div>


</body>
</html>