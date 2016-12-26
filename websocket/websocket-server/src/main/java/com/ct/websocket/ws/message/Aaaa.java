package com.ct.websocket.ws.message;

import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

public class Aaaa implements WebSocketConfigurer{

	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(null, "").withSockJS();
	}

}
