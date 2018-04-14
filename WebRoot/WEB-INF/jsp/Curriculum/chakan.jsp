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
		
		<!-- 百度在线编辑器 -->
		<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
	    <script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.min.js"></script>
	    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
	    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
	    <script type="text/javascript" charset="utf-8" src="plugins/ueditor/lang/zh-cn/zh-cn.js"></script>
	</head>
<body>
	<form action="CurriculumManage/${msg }.do" name="Form" id="Form" method="post" enctype="multipart/form-data">
		<input type="hidden" name="InterFileID" value="${pd.InterFileID}"/>
		<div id="zhongxin">
		 <h3 style="text-align: center;" ><b>文章内容</b></h3>
		<table id="table_report" class="table table-striped table-bordered table-hover">
			<tr>
				<td>
				<%-- <span>${pd.PMIntroduction }</span> --%>
					<!-- <a class="btn btn-mini btn-primary" onclick="save();">保存</a> -->
					<a style="text-align: center; margin-left: 2%;" class="btn btn-mini btn-danger" onclick="top.Dialog.close();">返回</a>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="height: 100px;">
					<textarea id="editor" name="CurriculumContent" style="height:400px;width: 865px;">${pd.CurriculumContent==null?"":pd.CurriculumContent }</textarea>
				</td>
			</tr>
			<tr>
				<td>
				<%-- <span>${pd.PMIntroduction }</span> --%>
					<!-- <a class="btn btn-mini btn-primary" onclick="save();">保存</a> -->
					<a style="text-align: center; margin-left: 87%;" class="btn btn-mini btn-danger" onclick="top.Dialog.close();">返回</a>
				</td>
			</tr>
		</table>
		</div>
		<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
	</form>
	
	<!-- 温馨提示部分 -->
	<!--<div style="padding-left: 10px;color: red;font-size: 1px;">
		<p>温馨提示:</p>
		<p style="margin-bottom: 5px;">1.上传图标格式:gif、png、jpg、jpeg</p>
		<p>2.尺寸：50*50px</p>
	</div> -->
<script type="text/javascript">

	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	var ue = UE.getEditor('editor');


	$(top.hangge());
	$(function() {
		//上传
		$('#tp').ace_file_input({
			no_file:'请选择文件 ...',
			btn_choose:'选择',
			btn_change:'更改',
			droppable:false,
			onchange:null,
			thumbnail:false, //| true | large
			whitelist:'doc|docx|xls',
			//blacklist:'gif|png|jpg|jpeg'
			//onchange:''
			//
		});
		
	$("#FileType_parent").on("change",function(){
		
		var FileTypePathID=$("option:selected",this).val()
		
		if(FileTypePathID==''){
			htmlVal="<select ><option value=''>请选择选择文件类型</option></select>"
			$("#FileType_child").html(htmlVal);
			return
		}
		
			var url = "<%=basePath%>newsDetailes/ChildListOption.do?FileTypePathID="+FileTypePathID;
		
			$("#FileType_child").load(url);
		
		});
		
	});
</script>
<script type="text/javascript">
	//保存
	function save(){
		/*if(typeof($("#tpz").val()) == "undefined"){
			if($("#tp").val()=="" || document.getElementById("tp").files[0] =='请选择图片'){
				$("#tp").tips({
					side:3,
		            msg:'请选图片',
		            bg:'#AE81FF',
		            time:3
		        });
				return false;
			}
		}*/
		if($("#InterFileName").val()==""){
			$("#InterFileName").tips({
				side:3,
	            msg:'请输入标题',
	            bg:'#AE81FF',
	            time:3
	        });
			return;
		}
		if($("#FileName").val()==""){
			$("#FileName").tips({
				side:3,
	            msg:'请输入资讯标题',
	            bg:'#AE81FF',
	            time:3
	        });
			return;
		}
		//设置热度
		var classval=$("#cbox").attr("class")
		
		if(classval!=undefined){
			//选中热度
			if(classval=='cbox checked'){
				$("#FileTypeHot").val(1)
			}
			//取消热度
			if(classval.trim()=='cbox'){
				/* alert(classval) */
				$("#FileTypeHot").val(0)
			}
		}
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	
	//过滤类型
	function fileType(obj){
		var fileType=obj.value.substr(obj.value.lastIndexOf(".")).toLowerCase();//获得文件后缀名
	    if(fileType != '.xls' && fileType != '.docx' && fileType != '.doc' && fileType != '.jpeg'){
	    	$("#tp").tips({
				side:3,
	            msg:'请上传文件格式的文件',
	            bg:'#AE81FF',
	            time:3
	        });
	    	$("#tp").val('');
	    	document.getElementById("tp").files[0] = '请选择文件';
	    }
	}
	
	//删除图片
	function delP(icon_path,news_detailes_id){
		 if(confirm("确定要删除图片？")){
			var url = "<%=basePath%>newsDetailes/deleteImgPath.do?icon_path="+icon_path+"&news_detailes_id="+news_detailes_id;
			$.get(url,function(data){
				if(data=="success"){
					alert("删除成功!");
					document.location.reload();
				}
			});
		} 
	}
	//取消
	function closes() {
		window.location.href='javascript:history.go(-1)';
	}
</script>
</body>
</html>