package com.ct.websocket.springWS.message;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class SpringMessageHandler extends TextWebSocketHandler {
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		if(session.isOpen()){
			session.sendMessage(message);
		}
	}
}
