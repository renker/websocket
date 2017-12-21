package com.ct.websocket.cotroller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("webcam")
public class WebcamController {
	@RequestMapping
	public String index(){
		return "webcam_index";
	}
	
	@RequestMapping("upload")
	@ResponseBody
	public String upload(String pic){
		
		return "success";
	}
}
