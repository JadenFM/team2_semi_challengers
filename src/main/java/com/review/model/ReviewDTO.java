package com.review.model;

public class ReviewDTO {
	
	private int review_num;
	private int review_chall_num;
	private int review_mem_num;
	private String review_content;
	private int review_star;
	private String review_regdate;
	private String review_mem_name;
	private String review_chall_title;
	
	public String getReview_chall_title() {
		return review_chall_title;
	}
	public void setReview_chall_title(String review_chall_title) {
		this.review_chall_title = review_chall_title;
	}
	public String getReview_mem_name() {
		return review_mem_name;
	}
	public void setReview_mem_name(String review_mem_name) {
		this.review_mem_name = review_mem_name;
	}
	public int getReview_num() {
		return review_num;
	}
	public void setReview_num(int review_num) {
		this.review_num = review_num;
	}
	public int getReview_chall_num() {
		return review_chall_num;
	}
	public void setReview_chall_num(int review_chall_num) {
		this.review_chall_num = review_chall_num;
	}
	public int getReview_mem_num() {
		return review_mem_num;
	}
	public void setReview_mem_num(int review_mem_num) {
		this.review_mem_num = review_mem_num;
	}
	public String getReview_content() {
		return review_content;
	}
	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}
	public int getReview_star() {
		return review_star;
	}
	public void setReview_star(int review_star) {
		this.review_star = review_star;
	}
	public String getReview_regdate() {
		return review_regdate;
	}
	public void setReview_regdate(String review_regdate) {
		this.review_regdate = review_regdate;
	}

}
