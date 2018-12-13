package com.jeeplus.modules.fpsj.webservices;


import com.jeeplus.common.mapper.JaxbMapper;
import com.jeeplus.common.utils.StringUtils;
import com.jeeplus.modules.fpsj.entity.*;
import com.jeeplus.modules.fpsj.service.JxfpHeadService;
import com.jeeplus.modules.fpsj.service.JxfpItemService;
import com.jeeplus.modules.fpsj.service.XxfpHeadService;
import com.jeeplus.modules.fpsj.service.XxfpItemService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.xml.ws.BindingType;
import javax.xml.ws.soap.SOAPBinding;
import java.util.List;

@BindingType(value = SOAPBinding.SOAP11HTTP_BINDING)
@WebService(endpointInterface = "com.jeeplus.modules.fpsj.webservices.FpsjService")
public class FpsjServiceImpl implements FpsjService {
	
	private Logger logger = LoggerFactory.getLogger(FpsjServiceImpl.class);
	
	@Autowired
	private JxfpHeadService jxfpHeadService;
	@Autowired
	private JxfpItemService jxfpItemService;
	@Autowired
	private XxfpHeadService xxfpHeadService;
	@Autowired
	private XxfpItemService xxfpItemService;
	
	@WebResult(name = "getJxfp",targetNamespace = "http://webservices.fpsj.modules.jeeplus.com")
	@WebMethod
	public String getJxfp(@WebParam(name = "jxfpStr") String jxfpStr){
		logger.info("接收到的进项发票数据为："+ jxfpStr);
		
		try{
			
			Jxfp jxfp2 = JaxbMapper.fromXml(jxfpStr, Jxfp.class);
			
			JxfpHead jxfpHead = jxfp2.getHead();
			
			JxfpHead jxfpHead1 = jxfpHeadService.get(jxfpHead);
			if(null != jxfpHead1){
				//更新
				jxfpHead.setId(jxfpHead1.getId());
				
			}
			//添加
			jxfpHeadService.save(jxfpHead);
			
			List<JxfpItem> item = jxfp2.getItem();
			if(item!=null &&item.size()>0){
				for (JxfpItem jxfpItem : item){
					
					jxfpItem.setJxfpHead(jxfpHead);
					JxfpItem jxfpItem1 = jxfpItemService.get(jxfpItem);
					if(null != jxfpItem1 && StringUtils.isNotBlank(jxfpItem1.getId())){
						//更新
						jxfpItem.setId(jxfpItem1.getId());
					}
					jxfpItemService.save(jxfpItem);
				}
			}
			
			String result = "  <return>\n" +
					"     <retCode>0</retCode>\n" +
					"     <retMsg>接收成功</retMsg>\n" +
					"  </return>";
			
			return result;
		}catch (Exception e){
			String result = "  <return>\n" +
					"     <retCode>1</retCode>\n" +
					"     <retMsg>接收失败</retMsg>\n" +
					"  </return>";
			e.printStackTrace();
			return result;
		}
		
		
		
	}
	@WebResult(name = "getXxfp",targetNamespace = "http://webservices.fpsj.modules.jeeplus.com")
	@WebMethod
	public String getXxfp(@WebParam(name = "xxfpStr") String xxfpStr){
		
		logger.info("接收到的销项发票数据为："+ xxfpStr);
		try{
			Xxfp sxfp2 = JaxbMapper.fromXml(xxfpStr, Xxfp.class);
			XxfpHead head = sxfp2.getHead();
			
			
			XxfpHead xxfpHead1 = xxfpHeadService.get(head);
			if(null != xxfpHead1){
				//更新
				head.setId(xxfpHead1.getId());
			}
			//添加
			xxfpHeadService.save(head);
			
			List<XxfpItem> item = sxfp2.getItem();
			if(null != item && item.size()>0){
				for (XxfpItem xxfpItem : item){
					xxfpItem.setXxfpHead(head);
					
					XxfpItem xxfpItem1 = xxfpItemService.get(xxfpItem);
					if(null != xxfpItem1 && StringUtils.isNotBlank(xxfpItem1.getId())){
						//更新
						xxfpItem.setId(xxfpItem1.getId());
					}
					//添加
					xxfpItemService.save(xxfpItem);
				}
			}
			
			
			String result = "  <return>\n" +
					"     <retCode>0</retCode>\n" +
					"     <retMsg>接收成功</retMsg>\n" +
					"  </return>";
			
			return result;
		
		}catch (Exception e){
			e.printStackTrace();
			
			String result = "  <return>\n" +
					"     <retCode>1</retCode>\n" +
					"     <retMsg>接收失败</retMsg>\n" +
					"  </return>";
			e.printStackTrace();
			return result;
		}
		
	}
	
}
