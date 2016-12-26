package com.ct.websocket.entity;

import java.io.Serializable;

public class Message implements Serializable{
	private static final long serialVersionUID = -3778493915773646797L;
	
	private String subject;
	private String message;
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
}
