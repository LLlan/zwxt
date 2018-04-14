package com.yizhan.entity.system;

import java.io.Serializable;
import java.util.List;
/**
 * 
* 类名称：Menu.java
* 类描述： 
* @author FH
* 作者单位： 
* 联系方式：
* 创建时间：2014年6月28日
* @version 1.0
 */
public class TwoMenu implements Serializable{
	
	/**
	 * 党建网所在城市ID号
	 */
	private String PBLCityID;
	
	/**
	 * 党建网所在省份ID号
	 */
	private String PBLProvinceID;
	
	/**
	 * 党建网所在城市名
	 */
	private String PBLCityName;
	
	/**
	 * 党建网名
	 */
	private String PBANetName;
	
	/**
	 * 党建联盟党建网链接URL
	 */
	private String PBANetURL;
	
	
	private TwoMenu parentMenu;
	
	private List<TwoMenu> subMenu;
	
	private boolean hasMenu = false;
	
	public TwoMenu getParentMenu() {
		return parentMenu;
	}
	public void setParentMenu(TwoMenu parentMenu) {
		this.parentMenu = parentMenu;
	}
	public List<TwoMenu> getSubMenu() {
		return subMenu;
	}
	public void setSubMenu(List<TwoMenu> subMenu) {
		this.subMenu = subMenu;
	}
	public boolean isHasMenu() {
		return hasMenu;
	}
	public void setHasMenu(boolean hasMenu) {
		this.hasMenu = hasMenu;
	}
	public String getPBLCityID() {
		return PBLCityID;
	}
	public void setPBLCityID(String pBLCityID) {
		PBLCityID = pBLCityID;
	}
	public String getPBLProvinceID() {
		return PBLProvinceID;
	}
	public void setPBLProvinceID(String pBLProvinceID) {
		PBLProvinceID = pBLProvinceID;
	}
	public String getPBLCityName() {
		return PBLCityName;
	}
	public void setPBLCityName(String pBLCityName) {
		PBLCityName = pBLCityName;
	}
	public String getPBANetName() {
		return PBANetName;
	}
	public void setPBANetName(String pBANetName) {
		PBANetName = pBANetName;
	}
	public String getPBANetURL() {
		return PBANetURL;
	}
	public void setPBANetURL(String pBANetURL) {
		PBANetURL = pBANetURL;
	}
}
