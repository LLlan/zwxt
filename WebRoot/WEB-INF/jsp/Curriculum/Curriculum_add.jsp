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
		
		
		<!-- 引入 -->
		<!--[if !IE]> -->
		<script type="text/javascript">
			window.jQuery || document.write("<script src='static/assets/js/jquery.js'>"+"<"+"/script>");
		</script>
		<script src="static/js/bootstrap.min.js"></script>
		<!-- ace scripts -->
		<script src="static/assets/js/ace/elements.fileinput.js"></script>
		<script src="static/assets/js/ace/ace.js"></script>
		
		<!-- 百度在线编辑器 -->
		<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
	    <script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.min.js"></script>
	    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
	    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
	    <script type="text/javascript" charset="utf-8" src="plugins/ueditor/lang/zh-cn/zh-cn.js"></script>
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

			if($("#CurriculumType").val()==""){
				$("#CurriculumType").tips({
					side:3,
		            msg:'请选择课程类型',
		            bg:'#AE81FF',
		            time:2
		        });
				return;
			}
			if($("#CurriculumSeriesID").val()==""){
				$("#CurriculumSeriesID").tips({
					side:3,
		            msg:'请选择所属广告位标题',
		            bg:'#AE81FF',
		            time:2
		        });
				return;
			}
			$("#residenceForm").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		//图片过滤类型
		function fileTypes(obj){
			var fileTypes=obj.value.substr(obj.value.lastIndexOf(".")).toLowerCase();//获得文件后缀名jpg|png|gif|jpeg|bmp|tga|tiff|dxf
		    if(fileTypes != '.jpg' && fileTypes != '.pdf' && fileTypes != '.png' && fileTypes != '.jpeg' && fileTypes != '.bmp' && fileTypes != '.tga' && fileTypes != '.tiff' && fileTypes !='.dxf'){
		    	$("#tps").tips({
					side:3,
		            msg:'请上传图片格式的文件',
		            bg:'#AE81FF',
		            time:3
		        });
		    	$("#tps").val('');
		    	document.getElementById("tps").files[0] = '请选择文件';
		    }
		}
		//视频过滤类型
		function fileType(obj){
			var fileType=obj.value.substr(obj.value.lastIndexOf(".")).toLowerCase();//获得文件后缀名
		    if(fileType != '.avi' && fileType != '.rm' && fileType != '.mpeg' && fileType != '.m4v' && fileType != '.mkv' && fileType != '.rmvb' && fileType != '.flv' && fileType !='.mp4'){
		    	$("#tp").tips({
					side:3,
		            msg:'请上传视频格式的文件',
		            bg:'#AE81FF',
		            time:3
		        });
		    	$("#tp").val('');
		    	document.getElementById("tp").files[0] = '请选择文件';
		    }
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
	<form action="CurriculumManage/${msg }.do" id="residenceForm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="CurriculumID" id="CurriculumID" value="${pd.CurriculumID}"/>
		<input type="hidden" name="CurriculumSeriesID" id="CurriculumSeriesID" value="${pd.CurriculumSeriesID}"/>
		<div id="zhongxin">
		<table class="table table-striped table-bordered">
			<tr>
				<td>课程类型：</td>
				<td>
				     <select name="CurriculumType" id="CurriculumType" title="课程类型">
				     	<option value="">请选择课程类型</option>
						<option value="0" <c:if test="${pd.CurriculumType == '0' }">selected</c:if> >文章</option>
						<option value="1" <c:if test="${pd.CurriculumType == '1' }">selected</c:if> >视频</option>
					</select>    
				</td>
			</tr>
			<tr>
				<td>所属广告位标题:</td>
				<td>
					<%-- <select name="CurriculumSeriesID" id="CurriculumSeriesID">
						<option value="">请选择所属广告位标题</option>
						<c:forEach items="${CurriculumSeriesALlList }" var="va">
							<option value="${va.CurriculumSeriesID }" <c:if test="${pd.CurriculumSeriesID == va.CurriculumSeriesID }">selected</c:if> >${va.CurriculumSeriesName }</option>
						</c:forEach>
					</select> --%>
				     <input type="text" placeholder="" disabled="disabled" name="CurriculumSeriesName" id="CurriculumSeriesName" value="${pd.CurriculumSeriesName}" class="inputClass"  title=""/>
				</td>
			</tr>
			<tr>
				<td>标题：</td>
				<td>
				     <input type="text" placeholder="请输入标题" name="CurriculumName" id="CurriculumName" value="${pd.CurriculumName}" class="inputClass"  title=""/>
				</td>
			</tr>
			<tr>
				<td>介绍图片:</td>
				<td>
					<c:if test="${pd == null || pd.CurriculumPhotoUrl == '' || pd.CurriculumPhotoUrl == null }">
						<input type="file" id="tps" name="files" onchange="fileTypes(this)"/>
					</c:if>
					<c:if test="${pd != null && pd.CurriculumPhotoUrl != '' && pd.CurriculumPhotoUrl != null }">
						<a href="${pd.CurriculumPhotoUrl}" target="_blank">
							<img style="width:50px;" src="${pd.CurriculumPhotoUrl}"/>
						</a>
						<%-- <input type="button" class="btn btn-mini btn-danger" value="删除" onclick="delP('${pd.PhotoPath}','${pd.PhotoID }');" /> --%>
						<input type="file" id="tps" name="files" value="${pd.CurriculumPhotoUrl }" onchange="fileTypes(this)"/>
						<input type="hidden" name="CurriculumPhotoUrl" id="tpz" value="${pd.CurriculumPhotoUrl }"/>
					</c:if>
				</td>
			</tr>
			<tr>
				<td>学分：</td>
				<td>
				     <input type="text" placeholder="请输入分数" name="CurriculumScore" id="CurriculumScore" value="${pd.CurriculumScore}" class="inputClass"  title=""/>
				</td>
			</tr>
			<tr id="ishot">
				<td>存储视频路径:</td>
				<td>
					<c:if test="${pd == null || pd.CurriculumVideoUrl == '' || pd.CurriculumVideoUrl == null }">
						<input type="file" id="tp" name="file" onchange="fileType(this)"/>
					</c:if>
					<c:if test="${pd != null && pd.CurriculumVideoUrl != '' && pd.CurriculumVideoUrl != null }">
						<a style="color: black;" onchange="fileType(this)" target="_blank">
							1.<i class="icon-folder-open"></i><b>文件</b>
						</a>
						<%-- <input type="button" class="btn btn-mini btn-danger" value="删除" onclick="delP('${pd.PhotoPath}','${pd.PhotoID }');" /> --%>
						<input type="file" id="tp" name="file" value="${pd.CurriculumVideoUrl }" onchange="fileType(this)"/>
						<input type="hidden" name="CurriculumVideoUrl" id="tpz" value="${pd.CurriculumVideoUrl }"/>
					</c:if>
				</td>
			</tr>
			<tr id="1">
				<td colspan="2">文章内容:</td>
			</tr>
			<tr id="2">
				<td colspan="2" style="height: 100px;">
					<textarea id="editor" name="CurriculumContent" style="height:400px;width: 700px;">${pd.CurriculumContent==null?"":pd.CurriculumContent }</textarea>
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
		<div id="zhongxin2" class="center" style="display:none">
			<br/><br/><br/><br/>
			<img src="static/images/jiazai.gif" />
			<!--进度条标签-->
			<!-- <div class="progress .progress-striped .active">
			  <div class="bar" style="width: 40%;">60%</div>
			</div> -->
			<br/><h4 class="lighter block green">视频文件,正在上传请耐心等待....</h4>
		</div>
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
		$('#tps').ace_file_input({
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
		//上传视频
		$('#tp').ace_file_input({
			no_file:'请选择文件 ...',
			btn_choose:'选择',
			btn_change:'更改',
			droppable:false,
			onchange:null,
			thumbnail:false, //| true | large
			whitelist:'avi|rm|mpeg|m4v|mkv|rmvb|flv|mp4',
			//blacklist:'gif|png|jpg|jpeg'
			//onchange:''
			//
		});
		
		$("#CurriculumType").on("change",function(){
			
			if ($("option:selected",this).val() ==0) {
				$("#ishot").hide()
				$("#1").show()
				$("#2").show()
			}else{
				$("#ishot").show()
				$("#1").hide()
				$("#2").hide()
			}
			
		});
	});
</script>
</body>
</html>