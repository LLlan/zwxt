package com.yizhan.controller.enrollSystem.system;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.yizhan.controller.base.BaseController;
import com.yizhan.entity.Page;
import com.yizhan.entity.system.User;
import com.yizhan.service.enrollSystem.system.NewsDetailesService;
import com.yizhan.service.enrollSystem.system.NewsModuleService;
import com.yizhan.util.Const;
import com.yizhan.util.DateUtil;
import com.yizhan.util.DelAllFile;
import com.yizhan.util.FileUpload;
import com.yizhan.util.PageData;
import com.yizhan.util.PathUtil;
import com.yizhan.util.Tools;

/**
 * 
* @ClassName: NewsDetailesController
* @Description: TODO(文件信息管理)
* @author lj
* @date 2017年10月13日 上午10:34:58
*
 */
@Controller
@RequestMapping(value="/newsDetailes")
public class NewsDetailesController extends BaseController{

	@Resource(name="newsDetailesService")
	private NewsDetailesService newsDetailesService;
	
	@Resource(name="newsModuleService")
	private NewsModuleService newsModuleService;
	
	/**
	 * 获取文件信息列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/getlistPage")
	public ModelAndView getlistPage(Page page) throws Exception{
		logBefore(logger, "获取文件信息列表");
		
		
		ModelAndView mv=new ModelAndView();
		PageData pd=new PageData();
		pd=this.getPageData();
		page.setPd(pd);
		Map<String, Object> map = new HashMap<String, Object>();
		page.getCurrentPage();//当前页
		page.getShowCount();//总数
		map.put("searchName", pd.get("searchName"));
		map.put("searchNames", pd.get("searchNames"));
		map.put("pageSize", page.getShowCount());
		PageData coun = newsDetailesService.getCount(map);
		System.out.println(coun.get("counts").toString());
		int count = Integer.parseInt(coun.get("counts").toString());
		int i=count/10;
		if(count%10!=0){
			i+=1;
		}
		page.setTotalResult(count); 
		page.setTotalPage(i);
		Object currentPage= pd.get("page.currentPage");
		map.put("pagestart", 0);
		page.setCurrentPage(1); 
		if(currentPage!=null){
			 Integer curren=  Integer.parseInt(currentPage.toString());
			int renum= curren;
			map.put("pagestart", (renum-1));
			page.setCurrentPage(renum);  
		}
		List<PageData> list=newsDetailesService.getlistPage(map);
		List<PageData> FileTypeList=newsModuleService.getAllListParent();
		mv.addObject("FileTypeList", FileTypeList);
		mv.addObject("pd", pd);
		mv.addObject("list", list);
		mv.setViewName("enrollSystem/system/newsDetailes/newsDetailes_list");
		return mv;
	}
	/**
	 * 进入添加页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/toAdd")
	public ModelAndView toAdd() throws Exception{
		logBefore(logger, "进入添加页面");
		ModelAndView mv=new ModelAndView();
		PageData pd=new PageData();
		mv.addObject("msg", "insert");
		//板块信息
//		List<PageData> FileTypeList=newsDetailesService.getAllListParent();
		List<PageData> FileTypeList=newsModuleService.getAllListParent();
		mv.addObject("FileTypeList", FileTypeList);
		//广告图片类型
		List<PageData> PhotoTypeList=newsModuleService.getPhotoTypeList(pd);
		mv.addObject("PhotoTypeList", PhotoTypeList);
		mv.setViewName("enrollSystem/system/newsDetailes/newsDetailes_edit");
		return mv;
	}
	/**
	 * 添加信息
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/insert")
	@ResponseBody
	public ModelAndView insert(HttpServletRequest request,
			@RequestParam(required=false) MultipartFile[] file,
			String FileName,
			String FileContent,
			String FileTypeID,
			String FileType,
			String PhotoName,
			String PhotoDescription,
			String PhotoURL,
			String PhotoTypeID,
			String FileHot
			) throws Exception{
		logBefore(logger, "添加信息");
		ModelAndView mv=new ModelAndView();
		PageData pd=new PageData();
		pd=this.getPageData();
		Subject subject = SecurityUtils.getSubject();
		Session session = subject.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);
		//保存信息
		pd.put("FileName", FileName);//文件名称
		pd.put("FileContent", FileContent);//文件内容
		pd.put("SectionID", FileTypeID);//版块id
		pd.put("FileTime", DateUtil.getTime());//文件上传时间
		if (FileType == null) {
			pd.put("FileType", FileTypeID);//文件类型
		} else {
			pd.put("FileType", FileType);//文件类型
		}
		pd.put("FileHot", FileHot);//是否热度
		System.err.println(FileHot);
		pd.put("FileAuthor", user.getNAME());//文件上传者
		PageData FileID = newsDetailesService.insertFile(pd);//执行上传保存文件信息
		
		String StrFileID = String.valueOf(FileID);
		if(StrFileID.contains("=")){
			
			String temp = StrFileID.substring(2, StrFileID.length()-1);
			StrFileID = temp;
//			if (null != file && !file.isEmpty()){
//				//保存图片
//				String filePath=Const.FILEPATHIMG + "newsModule/" + DateUtil.getDays() + "/";
//				String fileName=FileUpload.fileUpAndZip(file,PathUtil.getClasspath() + filePath, this.get32UUID(),375,220);
//				pd.put("PhotoPath", BaseController.getPath(request)+filePath+fileName);//图片存储路径
//			}
			if(file[0].getSize()>0){
				for(int i=0;i<file.length;i++){
					if (file[i]!=null && !file[i].isEmpty()) {
//						String filePath = PathUtil.getClasspath() + Const.FILEPATHIMG + fabuFilePath + ffile;		//文件上传路径
//						fileName = FileUpload.fileUp(imgPath[i], filePath, this.get32UUID());	
						String filePath=Const.FILEPATHIMG + "newsModule/" + DateUtil.getDays() + "/";
						if (FileHot.equals("1")) {//是热度图片不压缩
							String fileName=FileUpload.fileUp(file[i],PathUtil.getClasspath() + filePath, this.get32UUID());
							pd.put("PhotoPath", BaseController.getPath(request)+filePath+fileName);//图片存储路径
						}else {
							String fileName=FileUpload.fileUpAndZip(file[i],PathUtil.getClasspath() + filePath, this.get32UUID(),375,220);
							pd.put("PhotoPath", BaseController.getPath(request)+filePath+fileName);//图片存储路径
						}
						System.out.println("================进来了========");
						//添加到数据库
						pd.put("PhotoName", PhotoName);//图片名称
						pd.put("FileID", StrFileID);//文件信息外键ID
						pd.put("PhotoDescription", PhotoDescription);//图片文字说明
						pd.put("PhotoURL", PhotoURL);//图片链接URL
						pd.put("PhotoTypeID", PhotoTypeID);//图片类型外键id
						PageData PhotoIDS =newsDetailesService.insertPhoto(pd);//执行上传保存图片信息
						System.out.println(PhotoIDS);
					}
				}
			}else{
				System.out.println("=======图片文件为空======");
			}
		}
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		mv.setViewName("redirect:/newsDetailes/getlistPage");
		return mv;
	}
	
	/**
	 * 进入修改页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/toEdit")
	public ModelAndView toEdit() throws Exception{
		logBefore(logger, "进入修改页面");
		ModelAndView mv=new ModelAndView();
		PageData pd=new PageData();
		pd=this.getPageData();
		//获取指定对象信息
		pd=newsDetailesService.getDateById(pd);
		//获取新闻模块列表
		List<PageData> newsModeList=newsModuleService.getListAll(pd);
		mv.addObject("newsModeList", newsModeList);
		//获取新文件类型列表
//		List<PageData> FileTypeList=newsDetailesService.getAllListParent();
		System.out.println(pd.get("FileTypeIDs"));
		System.out.println(pd.get("FileTypeID"));
		if (pd.get("FileTypeIDs")==null) {
			pd.put("FileTypePathsID", pd.get("FileTypeID"));//二级id
		} else {
			pd.put("FileTypePathsID", pd.get("FileTypeIDs"));//二级id
		}
		List<PageData> FileTypeListAll=newsDetailesService.getFileTypeListAll(pd);
		List<PageData> FileTypeList=newsModuleService.getAllListParent();
		//广告图片类型
		List<PageData> PhotoTypeList=newsModuleService.getPhotoTypeList(pd);
		
		//广告图片多图列表
		List<PageData> PhotoList=newsModuleService.getPhotoList(pd);
		mv.addObject("pd", pd);
		mv.addObject("msg", "updateFile");
		mv.addObject("PhotoTypeList", PhotoTypeList);
		mv.addObject("FileTypeListAll", FileTypeListAll);
		mv.addObject("FileTypeList", FileTypeList);
		mv.addObject("PhotoList", PhotoList);
		mv.setViewName("enrollSystem/system/newsDetailes/newsDetailes_edit");
		return mv;
	}
	
	
	/**
	 * 对指定对象进行修改
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/updateFile")
	public ModelAndView updateFile(
			HttpServletRequest request,
			@RequestParam(required=false) MultipartFile[] file,
			String FileID,
			String FileName,
			String FileContent,
			String SectionID,
			String FileTypes,
			String PhotoName,
			String PhotoDescription,
			String PhotoURL,
			String PhotoTypeID,
			String PhotoIDS,
			String PhotoPath,
			String FileTypeIDs,
			String FileHot
			) throws Exception{
		logBefore(logger, "对指定对象进行修改");
		ModelAndView mv=new ModelAndView();
		PageData pd=new PageData();
		pd=this.getPageData();
		Subject subject = SecurityUtils.getSubject();
		Session session = subject.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);
		//保存信息
		pd.put("FileID", FileID);//文件名称
		pd.put("FileName", FileName);//文件名称
		pd.put("FileContent", FileContent);//文件内容
		pd.put("SectionID", SectionID);//版块id
		pd.put("FileTime", DateUtil.getTime());//文件上传时间
		if (FileTypes == null) {
			pd.put("FileType", FileTypeIDs);//文件类型
		} else {
			pd.put("FileType", FileTypes);//文件类型
		}
		pd.put("FileHot", FileHot);//是否热度
		pd.put("FileAuthor", user.getNAME());//文件上传者
		newsDetailesService.updateFile(pd);
		
//		if(file!=null && !file.isEmpty()){
//			//保存图片
//			String filePath=Const.FILEPATHIMG + "newsModule/" + DateUtil.getDays() + "/";
//			String fileName=FileUpload.fileUpAndZip(file,PathUtil.getClasspath() + filePath, this.get32UUID(),375,220);
//			pd.put("PhotoPath", BaseController.getPath(request)+filePath+fileName);
//		}else{
//			pd.put("PhotoPath", PhotoPath);
//		}
		
		if(file[0].getSize()>0){
			List<PageData> FileIDyList = newsDetailesService.getDateByPhotoIds(pd);
			if (FileIDyList.size() != 0) {
				for (int i = 0; i < FileIDyList.size(); i++) {
						PageData pageData = new PageData();
						System.out.println(FileIDyList.get(i).get("PhotoID"));
						System.out.println(FileIDyList.get(i).get("PhotoPath"));
						pd.put("PhotoID", FileIDyList.get(i).get("PhotoID"));
						System.out.println(PathUtil.getClasspath() + FileIDyList.get(i).get("PhotoPath"));
						DelAllFile.delFolder(PathUtil.getClasspath() + FileIDyList.get(i).get("PhotoPath"));//删除图片
//						newsDetailesService.deleteImgPath(pd);//删除数据中图片数据 delAllFile
						newsDetailesService.deletePhotos(pd);
					}
			}
				for(int i=0;i<file.length;i++){
					if (file[i]!=null && !file[i].isEmpty()) {
//					String filePath = PathUtil.getClasspath() + Const.FILEPATHIMG + fabuFilePath + ffile;		//文件上传路径
//					fileName = FileUpload.fileUp(imgPath[i], filePath, this.get32UUID());	
						String filePath=Const.FILEPATHIMG + "newsModule/" + DateUtil.getDays() + "/";
						if (FileHot.equals("1")) {//是热度图片不压缩
							String fileName=FileUpload.fileUp(file[i],PathUtil.getClasspath() + filePath, this.get32UUID());
							pd.put("PhotoPath", BaseController.getPath(request)+filePath+fileName);//图片存储路径
						}else {
							String fileName=FileUpload.fileUpAndZip(file[i],PathUtil.getClasspath() + filePath, this.get32UUID(),375,220);
							pd.put("PhotoPath", BaseController.getPath(request)+filePath+fileName);//图片存储路径
						}
						System.out.println("================进来了========");
						//添加到数据库
						pd.put("PhotoID", PhotoIDS);//图片id
						pd.put("PhotoName", PhotoName);//图片名称
						pd.put("FileID", FileID);//文件信息外键ID
						pd.put("PhotoDescription", PhotoDescription);//图片文字说明
						pd.put("PhotoURL", PhotoURL);//图片链接URL
						pd.put("PhotoTypeID", PhotoTypeID);//图片类型外键id
//					newsDetailesService.updatePhoto(pd);
						PageData PhotoIDSi =newsDetailesService.insertPhoto(pd);//执行上传保存图片信息
					}
				}
		}else{
			System.out.println("=======图片文件为空======");
		}
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		mv.setViewName("redirect:/newsDetailes/getlistPage");
		return mv;
	}
	/**
	 * 根据ID删除指定对象的信息
	 * @param writer
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteFile")
	public void deleteFile(PrintWriter writer) throws Exception{
		logBefore(logger, "---根据ID删除指定对象的信息--");
		PageData pd=new PageData();
		Map<String, Object> map=new HashMap<String, Object>();
		pd=this.getPageData();
		String id[]=pd.getString("ids").split(",");
		List<String> ids=new ArrayList<String>();
		for (int i = 0; i < id.length; i++) {
			ids.add(id[i]);
		}
		map.put("ids", ids);
		
		/*//获取要删除数据的图片路径,并执行删除图片操作
		List<PageData> paths=newsDetailesService.getListByIds(map);
		for(PageData temp:paths){
			if(Tools.notEmpty(temp.getString("icon_path"))){
				DelAllFile.delFolder(PathUtil.getClasspath() + temp.getString("icon_path"));//删除图片文件
			}
		}*/
		
