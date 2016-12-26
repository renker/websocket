package com.ct.websocket.cotroller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("message")
public class MessageController {
	@RequestMapping("index")
	public String index(){
		return "message_index";
	}
	
	@RequestMapping("sockJs")
	public String sockJs(){
		return "message_sockJs";
	}
	
	@RequestMapping("springIndex")
	public String springIndex(){
		return "message_springIndex";
	}
	
	@RequestMapping("springSockJs")
	public String springSockJs(){
		return "message_springSockJs";
	}
}
