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
public class PartyOrganizationMenu implements Serializable{
	
	/**
	 * 党
	 */
	private String POID;
	
	/**
	 * 党建网所在省份ID号
	 */
	private String POFatherID;
	
	/**
	 * 党建网所在城市名
	 */
	private String POName;
	
	/**
	 * 党建网名
	 */
	private String POPhone;
	
	/**
	 * 党建联盟党建网链接URL
	 */
	private String POAddress;
	
	/**
	 * 党建联盟党建网链接URL
	 */
	private String POType;
	
	
	private PartyOrganizationMenu parentMenu;
	
	private List<PartyOrganizationMenu> subMenu;
	
	private boolean hasMenu = false;
	
	public PartyOrganizationMenu getParentMenu() {
		return parentMenu;
	}
	public void setParentMenu(PartyOrganizationMenu parentMenu) {
		this.parentMenu = parentMenu;
	}
	public List<PartyOrganizationMenu> getSubMenu() {
		return subMenu;
	}
	public void setSubMenu(List<PartyOrganizationMenu> subMenu) {
		this.subMenu = subMenu;
	}
	public boolean isHasMenu() {
		return hasMenu;
	}
	public void setHasMenu(boolean hasMenu) {
		this.hasMenu = hasMenu;
	}
	public String getPOID() {
		return POID;
	}
	public void setPOID(String pOID) {
		POID = pOID;
	}
	public String getPOFatherID() {
		return POFatherID;
	}
	public void setPOFatherID(String pOFatherID) {
		POFatherID = pOFatherID;
	}
	public String getPOName() {
		return POName;
	}
	public void setPOName(String pOName) {
		POName = pOName;
	}
	public String getPOPhone() {
		return POPhone;
	}
	public void setPOPhone(String pOPhone) {
		POPhone = pOPhone;
	}
	public String getPOAddress() {
		return POAddress;
	}
	public void setPOAddress(String pOAddress) {
		POAddress = pOAddress;
	}
	public String getPOType() {
		return POType;
	}
	public void setPOType(String pOType) {
		POType = pOType;
	}
}
