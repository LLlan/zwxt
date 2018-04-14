<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="<%=basePath%>">
		<meta charset="utf-8" />
		<title>${pd.SYSNAME}</title>
		<meta name="description" content="overview & stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<!-- basic styles -->
		<link href="static/css/bootstrap.min.css" rel="stylesheet" />
		<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="static/css/font-awesome.min.css" />
		<!-- page specific plugin styles -->
		<!-- 下拉框-->
		<link rel="stylesheet" href="static/css/chosen.css" />
		<!-- ace styles -->
		<link rel="stylesheet" href="static/css/ace.min.css" />
		<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
		<link rel="stylesheet" href="static/css/ace-skins.min.css" />
		<link rel="stylesheet" href="static/css/datepicker.css" /><!-- 日期框 -->
		
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<!--引入弹窗组件start-->
		<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
		<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
		<!--引入弹窗组件end-->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
		<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
	</head> 
<body>
<div class="container-fluid" id="main-container">
	<div id="page-content" class="clearfix">
		<div class="row-fluid">
			<div class="row-fluid">
				<!-- 检索  -->
				<form action="InterFile/interFileListPage.do" method="post" id="Form">
					<table>
						<tr>
							<td>
								<span class="input-icon">
									<input autocomplete="off" id="nav-search-input" type="text" name="searchName" value="${pd.searchName}" placeholder="这里输入关键词" />
									<i id="nav-search-icon" class="icon-search"></i>
								</span>
							</td>
							<%-- <td style="vertical-align:top;"> 
							 	<select class="chzn-select" name="searchNames" id="searchNames" data-placeholder="请选择商品类别" style="vertical-align:top;width: 150px;">
								<option value=""></option>
								<option value=""><c:if test="${not empty spfllist}">全部</c:if></option>
								<c:forEach items="${spfllist}" var="spfllists">
									<option value="${spfllists.goods_category_id }" <c:if test="${spfllists.goods_category_id==pd.searchNames}">selected</c:if>>${spfllists.categoryName }</option>
								</c:forEach>
							  	</select>
							</td> --%>
							<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;"><button class="btn btn-mini btn-light" onclick="search();" title="检索"><i id="nav-search-icon" class="icon-search"></i></button></td>
								<%-- <td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="window.location.href='<%=basePath%>/user/listtabUsers.do';" title="切换模式"><i id="nav-search-icon" class="icon-exchange"></i></a></td>
								<td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="icon-download-alt"></i></a></td>
								<c:if test="${QX.edit == 1 }"><td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="fromExcel();" title="从EXCEL导入"><i id="nav-search-icon" class="icon-cloud-upload"></i></a></td></c:if> --%>
							</c:if>
						</tr>
					</table>
					<!-- 检索  -->
					<table id="table_report" class="table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th class="center">
									<label><input type="checkbox" id="zcheckbox" /><span class="lbl"></span></label>
								</th>
								<th class="center">序号</th>
								<th class="center">标题</th>
								<th class="center">副标题</th>
								<th class="center"><i class="icon-time hidden-phone">上传时间</th>
								<th class="center">简介内容</th>
								<!-- <th class="center">内部资料标题</th>
								<th class="center">下载数量</th> -->
								<th class="center">操作</th>
							</tr>
						</thead>
						<tbody>
						<!-- 开始循环 -->	
						<c:choose>
							<c:when test="${not empty interFileList}">
							<c:if test="${QX.cha == 1 }">
								<c:forEach items="${interFileList}" var="va" varStatus="vs">
									<tr>
										<td class='center' style="width: 30px;">
											<label>
												<input type='checkbox' name='ids' value="${va.InterFileID }"/>
												<span class="lbl"></span>
											</label>
										</td>
										<td class='center' style="width: 30px;">${vs.index+1}</td>
										<td class='center'>${va.InterFileName }</td>
										<td class='center'>${va.InterFileFuName }</td>
										<td class='center'>
										<%-- ${fn:substring(va.FileTime,0,16)} --%>
											<%-- <fmt:formatDate type="both" dateStyle="long" timeStyle="long" value="${va.InterFileTime}" /> --%>
											<fmt:formatDate value="${rlist.InterFileTime}" type="both" pattern="yyyy-MM-dd HH:mm"/>
											<%-- <fmt:formatDate type="both" dateStyle="full" timeStyle="full" value="${va.FileTime}" /> --%>
										</td>
										<td class='center'>
											<a id="span_content" onclick="jianjie('${va.InterFileID }')" style="" onmousemove="showdiv('span_div','',event)" onmouseover="showdiv('span_div','',event)" onmouseout="showdiv('span_div','none',event)">
												<c:if test="${va.InterFileIntroduction != null}">
													${fn:substring(va.InterFileIntroduction eq null?'无':'查看简介内容',0,6)}...
												</c:if>
											</a>
										</td>
										<%-- <td class='center'>${va.ItemName }</td>
										<td class='center'>${va.ItemNum }</td> --%>
										<!-- 操作部分 ben-->
										<td style="width: 60px;">
											<div class='hidden-phone visible-desktop btn-group'>
												<a class='btn btn-mini btn-success' title="文件管理"  href="InterFile/InterFileItemListPage.do?InterFileID=${va.InterFileID}" onclick="InterFileItemadds('${va.InterFileID}');">文件管理</a>
												<a class='btn btn-mini btn-info' title="编辑" onclick="edit('${va.InterFileID }');"><i class='icon-edit'></i></a>
												<a class='btn btn-mini btn-danger' title="删除" onclick="del('${va.InterFileID }');"><i class='icon-trash'></i></a>
											</div>
										</td>
										<!-- 操作部分end -->
									</tr>
								</c:forEach>
								</c:if>
								<c:if test="${QX.cha == 0 }">
									<tr>
										<td colspan="10" class="center">您无权查看</td>
									</tr>
								</c:if>
								
							</c:when>
							<c:otherwise>
								<tr class="main_info">
									<td colspan="10" class="center">没有相关数据</td>
								</tr>
							</c:otherwise>
						</c:choose>
						</tbody>
					</table>
					<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;">
								<c:if test="${QX.add == 1 }">
									<a class="btn btn-small btn-success" onclick="add();">新增</a>
									<a title="批量删除" class="btn btn-small btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" ><i class='icon-trash'></i>批量删除</a>
								</c:if>
									<!--  
									<c:if test="${QX.add == 1 }">
									<a class="btn btn-small btn-success" onclick="add();">新增</a>
									</c:if>
									<c:if test="${QX.FX_QX == 1 }">
									<a title="批量发送电子邮件" class="btn btn-small btn-info" onclick="makeAll('确定要给选中的用户发送邮件吗?');"><i class="icon-envelope-alt"></i></a>
									</c:if>
									<c:if test="${QX.FW_QX == 1 }">
									<a title="批量发送短信" class="btn btn-small btn-warning" onclick="makeAll('确定要给选中的用户发送短信吗?');"><i class="icon-envelope"></i></a>
									</c:if>
									<c:if test="${QX.del == 1 }">
									<a title="批量删除" class="btn btn-small btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" ><i class='icon-trash'></i></a>
									</c:if>
									-->
								</td>
								<c:if test="${QX.cha == 1 }">
									<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
								</c:if>
							</tr>
						</table>
					</div>
				</form>
			</div>
		<!-- PAGE CONTENT ENDS HERE -->
	  	</div><!--/row-->
	</div><!--/#page-content-->
