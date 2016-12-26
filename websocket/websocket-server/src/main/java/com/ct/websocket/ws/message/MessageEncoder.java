package com.ct.websocket.ws.message;

import javax.websocket.EncodeException;
import javax.websocket.Encoder;
import javax.websocket.EndpointConfig;

import com.ct.websocket.entity.Message;
import com.ct.websocket.utils.JsonUtil;

public class MessageEncoder implements Encoder.Text<Message>{

	public void init(EndpointConfig config) {
		
	}

	public void destroy() {
		
	}

	public String encode(Message object) throws EncodeException {
		return JsonUtil.toJson(object);
	}

}
