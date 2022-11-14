package com.chall.model;

public class ChallProofDTO {

	private int proof_num;
	private int proof_chall_num;
	private int proof_mem_num;
	private String proof_regdate;
	private int proof_sequence;
	private String proof_image;
	private String proof_deposit;
	private String proof_pass;
	private int proof_order;
	
	public int getProof_order() {
		return proof_order;
	}
	public void setProof_order(int proof_order) {
		this.proof_order = proof_order;
	}
	public int getProof_num() {
		return proof_num;
	}
	public void setProof_num(int proof_num) {
		this.proof_num = proof_num;
	}
	public int getProof_chall_num() {
		return proof_chall_num;
	}
	public void setProof_chall_num(int proof_chall_num) {
		this.proof_chall_num = proof_chall_num;
	}
	public int getProof_mem_num() {
		return proof_mem_num;
	}
	public void setProof_mem_num(int proof_mem_num) {
		this.proof_mem_num = proof_mem_num;
	}
	public String getProof_regdate() {
		return proof_regdate;
	}
	public void setProof_regdate(String proof_regdate) {
		this.proof_regdate = proof_regdate;
	}
	public int getProof_sequence() {
		return proof_sequence;
	}
	public void setProof_sequence(int proof_sequence) {
		this.proof_sequence = proof_sequence;
	}
	public String getProof_image() {
		return proof_image;
	}
	public void setProof_image(String proof_image) {
		this.proof_image = proof_image;
	}
	public String getProof_deposit() {
		return proof_deposit;
	}
	public void setProof_deposit(String proof_deposit) {
		this.proof_deposit = proof_deposit;
	}
	public String getProof_pass() {
		return proof_pass;
	}
	public void setProof_pass(String proof_pass) {
		this.proof_pass = proof_pass;
	}
}
