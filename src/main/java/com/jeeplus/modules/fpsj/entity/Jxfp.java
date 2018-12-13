package com.jeeplus.modules.fpsj.entity;

import javax.xml.bind.annotation.XmlRootElement;
import java.util.List;
@XmlRootElement(name="jxfp")
public class Jxfp {
	private JxfpHead head; //发票head
	private List<JxfpItem> item; //发票item
	
	public JxfpHead getHead() {
		return head;
	}
	
	public void setHead(JxfpHead head) {
		this.head = head;
	}
	
	public List<JxfpItem> getItem() {
		return item;
	}
	
	public void setItem(List<JxfpItem> item) {
		this.item = item;
	}
}
