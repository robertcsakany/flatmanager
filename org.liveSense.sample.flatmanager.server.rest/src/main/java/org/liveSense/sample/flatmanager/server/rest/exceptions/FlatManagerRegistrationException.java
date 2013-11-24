package org.liveSense.sample.flatmanager.server.rest.exceptions;

import java.util.List;

public class FlatManagerRegistrationException extends Exception {

	List<String> errors;
	
	public FlatManagerRegistrationException(List<String> errors) {
		this.errors = errors;
	}
	
	public List<String> getErrors() {
		return errors;
	}
}
