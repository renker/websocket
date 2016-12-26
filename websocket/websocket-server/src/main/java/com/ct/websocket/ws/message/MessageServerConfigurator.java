package com.ct.websocket.ws.message;
import java.util.HashMap;
import java.util.Map;

import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;

public class MessageServerConfigurator extends ServerEndpointConfig.Configurator{
	public Map<String, Object> openSessions = new HashMap<String, Object>();
	
	public MessageServerConfigurator() {
		System.out.println("[-------------------------- 被创建 ----------------------------]");
	}
	
	@Override
	public void modifyHandshake(ServerEndpointConfig sec, HandshakeRequest request, HandshakeResponse response) {
		super.modifyHandshake(sec, request, response);
	}
	
	// 设置跨域策略 
	@Override
	public boolean checkOrigin(String originHeaderValue) {
		// TODO Auto-generated method stub
		return super.checkOrigin(originHeaderValue);
	}
	
	
}
