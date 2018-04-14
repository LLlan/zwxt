﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 引入标签库 -->
<%@include file="/common/include/taglibs.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%> 
	</head> 
	<style>
		#trs>td {
			vertical-align: middle;
		}
	</style>
<body>
		
<div class="container-fluid" id="main-container">

<div id="page-content" class="clearfix">
						
  <div class="row-fluid">


	<div class="row-fluid">
	
			<!-- 检索  -->
			<form action="appraisingTopicsOption/AppraisingTopicsOptionListPage.do?ATID=${pd.ATID }" method="post" name="residenceForm" id="residenceForm">
			<table>
				<tr>
					<td>
						<span class="input-icon">
							<input autocomplete="off" id="nav-search-input" type="text" name="searchName" value="${pd.searchName }" placeholder="这里输入关键词" />
							<i id="nav-search-icon" class="icon-search"></i>
						</span>
					</td>
					<c:if test="${QX.cha == 1 }">
					<td style="vertical-align:top;"><button class="btn btn-mini btn-light" onclick="search();" title="检索"><i id="nav-search-icon" class="icon-search"></i></button></td>
					<%-- <td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="window.location.href='<%=basePath%>/user/listtabUsers.do';" title="切换模式"><i id="nav-search-icon" class="icon-exchange"></i></a></td> --%>
					<!-- <td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="icon-download-alt"></i></a></td> -->
					<%-- <c:if test="${QX.edit == 1 }"><td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="fromExcel();" title="从EXCEL导入"><i id="nav-search-icon" class="icon-cloud-upload"></i></a></td></c:if> --%>
					</c:if> 
				</tr>
			</table>
			<!-- 检索  -->
			<a title="返回上一页" href="report/goodsListPage.do" class="btn btn-mini btn-info" onclick="" >返回上一页</a>
			
			<table style="margin-top: 8px;" id="table_report" class="table table-striped table-bordered table-hover">
				
				<thead>
					<tr>
						<th class="center">
								<label><input type="checkbox" id="zcheckbox" /><span class="lbl"></span></label>
						</th>
						<th class='center'>序号</th>
						<th class='center'>所属投票题目标题名</th>
						<th class='center'>投票题目中的选项名称</th>
					    <th class='center'>本投票题目已投次数</th>
						<th class='center'>评优投票选项类型</th>
						<th class='center'>评优选项图像</th>
						<th class='center'>评优选项简介</th>
						<th class="center">操作</th>
					</tr>
				</thead>
										
		<tbody>
					
				<!-- 开始循环 -->	
				<c:choose>
					<c:when test="${not empty appraisingTopicsOptionList}">
						<c:if test="${QX.cha == 1 }">
						<c:forEach items="${appraisingTopicsOptionList}" var="rlist" varStatus="vs">
									
							<tr id="trs">
							<%-- 	<td class='center' style="width: 30px;">
									<c:if test="${user.USERNAME != 'admin'}"><label><input type='checkbox' name='ids' value="${user.USER_ID }" id="${user.EMAIL }" alt="${user.PHONE }"/><span class="lbl"></span></label></c:if>
									<c:if test="${user.USERNAME eq 'admin'}"><label><input type='checkbox' disabled="disabled" /><span class="lbl"></span></label></c:if>
								</td> --%>
								<td class='center' style="width: 20px;">
									<label>
										<input type='checkbox' name='ids' value="${rlist.ATOID }"/>
										<span class="lbl"></span>
									</label>
								</td>
								<td class='center' style="width: 30px;">${vs.index+1}</td>
								<td class='center'>${rlist.ATName}</td>
								<td class='center'>${rlist.ATOName}</td>
								<td class='center'>
									<c:if test="${rlist.ATOVotNum == null }">0</c:if>
									<c:if test="${rlist.ATOVotNum != null }">${rlist.ATOVotNum}</c:if>
								</td>
								<td class='center'>${rlist.ATOVotType }</td>
								<td class='center'><img style="width: 40px;height: 40px;" alt="" src="${rlist.ATOPhoto }"></td>
								<td>
									<a id="span_content" onclick="jianjie('${rlist.ATOID }')" style="" onmousemove="showdiv('span_div','',event)" onmouseover="showdiv('span_div','',event)" onmouseout="showdiv('span_div','none',event)">
										<c:if test="${rlist.ATOIntroduction !=null}">
											${fn:substring(rlist.ATOIntroduction eq null?'无':'查看选项简介',0,6)}...
										</c:if>
									</a>
								</td>
								<td>
									<a class='btn btn-mini btn-info' title="编辑" onclick="edit('${rlist.ATOID }','${pd.ATID }',true)" ><i class='icon-edit'></i></a>
									<a class='btn btn-mini btn-danger' title="删除"  onclick="del('${rlist.ATOID }','${pd.ATID }',true)"><i class='icon-trash'></i></a>
								</td>
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
							<td colspan="14" class="center">没有相关数据</td>
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
						<a class="btn btn-small btn-success" onclick="add('${pd.ATID}');">新增</a>
						<a title="批量删除" class="btn btn-small btn-danger" onclick="makeAll('确定要删除选中的数据吗?','${pd.ATID }',true);" ><i class='icon-trash'></i>批量删除</a>
					</c:if>
					<%-- 	<c:if test="${QX.FX_QX == 1 }">
						<a title="批量发送电子邮件" class="btn btn-small btn-info" onclick="makeAll('确定要给选中的用户发送邮件吗?');"><i class="icon-envelope-alt"></i></a>
						</c:if>
						<c:if test="${QX.FW_QX == 1 }">
						<a title="批量发送短信" class="btn btn-small btn-warning" onclick="makeAll('确定要给选中的用户发送短信吗?');"><i class="icon-envelope"></i></a>
						</c:if>
						<c:if test="${QX.del == 1 }">
						<a title="批量删除" class="btn btn-small btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" ><i class='icon-trash'></i></a>
						</c:if> --%>
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
		
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		
		<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- 引入 -->
		
		
		<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
		<script type="text/javascript">
		
		$(top.hangge());
		
		//检索
		function search(){
			top.jzts();
			$("#residenceForm").submit();
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
		//新增
		function add(atid){
			//window.location.href='report/goAddPage.do';
			top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>appraisingTopicsOption/goAddPage.do?ATID='+atid;
			 diag.Width = 900;
			 diag.Height = 550;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 top.jzts();
						 setTimeout("self.location.reload()",100);
					 }else{
						 //nextPage("${page.currentPage}");
						 window.location.href='appraisingTopicsOption/AppraisingTopicsOptionListPage.do?ATID='+atid;
					 }
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//修改
		function edit(tagID,ATID){
			 //window.location.href='newsDetailes/toEdit.do?FileID='+tagID;
			top.jzts();
		   	 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>appraisingTopicsOption/edit.do?tagID='+tagID;
			 diag.Width = 900;
			 diag.Height = 500;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					//nextPage("${page.currentPage}");
					 window.location.href='appraisingTopicsOption/AppraisingTopicsOptionListPage.do?ATID='+ATID;
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//查看简介
		function jianjie(ATOID){
			 top.jzts();
		   	 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="评优选项简介内容";
			 diag.URL = '<%=basePath%>appraisingTopicsOption/kanjianjie.do?ATOID='+ATOID;
			 diag.Width = 900;
			 diag.Height = 500;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					nextPage("${page.currentPage}");
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//删除
		function del(tagID,ATID){
			bootbox.confirm("确定要删除该条数据吗?", function(result) {
				if(result) {
					top.jzts();
					var url = '<%=basePath%>appraisingTopicsOption/del.do?ids='+tagID;
					$.get(url,function(data){
						//nextPage("${page.currentPage}");
						window.location.href='appraisingTopicsOption/AppraisingTopicsOptionListPage.do?ATID='+ATID;
					});
				}
			});
		}
		
		
		//批量操作
		function makeAll(msg,ATID){
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
							var url = "<%=basePath%>appraisingTopicsOption/del.do?ids="+str;
							$.get(url,function(data){
								//nextPage("${page.currentPage}");
								window.location.href='appraisingTopicsOption/AppraisingTopicsOptionListPage.do?ATID='+ATID;
							});
							$.ajax({
								type: "POST",
								url: '<%=basePath%>appraisingTopicsOption/del.do',
						    	data: {ids:str},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									 $.each(data.list, function(i, list){
											//nextPage("${page.currentPage}");
										 window.location.href='appraisingTopicsOption/AppraisingTopicsOptionListPage.do?ATID='+ATID;
									 });
								}
							});
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