</div><!--/.fluid-container#main-container-->
<!-- 返回顶部  -->
<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
	<i class="icon-double-angle-up icon-only"></i>
</a>
<script type="text/javascript">
	$(top.hangge());
		
	//检索
	function search(){
		top.jzts();
		$("#userForm").submit();
	}
		
	//去发送电子邮件页面
	function sendEmail(EMAIL){
		 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="发送电子邮件";
		 diag.URL = '<%=basePath%>head/goSendEmail.do?EMAIL='+EMAIL;
		 diag.Width = 660;
		 diag.Height = 470;
		 diag.CancelEvent = function(){ //关闭事件
			diag.close();
		 };
		 diag.show();
	}
		
	//去发送短信页面
	function sendSms(phone){
		 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="发送短信";
		 diag.URL = '<%=basePath%>head/goSendSms.do?PHONE='+phone+'&msg=appuser';
		 diag.Width = 600;
		 diag.Height = 265;
		 diag.CancelEvent = function(){ //关闭事件
			diag.close();
		 };
		 diag.show();
	}
	
	//去上传内部资料新增（文件管理）
	function InterFileItemadd(ItemID){
		 //window.location.href='InterFile/toEditItem.do?ItemID='+id;
		top.jzts();
	   	 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="编辑";
		 diag.URL = '<%=basePath%>InterFile/toEditItem.do?InterFileID='+ItemID;
		 diag.Width = 600;
		 diag.Height = 300;
		 diag.CancelEvent = function(){ //关闭事件
			 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				nextPage("${page.currentPage}");
			}
			diag.close();
		 };
		 diag.show();
	}
	
	//新增
	function add(){
		window.location.href='InterFile/toAdd.do';
	}
		
	//修改
	function edit(id){
		 window.location.href='InterFile/toEdit.do?InterFileID='+id;
	}
	//查看简介
	function jianjies(id){
		 window.location.href='InterFile/kanjianjie.do?InterFileID='+id;;
	}
	//查看简介
	function jianjie(PMID){
		 top.jzts();
	   	 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="查看简介内容";
		 diag.URL = '<%=basePath%>InterFile/kanjianjie.do?InterFileID='+PMID;
		 diag.Width =900;
		 diag.Height = 600;
		 diag.CancelEvent = function(){ //关闭事件
			 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				nextPage("${page.currentPage}");
			}
			diag.close();
		 };
		 diag.show();
	}
	//删除
	function del(id){
		bootbox.confirm("确定要执行删除操作吗?", function(result) {
			if(result) {
				top.jzts();
				var url = "<%=basePath%>InterFile/deleteFile.do?ids="+id;
				$.get(url,function(data){
					nextPage("${page.currentPage}");
				});
			}
		});
	}
	//批量操作
	function makeAll(msg){
		bootbox.confirm(msg, function(result) {
			if(result) {
				var str = '';
				var emstr = '';
				var phones = '';
				for(var i=0;i < document.getElementsByName('ids').length;i++)
				{
					  if(document.getElementsByName('ids')[i].checked){
					  	if(str=='') str += document.getElementsByName('ids')[i].value;
					  	else str += ',' + document.getElementsByName('ids')[i].value;
					  	
					  	if(emstr=='') emstr += document.getElementsByName('ids')[i].id;
					  	else emstr += ';' + document.getElementsByName('ids')[i].id;
					  	
					  	if(phones=='') phones += document.getElementsByName('ids')[i].alt;
					  	else phones += ';' + document.getElementsByName('ids')[i].alt;
					  }
				}
				if(str==''){
					bootbox.dialog("您没有选择任何内容!", 
						[
						  {
							"label" : "关闭",
							"class" : "btn-small btn-success",
							"callback": function() {
								//Example.show("great success");
								}
							}
						 ]
					);
					
					$("#zcheckbox").tips({
						side:3,
			            msg:'点这里全选',
			            bg:'#AE81FF',
			            time:1
			        });
					
					return;
				}else{
					if(msg == '确定要删除选中的数据吗?'){
						top.jzts();
						var url = "<%=basePath%>InterFile/deleteFile.do?ids="+str;
						$.get(url,function(data){
							nextPage("${page.currentPage}");
						});
						/*$.ajax({
							type: "POST",
							url: '<%=basePath%>InterFile/deleteFile.do',
					    	data: {ids:str},
							dataType:'json',
							//beforeSend: validateData,
							cache: false,
							success: function(data){
								 $.each(data.list, function(i, list){
										nextPage("${page.currentPage}");
								 });
							}
						});*/
					}else if(msg == '确定要给选中的用户发送邮件吗?'){
						sendEmail(emstr);
					}else if(msg == '确定要给选中的用户发送短信吗?'){
						sendSms(phones);
					}
					
					
				}
			}
		});
	}
		
