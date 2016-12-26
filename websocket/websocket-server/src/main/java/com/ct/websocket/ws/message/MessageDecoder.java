package com.ct.websocket.ws.message;

import javax.websocket.DecodeException;
import javax.websocket.Decoder;
import javax.websocket.EndpointConfig;

import com.ct.websocket.entity.Message;
import com.ct.websocket.utils.JsonUtil;

public class MessageDecoder implements Decoder.Text<Message>{

	public void init(EndpointConfig config) {
		
	}

	public void destroy() {
		
	}

	public Message decode(String s) throws DecodeException {
		return JsonUtil.fromJson(s, Message.class);
	}

	public boolean willDecode(String s) {
		return true;
	}

}
