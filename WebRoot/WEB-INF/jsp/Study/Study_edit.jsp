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
		<!-- jsp文件头和头部 -->
		<%@ include file="../system/admin/top.jsp"%>
		<meta charset="utf-8" />
		<title></title>
		<meta name="description" content="overview & stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="static/css/bootstrap.min.css" rel="stylesheet" />
		<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="static/css/font-awesome.min.css" />
		<!-- 下拉框 -->
		<link rel="stylesheet" href="static/css/chosen.css" />
		<link rel="stylesheet" href="static/css/ace.min.css" />
		<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
		<link rel="stylesheet" href="static/css/ace-skins.min.css" />
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<!--提示框-->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript" src="static/js/common/jsAddress.js"></script>  
		<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
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
</script>
<script type="text/javascript">
		$(top.hangge());
		$(document).ready(function(){
		});
	
		//保存
		function save(){

			if($("#CurriculumSeriesPosition").val()==""){
				$("#CurriculumSeriesPosition").tips({
					side:3,
		            msg:'请选择广告位',
		            bg:'#AE81FF',
		            time:2
		        });
				return;
			}
			if($("#CurriculumSeriesName").val()==""){
				$("#CurriculumSeriesName").tips({
					side:3,
		            msg:'请输入标题',
		            bg:'#AE81FF',
		            time:2
		        });
				return;
			}
			$("#residenceForm").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
	
	
	
	//验证邮箱格式
	function ismail(mail){
		return(new RegExp(/^(?:[a-zA-Z0-9]+[_\-\+\.]?)*[a-zA-Z0-9]+@(?:([a-zA-Z0-9]+[_\-]?)*[a-zA-Z0-9]+\.)+([a-zA-Z]{2,})+$/).test(mail));
		}
	
	//验证身份证号码格式
	function isIDCard(IDCard){
		return(new RegExp(/^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$|^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/).test(IDCard));
	}; 	
	
	 //判断用户名是否存在
	 function hasU(){
		var USERNAME = $("#loginname").val();
		var url = "<%=basePath%>user/hasU.do?USERNAME="+USERNAME+"&tm="+new Date().getTime();
		$.get(url,function(data){
			if(data=="error"){
				$("#loginname").css("background-color","#D16E6C");
				setTimeout("$('#loginname').val('此用户名已存在!')",500);
			}else{
				$("#userForm").submit();
				$("#zhongxin").hide();
				$("#zhongxin2").show();
			}
		});
	} 
	
	//判断邮箱是否存在
	function hasE(USERNAME){
		var EMAIL = $("#EMAIL").val();
		var url = "<%=basePath%>user/hasE.do?EMAIL="+EMAIL+"&USERNAME="+USERNAME+"&tm="+new Date().getTime();
		$.get(url,function(data){
			if(data=="error"){
				
				$("#EMAIL").tips({
					side:3,
		            msg:'邮箱已存在',
		            bg:'#AE81FF',
		            time:3
		        });
				
				setTimeout("$('#EMAIL').val('')",2000);
				
			}
		});
	}
	
	//判断编码是否存在
	function hasN(USERNAME){
		var NUMBER = $("#NUMBER").val();
		var url = "<%=basePath%>user/hasN.do?NUMBER="+NUMBER+"&USERNAME="+USERNAME+"&tm="+new Date().getTime();
		$.get(url,function(data){
			if(data=="error"){
				
				$("#NUMBER").tips({
					side:3,
		            msg:'编号已存在',
		            bg:'#AE81FF',
		            time:3
		        });
				
				setTimeout("$('#NUMBER').val('')",2000);
				
			}
		});
	}
	
</script>
<style type="text/css">
	.P-C-AClass{
		width: 100px;
	}
	.P-C-AClass2{
		width: 150px;
	}
	.P-C-AClass3{
		width: 170px;
	}
	.inputClass{
		width: 290px;
	}
	.table tr td input{
		width: 420px;
	}
</style>
	</head>
<body>
	<form action="StudyManage/${msg }.do" id="residenceForm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="CurriculumSeriesID" id="CurriculumSeriesID" value="${pd.CurriculumSeriesID}"/>
		<input type="hidden" name="CurriculumSeriesPositions" id="CurriculumSeriesPositions" value="${pd.CurriculumSeriesPosition}"/>
		<div id="zhongxin">
		<table class="table table-striped table-bordered">
			<%-- <tr>
				<td>所属党组织机构:</td>
				<td>
					<select name="POID" id="POID">
						<option value="">请选择所属党组织机构</option>
						<c:forEach items="${menuList }" var="va">
							<option value="${va.POID }" <c:if test="${pd.POID == va.POID }">selected</c:if> >${va.POName }</option>
						</c:forEach>
					</select>
				</td>
			</tr> --%>
			<c:if test="${msg =='insert' }">
				<tr>
					<td>放置页面的位置：</td>
					<td>
					     <select name="CurriculumSeriesPosition" id="CurriculumSeriesPosition" title="广告位列表设置">
					     	<option value="">请选择放置页面的位置</option>
							<option value="0" <c:if test="${pd.CurriculumSeriesPosition == '0' }">selected</c:if> >普通列表</option>
							<option value="1" <c:if test="${pd.CurriculumSeriesPosition == '1' }">selected</c:if> >热门列表</option>
							<option value="2" <c:if test="${pd.CurriculumSeriesPosition == '2' }">selected</c:if> >广告位列表</option>
						</select>    
					</td>
				</tr>
			</c:if>
			<c:if test="${msg !='insert' }">
				<tr>
					<td>放置页面的位置：</td>
					<td>
					     <select name="CurriculumSeriesPositions" id="CurriculumSeriesPositions" title="广告位列表设置" disabled="disabled">
					     	<option value="">请选择放置页面的位置</option>
							<option value="0" <c:if test="${pd.CurriculumSeriesPosition == '0' }">selected</c:if> >普通列表</option>
							<option value="1" <c:if test="${pd.CurriculumSeriesPosition == '1' }">selected</c:if> >热门列表</option>
							<option value="2" <c:if test="${pd.CurriculumSeriesPosition == '2' }">selected</c:if> >广告位列表</option>
						</select>    
					</td>
				</tr>
			</c:if>
			<tr>
				<td>标题：</td>
				<td>
				     <input type="text" placeholder="请输入标题" name="CurriculumSeriesName" id="CurriculumSeriesName" value="${pd.CurriculumSeriesName}" class="inputClass"  title=""/>
				</td>
			</tr>
			<tr>
				<td>介绍图片:</td>
				<td>
					<c:if test="${pd == null || pd.CurriculumSeriesPhotoUrl == '' || pd.CurriculumSeriesPhotoUrl == null }">
						<input type="file" id="tp" name="file" onchange="fileType(this)"/>
					</c:if>
					<c:if test="${pd != null && pd.CurriculumSeriesPhotoUrl != '' && pd.CurriculumSeriesPhotoUrl != null }">
						<a href="${pd.CurriculumSeriesPhotoUrl}" target="_blank">
							<img style="width:50px; height: 50px" src="${pd.CurriculumSeriesPhotoUrl}"/>
						</a>
						<%-- <input type="button" class="btn btn-mini btn-danger" value="删除" onclick="delP('${pd.PhotoPath}','${pd.PhotoID }');" /> --%>
						<input type="file" id="tp" name="file" value="${pd.CurriculumSeriesPhotoUrl }" onchange="fileType(this)"/>
						<input type="hidden" name="CurriculumSeriesPhotoUrl" id="tpz" value="${pd.CurriculumSeriesPhotoUrl }"/>
					</c:if>
				</td>
			</tr>
			
			<tr>
				<td style="text-align: center;" colspan="2">
					<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
					<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
				</td>
			</tr>
		</table>
		</div>
		
		<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green"></h4></div>
		
	</form>
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		<script src="static/js/chosen.jquery.min.js" type="text/javascript"></script><!-- 下拉框 -->
		<script type="text/javascript">

	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	var ue = UE.getEditor('editor');


	$(top.hangge());
	$(function() {
		//上传图片
		$('#tp').ace_file_input({
			no_file:'请选择文件 ...',
			btn_choose:'选择',
			btn_change:'更改',
			droppable:false,
			onchange:null,
			thumbnail:false, //| true | large
			whitelist:'jpg|png|gif|jpeg|bmp|tga|tiff|dxf',
			//blacklist:'gif|png|jpg|jpeg'
			//onchange:''
			//
		});
	});
</script>
</body>
</html>