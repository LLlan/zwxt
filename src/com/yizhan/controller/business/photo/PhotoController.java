package com.yizhan.controller.business.photo;

import java.io.PrintWriter;
import java.net.URLDecoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.yizhan.controller.base.BaseController;
import com.yizhan.entity.Page;
import com.yizhan.entity.system.User;
import com.yizhan.service.business.kucun.kucunService;
import com.yizhan.util.AppUtil;
import com.yizhan.util.DateUtil;
import com.yizhan.util.ObjectExcelView;
import com.yizhan.util.Const;
import com.yizhan.util.OrderNoUtil;
import com.yizhan.util.PageData;
import com.yizhan.util.Tools;
/**
 * 新闻多图管理
 * @author lj
 */
@Controller
@RequestMapping(value="/xinwen")
public class PhotoController extends BaseController {
	@Resource(name="kucunService")
	private kucunService kucunService;
	
	/**
	 * 新闻多图列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/xinwenlistPage")
	public ModelAndView xinwenlistPage(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		logBefore(logger, "新闻多图列表");
		//设置参数，用于模糊查询传递参数
		page.setPd(pd);
		Map<String, Object> map = new HashMap<String, Object>();
		page.getCurrentPage();//当前页
		page.getShowCount();//总数
		map.put("searchName", pd.get("searchName"));
		map.put("pageSize", page.getShowCount());
		PageData coun = kucunService.getCount(map);
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
		List<PageData> kucunList = kucunService.kucunlistPage(map);
		mv.addObject("kucunList", kucunList);
		mv.setViewName("business/kucun/kucun_list");
		return mv;
	}
	
	
	
	/**
	 * 根据商品id获取库存
	 * 功能：
	 * 作者：yangym
	 * 日期：2017-2-6
	 */
	@RequestMapping(value="/getKucunByspmcId")
	@ResponseBody
	public Object getKucunByspmcId() throws Exception{
		PageData pd = new PageData();
		Map map = new HashMap();
		pd = this.getPageData();
		pd.put("spmc_id", pd.get("tagetID"));
		pd=kucunService.getKucunByspmcId(pd);
		map.put("weight", pd.get("weight"));
		map.put("kucun_id", pd.get("kucun_id"));
		map.put("spmc_id", pd.get("spmc_id"));
		return AppUtil.returnObject(pd, map);
	}
	
	
	
	
	
	
	
	
	
	/* ===============================权限================================== */
	public Map<String, String> getHC(){
		Subject currentUser = SecurityUtils.getSubject();  //shiro管理的session
		Session session = currentUser.getSession();
		return (Map<String, String>)session.getAttribute(Const.SESSION_QX);
	}
	/* ===============================权限================================== */
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		 //让name属性无法被接收
        //binder.setDisallowedFields("name");
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
