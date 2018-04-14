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
		<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="static/css/font-awesome.min.css" />
		<link rel="stylesheet" href="static/css/ace.min.css" />
		<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
		<link rel="stylesheet" href="static/css/ace-skins.min.css" />
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>

<script type="text/javascript">
	$(top.hangge());	
	
	//新增
	function addmenu(){
		 top.jzts();
		 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="新增菜单";
		 diag.URL = '<%=basePath%>PartyOrgan/toAdd.do';
		 diag.Width = 500;
		 diag.Height = 400;
		 diag.CancelEvent = function(){ //关闭事件
			if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				top.jzts(); 
				setTimeout("location.reload()",100);
			}
			diag.close();
		 };
		 diag.show();
	}
	
	//修改
	function editmenu(menuId){
		 top.jzts();
	   	 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="编辑";
		 diag.URL = '<%=basePath%>bank/toEdit.do?PBLCityID='+menuId;
		 diag.Width = 450;
		 diag.Height = 300;
		 diag.CancelEvent = function(){ //关闭事件
			if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				top.jzts(); 
				setTimeout("location.reload()",100);
			}
			diag.close();
		 };
		 diag.show();
	}
	
	//编辑顶部菜单图标
	function editTb(menuId){
		 top.jzts();
	   	 var diag = new top.Dialog();
		 diag.Drag=true;
		 diag.Title ="编辑党组织机构名";
		 diag.URL = '<%=basePath%>PartyOrgan/toEditicon.do?POID='+menuId;
		 diag.Width = 500;
		 diag.Height = 400;
		 diag.CancelEvent = function(){ //关闭事件
			if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				top.jzts(); 
				setTimeout("location.reload()",100);
			}
			diag.close();
		 };
		 diag.show();
	}
	
	function delmenu(menuId,isParent){
		var flag = false;
		if(isParent){
			if(confirm("确定要删除该菜单吗？其下子菜单将一并删除！")){
				flag = true;
			}
		}else{
			if(confirm("确定要删除该菜单吗？")){
				flag = true;
			}
		}
		if(flag){
			top.jzts();
			var url = "<%=basePath%>bank/delPBLProvince.do?MENU_ID="+menuId+"&guid="+new Date().getTime();
			$.get(url,function(data){
				top.jzts();
				document.location.reload();
			});
		}
	}
	
	function delmenus(menuId,isParent){
		var flag = false;
		if(isParent){
			if(confirm("确定要删除该菜单吗？其下子菜单将一并删除！")){
				flag = true;
			}
		}else{
			if(confirm("确定要删除该菜单吗？")){
				flag = true;
			}
		}
		if(flag){
			top.jzts();
			var url = "<%=basePath%>PartyOrgan/deletePartyOrganization.do?MENU_ID="+menuId+"&guid="+new Date().getTime();
			$.get(url,function(data){
				top.jzts();
				document.location.reload();
			});
		}
	}
	
	
	var style=10;
	
	function openClose(menuId,curObj,trIndex){
		
		var width=$('#tr'+menuId).children("td").next().children("span").css("width");
		/* alert("width:"+width) */
		if(width!=undefined){
			
			style=parseInt(width.split("px")[0])+40
			
		}
		/* alert("style:"+style) */
		var txt = $(curObj).text();
		if(txt=="展开"){
			$(curObj).text("折叠");
			$("#tr"+menuId).after("<tr id='tempTr"+menuId+"'><td colspan='5'>数据载入中</td></tr>");
			 if(trIndex%2==0){
				$("#tempTr"+menuId).addClass("main_table_even");
			} 
			var url = "<%=basePath%>PartyOrgan/subsd.do?MENU_ID="+menuId+"&guid="+new Date().getTime();
			$.get(url,function(data){
				if(data.length>0){	
					var html = "";
					$.each(data,function(i){
						html = "<tr id='tr"+this.POID+"' style='height:24px;line-height:24px;' name='subTr"+menuId+"'>";
						html += "<td></td>";
						html += "<td><span style='width:"+style+"px;display:inline-block;'></span>";
						if(i==data.length-1)
							html += "<img src='static/images/joinbottom.gif' style='vertical-align: middle;'/>";
						else
							html += "<img src='static/images/join.gif' style='vertical-align: middle;'/>";
						html += "<span style='width:100px;text-align:left;display:inline-block;'>"+this.POName+"</span>";
						html += "</td>";
						html += "<td>"+this.POPhone+"</td>";
						html += "<td>"+this.POAddress+"</td>";
						html += "<td>"+this.POType+"</td>";
						html += "<td><a class='btn btn-mini btn-warning' onclick='openClose(\""+this.POID+"\",this,0)'>展开</a> <a class='btn btn-mini btn-info' title='编辑' onclick='editTb(\""+this.POID+"\")'><i class='icon-edit'></i></a> <a class='btn btn-mini btn-danger' title='删除' onclick='delmenus(\""+this.POID+"\",false)'><i class='icon-trash'></i></a></td>";
						html += "</tr>";
						$("#tempTr"+menuId).before(html);
					});
					$("#tempTr"+menuId).remove();
					if(trIndex%2==0){
						$("tr[name='subTr"+menuId+"']").addClass("main_table_even");
					}
				}else{
					$("#tempTr"+menuId+" > td").html("没有相关数据");
				}
			},"json");
		}else{
			$("#tempTr"+menuId).remove();
			
			var seconde=$("tr[name='subTr"+menuId+"']")
			
			
			//三级删除
			
			var resultlist=findRemove(seconde)
			for(var i=0;i<resultlist.length;i++){
				resultlist[i].remove();
			}
			
			//二级删除
			$("tr[name='subTr"+menuId+"']").remove();
			
			$(curObj).text("展开");
			
		}
		
	}
	
	var list=new Array();
	
	function findRemove(objarr){
		for(var i=0;i<objarr.length;i++){
			var trid=$(objarr[i]).attr("id").split("tr")[1];
			var temptr=$("#tempTr"+trid);
			var resultarr=$("tr[name='subTr"+trid+"']")
			list.push(resultarr)
			list.push(temptr)
			findRemove(resultarr)
		}
		return list;
	}
	
