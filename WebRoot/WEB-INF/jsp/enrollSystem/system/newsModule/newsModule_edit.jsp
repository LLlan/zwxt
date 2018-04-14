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
		<title></title>
		<meta name="description" content="overview & stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="static/css/bootstrap.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="static/css/ace.min.css" />
		<link rel="stylesheet" href="static/css/ace-skins.min.css" />
		<link rel="stylesheet" href="static/assets/css/font-awesome.css" />
		<!-- ace styles -->
		<link rel="stylesheet" href="static/assets/css/ace.css" class="ace-main-stylesheet" id="main-ace-style" />

		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<!--查看图片插件 -->
		<script type="text/javascript" src="static/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="static/js/ace-elements.min.js"></script>
		<script type="text/javascript" src="static/js/ace.min.js"></script>
		<!-- 确认窗口 -->
		<script type="text/javascript" src="static/js/bootbox.min.js"></script>
		
		<!-- 引入 -->
		<!--[if !IE]> -->
		<script type="text/javascript">
			window.jQuery || document.write("<script src='static/assets/js/jquery.js'>"+"<"+"/script>");
		</script>
		<script src="static/js/bootstrap.min.js"></script>
		<!-- ace scripts -->
		<script src="static/assets/js/ace/elements.fileinput.js"></script>
		<script src="static/assets/js/ace/ace.js"></script>
		<style>
			  .cbox{display:block;width:16px;height:16px;border:1px solid #ccc;background:#fff;}
			  .cbox.checked{background:#f00;}
			  .cbox.checked:after{content:""}
		</style>
	</head>
<body>
	<form action="newsModule/${msg }.do" name="Form" id="Form" method="post" enctype="multipart/form-data">
		<input type="hidden" name="SectionID" value="${pd.SectionID}"/>
		<input type="hidden" name="SectionFatherID" value="${pd.SectionFatherID}"/>
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">
			<tr>
				<td>所属版块:</td>
				<td>
					<select id="selected">
						  	<option value ="">顶级板块</option>
						 <c:forEach items="${fileTypeList}" var="fileType">
						  	<option value ="${fileType.FileTypeID }">${fileType.FileTypeName }</option>
						 </c:forEach>
					</select>
				</td>	
			</tr>
			<tr>
				<td>版块名称:</td>
				<td>
					<input type="text" name="FileTypeName" id="FileTypeName" value="" placeholder="输入版块名称"/>
				</td>
			</tr>
			<input   type="hidden" name="FileTypePathID" id="FileTypePathID" value="" />
				<tr id='ishots'>
					<td>是否热度:</td>
					<td>
						<span id="cbox" class="cbox" onclick="this.className=/checked/ig.test(this.className)?this.className.replace('checked',''):(this.className+' checked')"></span>
						<input type="hidden"  name="FileTypeHot" id="FileTypeHot" value="0"/>
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
		<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
	</form>
	
	<!-- 温馨提示部分 -->
	<!-- <div style="padding-left: 10px;color: red;font-size: 1px;">
		<p>温馨提示:</p>
		<p style="margin-bottom: 5px;">1.上传图标格式:gif、png、jpg、jpeg</p>
		<p>2.尺寸：50*50px</p>
	</div> -->
<script type="text/javascript">

	$(top.hangge());
	$(function() {
		//上传
		$('#tp').ace_file_input({
			no_file:'请选择图片 ...',
			btn_choose:'选择',
			btn_change:'更改',
			droppable:false,
			onchange:null,
			thumbnail:false, //| true | large
			whitelist:'gif|png|jpg|jpeg',
			//blacklist:'gif|png|jpg|jpeg'
			//onchange:''
			//
		});
		
		$("#selected").on("change",function(){
			
			$("#FileTypePathID").val($("option:selected",this).val())
			
			if ($("option:selected",this).val() == '') {
					$("#ishot").show()
			}
			else{
				$("#ishot").hide()
			}
		});
		
		
	})
	
</script>
<script type="text/javascript">
	//保存
	function save(){
		/* if(typeof($("#tpz").val()) == "undefined"){
			if($("#tp").val()=="" || document.getElementById("tp").files[0] =='请选择图片'){
				$("#tp").tips({
					side:3,
		            msg:'请选图片',
		            bg:'#AE81FF',
		            time:3
		        });
				return false;
			}
		} */
		
		//设置热度
		var classval=$("#cbox").attr("class")
		//选中热度
		if(classval=='cbox checked'){
			$("#FileTypeHot").val('1')
		}
		
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show(); 
	}
	
	//过滤类型
	function fileType(obj){
		var fileType=obj.value.substr(obj.value.lastIndexOf(".")).toLowerCase();//获得文件后缀名
	    if(fileType != '.gif' && fileType != '.png' && fileType != '.jpg' && fileType != '.jpeg'){
	    	$("#tp").tips({
				side:3,
	            msg:'请上传图片格式的文件',
	            bg:'#AE81FF',
	            time:3
	        });
	    	$("#tp").val('');
	    	document.getElementById("tp").files[0] = '请选择图片';
	    }
	}
	
	//删除图片
	function delP(icon_path,news_module_id){
		 if(confirm("确定要删除图片？")){
			var url = "<%=basePath%>api/newsModule/deleteImgPath.do?icon_path="+icon_path+"&news_module_id="+news_module_id;
			$.get(url,function(data){
				if(data=="success"){
					alert("删除成功!");
					document.location.reload();
				}
			});
		} 
	}
</script>
</body>
</html>