</script>
<script type="text/javascript">
	$(function() {
		//日期框
		$('.date-picker').datepicker();
		//下拉框
		$(".chzn-select").chosen(); 
		$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
		//复选框
		$('table th input:checkbox').on('click' , function(){
			var that = this;
			$(this).closest('table').find('tr > td:first-child input:checkbox')
			.each(function(){
				this.checked = that.checked;
				$(this).closest('tr').toggleClass('selected');
			});
		});
	});
		
	//导出excel
	function toExcel(){
		var USERNAME = $("#nav-search-input").val();
		var lastLoginStart = $("#lastLoginStart").val();
		var lastLoginEnd = $("#lastLoginEnd").val();
		var ROLE_ID = $("#role_id").val();
		window.location.href='<%=basePath%>user/excel.do?USERNAME='+USERNAME+'&lastLoginStart='+lastLoginStart+'&lastLoginEnd='+lastLoginEnd+'&ROLE_ID='+ROLE_ID;
	}
		
	//打开上传excel页面
	function fromExcel(){
		 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="EXCEL 导入到数据库";
		 diag.URL = '<%=basePath%>user/goUploadExcel.do';
		 diag.Width = 300;
		 diag.Height = 150;
		 diag.CancelEvent = function(){ //关闭事件
			 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				 if('${page.currentPage}' == '0'){
					 top.jzts();
					 setTimeout("self.location.reload()",100);
				 }else{
					 nextPage("${page.currentPage}");
				 }
			}
			diag.close();
		 };
		 diag.show();
	}
</script>
</body>
</html>

