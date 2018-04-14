<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:forEach items="${childList }" var="FileType">
	<tr style="height: 24px; line-height: 24px;" name="fatherID_${FileType.FileTypePathID }">  
			<td></td>
			<td></td>
			<td>
				<span style="width: 300px; display: inline-block;"></span> 
				<img src="static/images/join.gif" style="vertical-align: middle;"> 
				<span style="width: 200px; text-align: left; display: inline-block;">${FileType.FileTypeName}</span>
			</td>
			<td>
				<a class="btn btn-mini btn-info" title="编辑" onclick="editBtn(${FileType.FileTypeID})"> <i class="icon-edit"></i></a> 
				<a class="btn btn-mini btn-danger" title="删除" onclick="delBtn(${FileType.FileTypeID},this)"> <i class="icon-trash"></i> </a>
			</td>
	</tr>
	
</c:forEach>

