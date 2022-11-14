package com.report.model;

public class ReportDTO {
	private int report_num;
	private int report_count;
	private String report_content;
	private String mem_id_reported;
	private String mem_id_report;
	private String report_title;
	private String report_image;
	private String report_cause;
	private String mem_name_reported;
	
	public String getMem_name_reported() {
		return mem_name_reported;
	}
	public void setMem_name_reported(String mem_name_reported) {
		this.mem_name_reported = mem_name_reported;
	}
	public String getReport_title() {
		return report_title;
	}
	public void setReport_title(String report_title) {
		this.report_title = report_title;
	}
	public String getReport_image() {
		return report_image;
	}
	public void setReport_image(String report_image) {
		this.report_image = report_image;
	}
	public String getReport_cause() {
		return report_cause;
	}
	public void setReport_cause(String report_cause) {
		this.report_cause = report_cause;
	}
	public int getReport_num() {
		return report_num;
	}
	public void setReport_num(int report_num) {
		this.report_num = report_num;
	}
	public int getReport_count() {
		return report_count;
	}
	public void setReport_count(int report_count) {
		this.report_count = report_count;
	}
	
	public String getReport_content() {
		return report_content;
	}
	public void setReport_content(String report_content) {
		this.report_content = report_content;
	}
	
	public String getMem_id_reported() {
		return mem_id_reported;
	}
	public void setMem_id_reported(String mem_id_reported) {
		this.mem_id_reported = mem_id_reported;
	}
	public String getMem_id_report() {
		return mem_id_report;
	}
	public void setMem_id_report(String mem_id_report) {
		this.mem_id_report = mem_id_report;
	}
}
