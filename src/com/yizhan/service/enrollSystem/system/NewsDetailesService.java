package com.yizhan.service.enrollSystem.system;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.yizhan.dao.DaoSupport;
import com.yizhan.entity.Page;
import com.yizhan.util.PageData;

@Service("newsDetailesService")
public class NewsDetailesService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**
	 * 获取列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getlistPage(Map<String, Object> map) throws Exception{
		return (List<PageData>) dao.findForList("newsDetailesMapper.getListPage",map);
	}
	
	/**
	 * 获取列表 —父级
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getlistPage_P(Map<String, Object> map) throws Exception{
		return (List<PageData>) dao.findForList("newsDetailesMapper.getListPage_P",map);
	}
	
	/**
	 * 获取顶级板块
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getAllListParent() throws Exception{
		return (List<PageData>) dao.findForList("newsDetailesMapper.getAllListParents", null);
	}
	
	/**
	 * 分页总数
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public PageData getCount(Map<String, Object> map)throws Exception{
		return (PageData)dao.findForObject("newsDetailesMapper.getCount", map);
	}
	
	
	/**
	 * 分页总数 父级
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public PageData getCount_P(Map<String, Object> map)throws Exception{
		return (PageData)dao.findForObject("newsDetailesMapper.getCount_P", map);
	}
	
	/**
	 * 获取列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getFileTypeListAll(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("newsDetailesMapper.getFileTypeListAll", pd);
	}
	
	/**
	 * 添加文件信息
	 * @param pd
	 * @throws Exception
	 */
	public PageData insertFile(PageData pd) throws Exception{
		return (PageData) dao.findForObject("newsDetailesMapper.insertFile", pd);
	}
	
	/**
	 * 添加图片信息
	 * @param pd
	 * @throws Exception
	 */
	public PageData insertPhoto(PageData pd) throws Exception{
//		dao.save("newsDetailesMapper.insertPhoto", pd);
		return (PageData) dao.findForObject("newsDetailesMapper.insertPhoto", pd);
	}
	
	
	/**
	 * 根据主键ID获取对象信息
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getDateById(PageData pd) throws Exception{
		return (PageData) dao.findForObject("newsDetailesMapper.getDateById", pd);
	}
	
	/**
	 * 根据主键ID获取对象信息
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getDateByPhotoId(PageData pd) throws Exception{
		return (PageData) dao.findForObject("newsDetailesMapper.getDateByPhotoId", pd);
	}
	
	/**
	 * 根据主键ID获取对象信息
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> getDateByPhotoIds(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("newsDetailesMapper.getDateByPhotoIds", pd);
	}
	
	/**
	 * setPhotoID
	 * @param pd
	 * @throws Exception
	 */
	public void setPhotoID(PageData pd) throws Exception{
		dao.update("newsDetailesMapper.setPhotoID", pd);
	}
	
	/**
	 * 修改指定文件信息
	 * @param pd
	 * @throws Exception
	 */
	public void updateFile(PageData pd) throws Exception{
		dao.update("newsDetailesMapper.updateFile", pd);
	}
	
	/**
	 * 修改指定图片信息
	 * @param pd
	 * @throws Exception
	 */
	public void updatePhoto(PageData pd) throws Exception{
		dao.update("newsDetailesMapper.updatePhoto", pd);
	}
	
	/**
	 * 删除文件操作
	 * @param pd
	 * @throws Exception
	 */
	public void deleteFile(Map<String, Object> map) throws Exception{
		dao.delete("newsDetailesMapper.deleteFile", map);
	}
	
	/**
	 * 删除图片操作
	 * @param pd
	 * @throws Exception
	 */
	public void deletePhoto(Map<String, Object> map) throws Exception{
		dao.delete("newsDetailesMapper.deletePhoto", map);
	}
	
	/**
	 * 删除图片操作
	 * @param pd
	 * @throws Exception
	 */
	public void deletePhotos(PageData pd) throws Exception{
		dao.delete("newsDetailesMapper.deletePhotos", pd);
	}
	
	/**
	 * 获取指定id集合的数据
	 * @param pd
	 * @throws Exception
	 */
	/*public List<PageData> getListByIds(Map<String, Object> map) throws Exception{
		return (List<PageData>) dao.findForList("newsDetailesMapper.getListByIds", map);
	}*/
	
	/**
	 * 删除图片路径
	 * @param pd
	 * @throws Exception
	 */
	public void deleteImgPath(PageData pd)throws Exception{
		dao.update("newsDetailesMapper.deleteImgPath", pd);
	}
	
	/**
	 * 获取指定条件下的所有主图信息
	 * @param pd
	 * @throws Exception
	 */
	/*public List<PageData> getListByCondition(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("newsDetailesMapper.getListByCondition", pd);
	}*/
}