		//执行删除操作
		newsDetailesService.deleteFile(map);
		newsDetailesService.deletePhoto(map);
		writer.close();
	}
	
	/**
	 * 删除图片路径
	 * @param out
	 */
	@RequestMapping(value="/deleteImgPath")
	public void deleteImgPath(PrintWriter out) {
		logBefore(logger, "删除图片");
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			String PATH = pd.getString("PhotoPath");//图片路径
			DelAllFile.delFolder(PathUtil.getClasspath() + pd.getString("PhotoPath"));//删除图片
			if(PATH != null){
				newsDetailesService.deleteImgPath(pd);//删除数据中图片数据
			}	
			out.write("success");
			out.close();
		}catch(Exception e){
			logger.error(e.toString(), e);
		}
	}
	
	/**
	 * 获取下级
	 * @param FileTypePathID
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/ChildListOption")
	public ModelAndView ChildListOption(String FileTypePathID) throws Exception {
		
		logBefore(logger, "进入添加页面");
		ModelAndView mv=new ModelAndView();
		Map<String, String> param=new HashMap<String, String>();
		param.put("FileTypePathID", FileTypePathID);
		List<PageData> ChildListOption=newsModuleService.getChildList(param);
		mv.addObject("ChildListOption", ChildListOption);
		mv.setViewName("enrollSystem/system/newsDetailes/filetypeChild_Option");
		return mv;
		
	}
	
	/**
	 * 进入修改页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/toEditPhoto")
	public ModelAndView toEditPhoto() throws Exception{
		logBefore(logger, "进入修改页面");
		ModelAndView mv=new ModelAndView();
		PageData pd=new PageData();
		pd=this.getPageData();
		//获取指定对象信息
		pd=newsDetailesService.getDateByPhotoId(pd);
		mv.addObject("pd", pd);
		mv.addObject("msg", "updatePhotos");
		mv.setViewName("enrollSystem/system/newsDetailes/Photo_edit");
		return mv;
	}
	
	
	/**
	 * 对指定对象进行修改
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/updatePhotos")
	public ModelAndView updatePhotos(
			HttpServletRequest request,
			@RequestParam(required=false) MultipartFile file,
			String FileID,
			String PhotoName,
			String PhotoDescription,
			String PhotoURL,
			String PhotoTypeID,
			String PhotoID,
			String PhotoPath
			) throws Exception{
		logBefore(logger, "对指定对象进行修改");
		ModelAndView mv=new ModelAndView();
		PageData pd=new PageData();
		pd=this.getPageData();
//		Subject subject = SecurityUtils.getSubject();
//		Session session = subject.getSession();
//		User user = (User)session.getAttribute(Const.SESSION_USER);
//		pd.put("FileTime", DateUtil.getTime());//文件上传时间
//		pd.put("FileAuthor", user.getNAME());//文件上传者
		//保存信息
		pd.put("FileID", FileID);//文件名称
		if(file!=null && !file.isEmpty()){
			//保存图片
			String filePath=Const.FILEPATHIMG + "newsModule/" + DateUtil.getDays() + "/";
			String fileName=FileUpload.fileUpAndZip(file,PathUtil.getClasspath() + filePath, this.get32UUID(),375,220);
			pd.put("PhotoPath", BaseController.getPath(request)+filePath+fileName);
		}else{
			pd.put("PhotoPath", PhotoPath);
		}
		//添加到数据库
		pd.put("PhotoID", PhotoID);//图片id
		pd.put("PhotoName", PhotoName);//图片名称
		pd.put("FileID", FileID);//文件信息外键ID
		pd.put("PhotoDescription", PhotoDescription);//图片文字说明
		pd.put("PhotoURL", PhotoURL);//图片链接URL
		pd.put("PhotoTypeID", PhotoTypeID);//图片类型外键id
		newsDetailesService.updatePhoto(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
//		mv.setViewName("redirect:/newsDetailes/getlistPage");
		return mv;
	}
}
