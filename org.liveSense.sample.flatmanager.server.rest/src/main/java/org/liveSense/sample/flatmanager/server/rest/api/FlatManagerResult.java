package org.liveSense.sample.flatmanager.server.rest.api;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;


@XmlRootElement
public class FlatManagerResult {

	private boolean isOk = true;
	private List<FlatManagerError> errors = new ArrayList<FlatManagerError>();
	private String resultString;
	
	public FlatManagerResult(List<FlatManagerError> errors) {
		setErrors(errors);
	}

	public FlatManagerResult() {
		setErrors(null);
	}
	
	@XmlElement
	@XmlElementWrapper(name = "errors") 
	public List<FlatManagerError> getErrors() {
		return errors;
	}

	public void setErrors(List<FlatManagerError> errors) {
		if (errors != null && errors.size()>0) {
			this.errors = errors;
			this.isOk = false;
		} else {
			this.errors = null;
			this.isOk = true;
		}
	}

	@XmlElement(name="ok", defaultValue="true")
	public boolean isOk() {
		return isOk;
	}

	public void setOk(boolean isOk) {
		this.isOk = isOk;
	}

	public String getResultString() {
		return resultString;
	}

	public void setResultString(String resultString) {
		this.resultString = resultString;
	} 
}
