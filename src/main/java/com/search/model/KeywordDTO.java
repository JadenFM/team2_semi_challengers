package com.search.model;

public class KeywordDTO {
	String keyword_category_code_fk;
	String keyword_name;
	int keyword_count;
	String keyword_code;
	
	public String getKeyword_category_code_fk() {
		return keyword_category_code_fk;
	}
	public void setKeyword_category_code_fk(String keyword_category_code_fk) {
		this.keyword_category_code_fk = keyword_category_code_fk;
	}
	public String getKeyword_name() {
		return keyword_name;
	}
	public void setKeyword_name(String keyword_name) {
		this.keyword_name = keyword_name;
	}
	public int getKeyword_count() {
		return keyword_count;
	}
	public void setKeyword_count(int keyword_count) {
		this.keyword_count = keyword_count;
	}
	public String getKeyword_code() {
		return keyword_code;
	}
	public void setKeyword_code(String keyword_code) {
		this.keyword_code = keyword_code;
	}
}
