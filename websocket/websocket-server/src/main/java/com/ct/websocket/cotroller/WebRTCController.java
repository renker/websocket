package com.ct.websocket.cotroller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("webrtc")
public class WebRTCController {
	private static String sdp;
	private static boolean first = false;
	@RequestMapping("index")
	public String index(){
		return "webrtc_index";
	}
	
	@RequestMapping("sdp")
	@ResponseBody
	public String sdp(String sdp){
		if(first){
			return sdp;
		}else{
			return "--";
		}
	}
}
