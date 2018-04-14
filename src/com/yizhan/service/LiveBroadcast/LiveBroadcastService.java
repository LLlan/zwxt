package com.yizhan.service.LiveBroadcast;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.yizhan.dao.DaoSupport;
import com.yizhan.entity.Page;
import com.yizhan.util.PageData;

/**
 * 互动分享学习
 * @Title:  StudyService.java 
 * @author lj
 * @date 2017年11月18日 下午4:23:41
 */
@Service("liveBroadcastService")
public class LiveBroadcastService {
	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**
	 * 直播视频会议分页列表
	 * @author lj
	 * @param map
	 * @return
	 * @throws Exception
	 * @时间 2017年11月18日 下午4:27:13
	 */
	public List<PageData> LiveBroadcastListPage(Page page)throws Exception{
		return (List<PageData>)dao.findForList("liveBroadcastMapper.LiveBroadcastlistPage", page);
	}
	
	/**
	 * 分页总数
	 * @author lj
	 * @param map
	 * @return
	 * @throws Exception
	 * @时间 2017年11月18日 下午4:49:27
	 */
	public PageData getCountLiveBroadcast(Map<String, Object> map)throws Exception{
		return (PageData)dao.findForObject("liveBroadcastMapper.getCountLiveBroadcast", map);
	}
	
	/**
	 * 添加信息
	 * @author lj
	 * @param pd
	 * @return
	 * @throws Exception
	 * @时间 2017年11月23日 上午11:37:05
	 */
	public PageData saveliveBroadcast(PageData pd) throws Exception{
		return (PageData) dao.findForObject("liveBroadcastMapper.saveliveBroadcast", pd);
	}
	
	
	/**
	 * 根据主键ID获取对象信息
	 * @author lj
	 * @param pd
	 * @return
	 * @throws Exception
	 * @时间 2017年11月23日 上午11:39:06
	 */
	public PageData getDataByIDLiveBroadcast(PageData pd) throws Exception{
		return (PageData) dao.findForObject("liveBroadcastMapper.getDataByIDLiveBroadcast", pd);
	}
	
	/**
	 * 执行修改
	 * @author lj
	 * @param pd
	 * @throws Exception
	 * @时间 2017年11月23日 上午11:39:32
	 */
	public void updateLiveBroadcast(PageData pd) throws Exception{
		dao.update("liveBroadcastMapper.updateLiveBroadcast", pd);
	}
	
	/**
	 * 删除操作
	 * @param pd
	 * @throws Exception
	 */
	public void deleteLiveBroadcast(Map<String, Object> map) throws Exception{
		dao.delete("liveBroadcastMapper.deleteLiveBroadcast", map);
	}
	
	//****************观看直播部分*************************//
	
	/**
	 * 观看分页列表
	 * @author lj
	 * @param map
	 * @return
	 * @throws Exception
	 * @时间 2017年11月18日 下午4:27:13
	 */
	public List<PageData> LBLearnListPage(Map<String, Object> map)throws Exception{
		return (List<PageData>)dao.findForList("liveBroadcastMapper.LBLearnListPage", map);
	}
	
	/**
	 * 观看分页总数
	 * @author lj
	 * @param map
	 * @return
	 * @throws Exception
	 * @时间 2017年11月18日 下午4:49:27
	 */
	public PageData getCountLBLearn(Map<String, Object> map)throws Exception{
		return (PageData)dao.findForObject("liveBroadcastMapper.getCountLBLearn", map);
	}
	
}
