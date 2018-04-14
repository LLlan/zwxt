<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
				<form action="newsModule/getlistPage.do" method="post" id="Form">
					<table>
						<tr>
						</tr>
					</table>
					<!-- 检索  -->
					<table id="table_report" class="table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th class="center">
									<label><input type="checkbox" id="zcheckbox" /><span class="lbl"></span></label>
								</th>
								<th>序号</th>
								<th class="center">版块名称</th>
								<th class="center">操作</th>
							</tr>
						</thead>
						<tbody>
						<!-- 开始循环 -->	
						<c:choose>
							<c:when test="${not empty list}">
							<c:if test="${QX.cha == 1 }">
								<c:forEach items="${list}" var="va" varStatus="vs">
									<tr>
										<td class='center' style="width: 30px;">
											<label>
												<input type='checkbox' name='ids' value="${va.FileTypeID }"/>
												<span class="lbl"></span>
											</label>
										</td>
										<td class='center' style="width: 30px;">${vs.index+1}</td>
										<td class="center">${va.FileTypeName }</td>
										<td class='center' style="width: 15%;">
											<a class='btn btn-mini btn-warning' onclick="openClose('${va.FileTypeID }',this)" >展开</a>
											<a class='btn btn-mini btn-info' title="编辑" onclick="editBtn('${va.FileTypeID }')" ><i class='icon-edit'></i></a>
											<a class='btn btn-mini btn-danger' title="删除"  onclick="delBtn('${va.FileTypeID }',this)"><i class='icon-trash'></i></a>
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
									 <a class="btn btn-small btn-success" onclick="add();">新增</a>
									<a title="批量删除" class="btn btn-small btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" ><i class='icon-trash'></i>批量删除</a> 
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
	//新增
	function add(){
		 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="新增";
		 diag.URL = '<%=basePath%>newsModule/toAdd.do';
		 diag.Width = 500;
		 diag.Height = 350;
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
		
	
	//修改
	function editBtn(FileTypeID){

		 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="新增";
		 diag.URL = '<%=basePath%>newsModule/editBtn.do?FileTypeID='+FileTypeID;
		 diag.Width = 500;
		 diag.Height = 350;
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
	
	//删除
	function del(id){
		bootbox.confirm("确定要执行删除操作吗?", function(result) {
			if(result) {
				top.jzts();
				var url = "<%=basePath%>newsModule/delete.do?ids="+id;
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
						var url = "<%=basePath%>newsModule/delete.do?ids="+str;
						$.get(url,function(data){
							nextPage("${page.currentPage}");
							alert(sd)
						});
						$.ajax({
							type: "POST",
							url: '<%=basePath%>newsModule/delete.do',
					    	data: {ids:str},
							dataType:'json',
							//beforeSend: validateData,
							cache: false,
							success: function(data){
								 $.each(data.list, function(i, list){
										nextPage("${page.currentPage}");
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
	
	
	function openClose(FileTypePathID,swap){
		
		/* alert(FileTypePathID)
		
		alert($(swap))
		
		alert($(swap).parent().parent()) */
		
		var text =$(swap).text()
		
		if(text=='关闭'){
			
			var name="fatherID_"+FileTypePathID
			
				$("tr[name="+name+"]").each(function(){
					
				    $(this).remove()
				    
				  });
	
			$(swap).text("展开")
			
			return
		}
		
		var url = "<%=basePath%>newsModule/fileTypeChild.do?FileTypePathID="+FileTypePathID;
		
	//加载下级	
		$.ajax({
		  url: url,
		  type: 'get',
		  dataType: 'html',
		  success: function (data, status) {
			  $(swap).parent().parent().after(data)
			  $(swap).text("关闭")
		  },
		  fail: function (err, status) {
			  alert("失败")
		  }
		})
			
	}
	
	//删除
	function delBtn46546(FileTypeID,swap){
		bootbox.confirm("确定要执行删除操作吗?", function(result) {
			if(result) {
				
			}
		});
	}
	
	function delBtn(FileTypeID,swap){
		
		var url = "<%=basePath%>newsModule/delBtn.do?FileTypeID="+FileTypeID;
		
		bootbox.confirm("确定要执行删除操作吗?", function(result) {
			if(result) {
			$.ajax({
				  url: url,
				  type: 'get',
				  dataType: 'json',
				  success: function (data, status) {
					  
					  bootbox.dialog(data.message, 
								[
								  {
									"label" : "关闭",
									"class" : "btn-small btn-success",
									"callback": function() {
											
										}
									}
								 ]
							);
					  
					  $(swap).parent().parent().remove();
					  
				  },
				  fail: function (err, status) {
					  alert("失败")
				  }
				})
			}
		});
	}
	
</script>
</body>
</html>

