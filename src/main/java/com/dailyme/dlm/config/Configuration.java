package com.dailyme.dlm.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;


@PropertySource("classpath:/application.properties")
public class Configuration {

	@Value("${name}")
	private String key;

	private String url;
	
	
	public Configuration(String key, String url) {
		this.key = key;
		this.url = url;
	}
	
	
	public String getKey() {
		return key;
	}
	
	public void setKey(String key) {
		this.key = key;
	}
	
	public String getUrl() {
		return url;
	}
	
	public void setUrl(String url) {
		this.url = url;
	}
	
}
