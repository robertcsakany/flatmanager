    package org.liveSense.sample.flatmanager.server.rest.api;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;


@XmlRootElement
public class FlatManagerError {

	private String field = null;
	private String message = null;
	
	public FlatManagerError() {
	}

	public FlatManagerError(String message) {
		this.message = message;
	}
	
	public FlatManagerError(String field, String message) {
		this.field = field;
		this.message = message;
	}
	
	
	@XmlElement(name="field")
	public String getField() {
		return field;
	}
	public void setField(String field) {
		this.field = field;
	}

	@XmlElement(name="message")
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	
	
}
