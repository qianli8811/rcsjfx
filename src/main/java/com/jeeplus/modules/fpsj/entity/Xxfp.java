package com.jeeplus.modules.fpsj.entity;

import javax.xml.bind.annotation.XmlRootElement;
import java.util.List;
@XmlRootElement(name="xxfp")
public class Xxfp {
	private XxfpHead head; //发票head
	private List<XxfpItem> item; //发票item
	
	public XxfpHead getHead() {
		return head;
	}
	
	public void setHead(XxfpHead head) {
		this.head = head;
	}
	
	public List<XxfpItem> getItem() {
		return item;
	}
	
	public void setItem(List<XxfpItem> item) {
		this.item = item;
	}
}
