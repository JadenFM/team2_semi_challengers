package com.mypage.model;

public class MoneyLogDTO {
	
	private int mem_num;
	private int chall_num;
	private int money_log_content;
	private String money_log_kind;
	private String log_date;
	private int money_log_my_deposit;
	
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public int getChall_num() {
		return chall_num;
	}
	public void setChall_num(int chall_num) {
		this.chall_num = chall_num;
	}
	public int getMoney_log_content() {
		return money_log_content;
	}
	public void setMoney_log_content(int money_log_content) {
		this.money_log_content = money_log_content;
	}
	public String getMoney_log_kind() {
		return money_log_kind;
	}
	public void setMoney_log_kind(String money_log_kind) {
		this.money_log_kind = money_log_kind;
	}
	public String getLog_date() {
		return log_date;
	}
	public void setLog_date(String log_date) {
		this.log_date = log_date;
	}
	public int getMoney_log_my_deposit() {
		return money_log_my_deposit;
	}
	public void setMoney_log_my_deposit(int money_log_my_deposit) {
		this.money_log_my_deposit = money_log_my_deposit;
	}
	
}
