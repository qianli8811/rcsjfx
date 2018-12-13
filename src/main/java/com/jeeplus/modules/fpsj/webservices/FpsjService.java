package com.jeeplus.modules.fpsj.webservices;


import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;

@WebService(targetNamespace = "http://webservices.fpsj.modules.jeeplus.com")
public interface FpsjService {
	@WebResult(name = "getJxfp",targetNamespace = "http://webservices.fpsj.modules.jeeplus.com")
	@WebMethod
	public String getJxfp(@WebParam(name = "jxfpStr") String jxfpStr);
	
	@WebResult(name = "getXxfp",targetNamespace = "http://webservices.fpsj.modules.jeeplus.com")
	@WebMethod
	public String getXxfp(@WebParam(name = "xxfpStr") String xxfpStr);
}
