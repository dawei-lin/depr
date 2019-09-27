package com.infinova.depr.message;

public class InfinovaError {

	private String field;
	private String defaultMessage;

	public String getDefaultMessage() {
		return defaultMessage;
	}

	public String getField() {
		return field;
	}

	public void setDefaultMessage(String defaultMessage) {
		this.defaultMessage = defaultMessage;
	}

	public void setField(String field) {
		this.field = field;
	}

}
