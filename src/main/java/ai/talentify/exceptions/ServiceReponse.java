/**
 * 
 */
package ai.talentify.exceptions;

import java.util.HashMap;

import ai.talentify.error.messages.GlobalMessages;

/**
 * @author Vaibhav Verma
 *
 */
public class ServiceReponse {
	int responseCode;
	String responseMessage;
	HashMap<String, Object> data = new HashMap<>();
	
	
	
	public ServiceReponse() {
		super();
		responseCode = -1;
		responseMessage = GlobalMessages.METHOD_NOT_IMPLEMENTED;
	}
	public ServiceReponse(int responseCode, String responseMessage) {
		super();
		this.responseCode = responseCode;
		this.responseMessage = responseMessage;
	}
	public int getResponseCode() {
		return responseCode;
	}
	public void setResponseCode(int responseCode) {
		this.responseCode = responseCode;
	}
	public String getResponseMessage() {
		return responseMessage;
	}
	public void setResponseMessage(String responseMessage) {
		this.responseMessage = responseMessage;
	}
	public HashMap<String, Object> getData() {
		return data;
	}
	public void setData(HashMap<String, Object> data) {
		this.data = data;
	}
	
	
}
