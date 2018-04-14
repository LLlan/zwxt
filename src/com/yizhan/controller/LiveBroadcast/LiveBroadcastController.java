package com.yizhan.controller.LiveBroadcast;

import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.disk.DiskFileItem;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.yizhan.controller.base.BaseController;
import com.yizhan.entity.Page;
import com.yizhan.service.LiveBroadcast.LiveBroadcastService;
import com.yizhan.test.VideoDuration;
import com.yizhan.util.Const;
import com.yizhan.util.DateUtil;
import com.yizhan.util.FileUpload;
import com.yizhan.util.MathUtil;
import com.yizhan.util.PageData;
import com.yizhan.util.PathUtil;

/**
 * 直播课程或视频会议管理
 * @Title:  LiveBroadcastController.java 
 * @author lj
 * @date 2017年11月24日 下午9:37:37
 */
@Controller
@RequestMapping(value="/LiveBroadcastManage")
public class LiveBroadcastController extends BaseController {
	@Resource(name="liveBroadcastService")
	private LiveBroadcastService liveBroadcastService;
	
	/**
	 * 直播视频会议分页列表
	 * @author lj
	 * @param page
	 * @return
	 * @throws Exception
	 * @时间 2017年11月18日 下午4:49:55
	 */
	@RequestMapping(value = "/LiveBroadcastListPage")
	public ModelAndView LiveBroadcastListPage(Page page) throws Exception {
		ModelAndView mv = new ModelAndView();
		logBefore(logger, "直播视频会议分页列表");
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			page.setPd(pd);
			List<PageData> LiveBroadcastList = liveBroadcastService.LiveBroadcastListPage(page);
			mv.addObject("LiveBroadcastList", LiveBroadcastList);
			mv.addObject("pd", pd);
			mv.setViewName("LiveBroadcast/LiveBroadcast_list");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 进入课程直播录播添加页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/toAdd")
	public ModelAndView toAdd() throws Exception{
		logBefore(logger, "进入课程直播录播添加页面");
		ModelAndView mv=new ModelAndView();
		PageData pd=new PageData();
		pd=this.getPageData();
		//List<PageData> CurriculumSeriesALlList = liveBroadcastService.CurriculumSeriesALlList(pd);
		//mv.addObject("CurriculumSeriesALlList", CurriculumSeriesALlList);
		mv.addObject("msg", "insert");
		mv.setViewName("LiveBroadcast/LiveBroadcast_add");
		return mv;
	}
	
	/**
	 * 课程直播录播添加信息
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/insert")
	public ModelAndView insert(HttpServletRequest request,
//			@RequestParam(required=false)MultipartFile files,
//			@RequestParam(required=false)MultipartFile file,
			@RequestParam(value = "files", required = false) MultipartFile files,
			@RequestParam(value = "file", required = false) MultipartFile file,
			String LiveBroadcastName,
			int LiveBroadcastType,
			String LiveBroadcastContent,
			String LiveBroadcastBeginTime,
			String LiveBroadcastEndTime,
			String LiveBroadcastLength,
			String Hot
			) throws Exception{
		logBefore(logger, "执行课程直播录播添加信息");
		ModelAndView mv=new ModelAndView();
		PageData pd=new PageData();
		pd=this.getPageData();
		//保存信息
		pd.put("LiveBroadcastName", LiveBroadcastName);//标题
		pd.put("LiveBroadcastContent", LiveBroadcastContent);//介绍内容
		pd.put("LiveBroadcastTime", DateUtil.getTime());//创建时间
		//保存视频 
		CommonsMultipartFile cf= (CommonsMultipartFile)file; 
        DiskFileItem fi = (DiskFileItem)cf.getFileItem(); 
        File f = fi.getStoreLocation();
		VideoDuration videoDuration = new VideoDuration();      
		String LiveBroadcastLengths = videoDuration.getVideoDuration(f);
		System.out.println("计算上传视频的时长："+LiveBroadcastLengths);
		pd.put("LiveBroadcastLength", LiveBroadcastLengths);
		pd.put("LiveBroadcastType", LiveBroadcastType);//0直播 1录播
		if (LiveBroadcastType == 0) {
			pd.put("LiveBroadcastBeginTime", LiveBroadcastBeginTime);//直播开始时间
			pd.put("LiveBroadcastEndTime", LiveBroadcastEndTime);//直播结束时间
		}
		if (null != files && !files.isEmpty()){
			//保存图片
			String filePath=Const.FILEPATHIMG + "LiveBroadcastPhotoUrl/" + DateUtil.getDays() + "/";
			String fileName=FileUpload.fileUpAndZip(files,PathUtil.getClasspath() + filePath, this.get32UUID(),375,220);
			pd.put("LiveBroadcastPhotoUrl", BaseController.getPath(request)+filePath+fileName);//图片存储路径
		}
		if (null != file && !file.isEmpty()){
			//保存视频
			String filePath=Const.FILEPATHIMG + "LiveBroadcastVideoUrl/" + DateUtil.getDays() + "/";
			int K=1;
			String fileName=FileUpload.fileUp(file, PathUtil.getClasspath() + filePath, DateUtil.getDays()+MathUtil.getRandom(K));
			pd.put("LiveBroadcastVideoUrl", BaseController.getPath(request)+filePath+fileName);//存储视频路径
		}
		pd.put("Hot", Hot);//是否热度
		PageData CurriculumSeriesIDS =liveBroadcastService.saveliveBroadcast(pd);//执行上传保存图片信息
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 进入课程直播录播编辑页面
	 * @author lj
	 * @return
	 * @throws Exception
	 * @时间 2017年11月23日 上午11:49:01
	 */
	@RequestMapping(value="/toEdit")
	public ModelAndView toEdit() throws Exception{
		logBefore(logger, "进入直播录播编辑页面");
		ModelAndView mv=new ModelAndView();
		PageData pd=new PageData();
		pd=this.getPageData();
		pd = liveBroadcastService.getDataByIDLiveBroadcast(pd);//获取一条信息 
//		List<PageData> CurriculumSeriesALlList = studyService.CurriculumSeriesALlList(pd);
//		mv.addObject("CurriculumSeriesALlList", CurriculumSeriesALlList);
		mv.addObject("msg", "update");
		mv.addObject("pd", pd);
		mv.setViewName("LiveBroadcast/LiveBroadcast_edit");
		return mv;
	}
	
	/**
	 * 课程系统编辑信息
	 * @author lj
	 * @param request
	 * @param file
	 * @param CurriculumSeriesID
	 * @param CurriculumSeriesName
	 * @param CurriculumSeriesPosition
	 * @return
	 * @throws Exception
	 * @时间 2017年11月23日 上午11:47:44
	 */
	@RequestMapping(value="/update")
	public ModelAndView update(HttpServletRequest request,
			@RequestParam(required=false) MultipartFile files,
			@RequestParam(required=false) MultipartFile file,
			String LiveBroadcastID,
			String LiveBroadcastName,
			String LiveBroadcastPhotoUrl,
			int LiveBroadcastTypes,
			String LiveBroadcastContent,
			String LiveBroadcastVideoUrl,
			String LiveBroadcastBeginTime,
			String LiveBroadcastEndTime,
			String LiveBroadcastLength,
			String LiveBroadcastTime,
			String Hot
			) throws Exception{
		logBefore(logger, "执行课程系统添加信息");
		ModelAndView mv=new ModelAndView();
		PageData pd=new PageData();
		pd=this.getPageData();
		//保存信息
		//保存信息
		pd.put("LiveBroadcastID", LiveBroadcastID);
		pd.put("LiveBroadcastName", LiveBroadcastName);//标题
		pd.put("LiveBroadcastContent", LiveBroadcastContent);//介绍内容
		pd.put("LiveBroadcastTime", DateUtil.getTime());//创建时间
		//保存视频 
		pd.put("LiveBroadcastType", LiveBroadcastTypes);//0直播 1录播
		if (LiveBroadcastTypes == 0) {
			pd.put("LiveBroadcastBeginTime", LiveBroadcastBeginTime);//直播开始时间
			pd.put("LiveBroadcastEndTime", LiveBroadcastEndTime);//直播结束时间
		}
		if (null != files && !files.isEmpty()){
			//保存图片
			String filePath=Const.FILEPATHIMG + "LiveBroadcastPhotoUrl/" + DateUtil.getDays() + "/";
			String fileName=FileUpload.fileUpAndZip(files,PathUtil.getClasspath() + filePath, this.get32UUID(),375,220);
			pd.put("LiveBroadcastPhotoUrl", BaseController.getPath(request)+filePath+fileName);//图片存储路径
		}else {
			pd.put("LiveBroadcastPhotoUrl", LiveBroadcastPhotoUrl);
		}
		if (null != file && !file.isEmpty()){
			CommonsMultipartFile cf= (CommonsMultipartFile)file; 
	        DiskFileItem fi = (DiskFileItem)cf.getFileItem(); 
	        File f = fi.getStoreLocation();
			VideoDuration videoDuration = new VideoDuration();      
			String LiveBroadcastLengths = videoDuration.getVideoDuration(f);
			System.out.println("计算上传视频的时长："+LiveBroadcastLengths);
			pd.put("LiveBroadcastLength", LiveBroadcastLengths);
			//保存视频
			String filePath=Const.FILEPATHIMG + "LiveBroadcastVideoUrl/" + DateUtil.getDays() + "/";
			int K=1;
			String fileName=FileUpload.fileUp(file, PathUtil.getClasspath() + filePath, DateUtil.getDays()+MathUtil.getRandom(K));
			pd.put("LiveBroadcastVideoUrl", BaseController.getPath(request)+filePath+fileName);//存储视频路径
		}else {
			pd.put("LiveBroadcastVideoUrl", LiveBroadcastVideoUrl);
			pd.put("LiveBroadcastLength", LiveBroadcastLength);
		}
		pd.put("Hot", Hot);//是否热度
		liveBroadcastService.updateLiveBroadcast(pd);//执行编辑信息
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 根据ID删除指定对象的信息
	 * @author lj
	 * @param writer
	 * @throws Exception
	 * @时间 2017年11月23日 上午11:47:37
	 */
	@RequestMapping(value="/deleteCurriculumSeries")
	public void deleteCurriculumSeries(PrintWriter writer) throws Exception{
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
		liveBroadcastService.deleteLiveBroadcast(map);
		writer.close();
	}
	
	/**
	 * 查看文章详情
	 * @author lj
	 * @return
	 * @throws Exception
	 * @时间 2017年11月19日 上午10:12:26
	 */
	@RequestMapping(value="/kanjianjie")
	public ModelAndView kanjianjie() throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = liveBroadcastService.getDataByIDLiveBroadcast(pd);//获取一条信息 
		mv.addObject("pd",pd);
		mv.setViewName("LiveBroadcast/chakan");
		return mv;
	}
	
	//*******************观看直播统计列表***********************//
	
	/**
	 * 观看直播视频会议分页列表
	 * @author lj
	 * @param page
	 * @return
	 * @throws Exception
	 * @时间 2017年11月18日 下午4:49:55
	 */
	@RequestMapping(value="/LBLearnListPage")
	public ModelAndView LBLearnListPage(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		logBefore(logger, "观看直播视频会议分页列表");
		PageData pd=new PageData();
		pd=this.getPageData();
		page.setPd(pd);
		Map<String, Object> map = new HashMap<String, Object>();
		page.getCurrentPage();//当前页
		page.getShowCount();//总数
		map.put("LiveBroadcastID", pd.get("LiveBroadcastID"));
		map.put("searchName", pd.get("searchName"));
		map.put("pageSize", page.getShowCount());
		PageData coun = liveBroadcastService.getCountLBLearn(map);
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
		List<PageData> LBLearnList = liveBroadcastService.LBLearnListPage(map);
		mv.addObject("LBLearnList", LBLearnList);
		mv.addObject("pd", pd);
		mv.setViewName("LBLearn/LBLearn_list");
		return mv;
	}
	
}
