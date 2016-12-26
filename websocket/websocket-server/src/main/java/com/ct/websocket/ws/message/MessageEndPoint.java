package com.ct.websocket.ws.message;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.websocket.EncodeException;
import javax.websocket.EndpointConfig;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import javax.websocket.server.ServerEndpointConfig;

import com.ct.websocket.entity.Message;

@ServerEndpoint(value="/message",decoders={MessageDecoder.class},encoders={MessageEncoder.class},configurator=MessageServerConfigurator.class,subprotocols={"websocket"})
public class MessageEndPoint {
	
	private ServerEndpointConfig sec;
	private MessageServerConfigurator msc;
	private static String OPEN_SESSIONS_KEY = "OPEN_SESSIONS_KEY";
	private Session session;
	
	@OnOpen
	public void onOpen(EndpointConfig config,Session session){
		this.sec = (ServerEndpointConfig) config;
		this.msc = (MessageServerConfigurator) sec.getConfigurator();
		this.session = session;
		List<Session> openSessions = (List<Session>) msc.openSessions.get(OPEN_SESSIONS_KEY);
		if(openSessions == null){
			openSessions = new ArrayList<Session>();
		}
		openSessions.add(session);
		
		System.out.println("Session 超时时间："+session.getMaxIdleTimeout());
		
		msc.openSessions.put(OPEN_SESSIONS_KEY, openSessions);
	}
	
	@OnMessage
	public void onMessage(Message msg,Session session) throws IOException, EncodeException{
		// session.getBasicRemote().sendText(JsonUtil.toJson(msg));
//		session.getBasicRemote().sendObject(msg);
//		session.getOpenSessions();
		System.out.println("共有用户："+session.getOpenSessions().size()+msg.getSubject()+"-"+session.getId());
		List<Session> openSessions = (List<Session>) msc.openSessions.get(OPEN_SESSIONS_KEY);
		
		 session.getOpenSessions();
		for (Session item:openSessions) {
			if(item.isOpen()){
				item.getBasicRemote().sendObject(msg);
			}
		}
	}
	
}
