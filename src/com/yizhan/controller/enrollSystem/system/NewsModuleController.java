package com.yizhan.controller.enrollSystem.system;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.yizhan.controller.base.BaseController;
import com.yizhan.entity.Page;
import com.yizhan.service.enrollSystem.system.NewsDetailesService;
import com.yizhan.service.enrollSystem.system.NewsModuleService;
import com.yizhan.util.Const;
import com.yizhan.util.DateUtil;
import com.yizhan.util.DelAllFile;
import com.yizhan.util.FileUpload;
import com.yizhan.util.PageData;
import com.yizhan.util.PathUtil;
import com.yizhan.util.StringUtil;
import com.yizhan.util.Tools;

/**
 * 板块管理
 * @author lj
 */
@Controller
@RequestMapping(value="/newsModule")
public class NewsModuleController extends BaseController{

	@Resource(name="newsModuleService")
	private NewsModuleService newsModuleService;
	

	@Resource(name="newsDetailesService")
	private NewsDetailesService newsDetailesService;
	
	/**
	 * 获取列表
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/getlistPage")
	public ModelAndView getlistPage(Page page) throws Exception{
		logBefore(logger, "获取列表");
		ModelAndView mv=new ModelAndView();
		PageData pd=new PageData();
		pd=this.getPageData();
		page.setPd(pd);
		Map<String, Object> map = new HashMap<String, Object>();
		page.getCurrentPage();//当前页
		page.getShowCount();//总数
		map.put("searchName", pd.get("searchName"));
		map.put("pageSize", page.getShowCount());
		PageData coun = newsDetailesService.getCount_P(map);
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
		
		List<PageData> list=newsModuleService.getlistPage(map);
		
		mv.addObject("pd", pd);
		mv.addObject("list", list);
		mv.setViewName("enrollSystem/system/newsModule/newsModule_list");
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
		List<PageData> fileTypeList=newsModuleService.getAllListParent();
		mv.addObject("msg", "insert");
		mv.addObject("fileTypeList", fileTypeList);
		mv.setViewName("enrollSystem/system/newsModule/newsModule_edit");
		return mv;
	}
	
	/**
	 * 展开下级
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/fileTypeChild")
	public ModelAndView fileTypeChild(String FileTypePathID) throws Exception{
		logBefore(logger, "进入添加页面");
		ModelAndView mv=new ModelAndView();
		Map<String, String> param=new HashMap<String, String>();
		param.put("FileTypePathID", FileTypePathID);
		List<PageData> childList=newsModuleService.getChildList(param);
		mv.addObject("childList", childList);
		mv.setViewName("enrollSystem/system/newsModule/fileTypeChild");
		return mv;
	}
	
	
	
	
	
	/**
	 * 添加信息
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/insert")
	public ModelAndView insert(
			@RequestParam(required=false) MultipartFile file,
			String FileTypePathID,
			String FileTypeName,
			String FileTypeHot
			) throws Exception{
		logBefore(logger, "添加信息");
		ModelAndView mv=new ModelAndView();
		PageData pd=new PageData();
		//保存信息
		pd.put("FileTypePathID", FileTypePathID);
		pd.put("FileTypeName", FileTypeName);
		pd.put("FileTypeHot", FileTypeHot);
		newsModuleService.SetFileTypeHot(pd);//先原来的热度设置成不是热度
		newsModuleService.insertFileType(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	/**
	 * 进入修改页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/editBtn")
	public ModelAndView editBtn(String FileTypeID) throws Exception{
		logBefore(logger, "进入修改页面");
		ModelAndView mv=new ModelAndView();
		PageData pd=new PageData();
		pd=this.getPageData();
		pd.put("FileTypeID", FileTypeID);
 	    pd=newsModuleService.getDateById(pd);
 	    
 	   //判断是否存在父级
 	   PageData pd_parent=new PageData();
 	   
 	   int FileTypePathID=(Integer) pd.get("FileTypePathID");
 	   
 	   //存在父类
 	   if(FileTypePathID!=0) {
 		  pd_parent.put("FileTypeID", FileTypePathID);
 		  pd_parent=newsModuleService.getDateById(pd_parent);
 		 mv.addObject("fileType_parent",pd_parent );
 	   }
		mv.addObject("fileType",pd );
		mv.setViewName("enrollSystem/system/newsModule/newsModule_editBtn");
		return mv;
	}
	/**
	 * 对指定对象进行修改
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/update")
	public ModelAndView update(
			String FileTypeID,
			String FileTypeName,
			String FileTypePathID,
			Boolean FileTypeHot
			) throws Exception{
		logBefore(logger, "对指定对象进行修改");
		ModelAndView mv=new ModelAndView();
		PageData pd=new PageData();
		
		//更新信息
		pd.put("FileTypeID", FileTypeID);
		pd.put("FileTypeName", FileTypeName);
		pd.put("FileTypePathID", FileTypePathID);
		pd.put("FileTypeHot", FileTypeHot);
		
		newsModuleService.update(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	/**
	 * 根据ID删除指定对象的信息
	 * @param writer
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter writer) throws Exception{
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
		//执行删除操作
		newsModuleService.delete(map);
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
			String PATH = pd.getString("icon_path");//图片路径
			DelAllFile.delFolder(PathUtil.getClasspath() + pd.getString("icon_path"));//删除图片
			if(PATH != null){
				newsModuleService.deleteImgPath(pd);//删除数据中图片数据
			}	
			out.write("success");
			out.close();
		}catch(Exception e){
			logger.error(e.toString(), e);
		}
	}
	
	
	/**
	 * 根据ID删除指定对象的信息
	 * @param writer
	 * @throws Exception
	 */
	@RequestMapping(value="/delBtn")
	@ResponseBody
	public String delBtn(String  FileTypeID) throws Exception{
		logBefore(logger, "---根据ID删除指定对象的信息--");
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("FileTypeID", FileTypeID);
		//执行删除操作
		newsModuleService.delBtn(map);
		
		Map<String,Object> result=new HashMap<String, Object>();
		
		result.put("message", "删除成功");

		return JSON.toJSONString(result);
		
	}
	
	
}