</script>
</head>

<body>
	<table id="table_report" class="table table-striped table-bordered table-hover">
		<thead>
		<tr>
			<th class="center"  style="width: 50px;">序号</th>
			<th class='center'>党组织机构名</th>
			<th class='center'>党组织机构联系电话</th>
			<th class='center'>党组织机构地址</th>
			<th class='center'>党组织机构类型</th>
			<th class='center'>操作</th>
		</tr>
		</thead>
		<c:choose>
			<c:when test="${not empty partyOrganizationList}">
			<c:if test="${QX.cha == 1 }">
				<c:forEach items="${partyOrganizationList}" var="menu" varStatus="vs">
				<tr id="tr${menu.POID }">
				<td class="center">${vs.index+1}</td>
				<td class='center'>
					${menu.POName }
				</td>
				<td class='center'>
					${menu.POPhone }
				</td>
				<%-- <td>${menu.PBANetURL == '#'? '': menu.PBANetURL}</td> --%>
				<td class='center'>${menu.POAddress }</td>
				<td class='center'>${menu.POType }</td>
				<td class='center' style="width: 25%;">
					<a class='btn btn-mini btn-warning' onclick="openClose('${menu.POID }',this,${vs.index })" >展开</a>
					<%-- <a class='btn btn-mini btn-purple' title="图标" onclick="editTb('${menu.PBLProvinceID }')" ><i class='icon-picture'></i></a> --%>
					<a class='btn btn-mini btn-info' title="编辑" onclick="editTb('${menu.POID }')" ><i class='icon-edit'></i></a>
					<a class='btn btn-mini btn-danger' title="删除"  onclick="delmenus('${menu.POID }',true)"><i class='icon-trash'></i></a>
				</td>
				</tr>
				</c:forEach>
			</c:if>
			<c:if test="${QX.cha == 0 }">
				<tr>
					<td colspan="100" class="center">您无权查看</td>
				</tr>
			</c:if>
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan="100" class="center">没有相关数据</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</table>
	
	<div class="page_and_btn">
		<div>
			<c:if test="${QX.add == 1 }">
				&nbsp;&nbsp;<a class="btn btn-small btn-success" onclick="addmenu();">新增</a>
			</c:if>
			<c:if test="${QX.cha == 1 }">
				<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
			</c:if>
		</div>
	</div>
	
</body>
</html>