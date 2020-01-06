package com.exam.domain;

import java.sql.Timestamp;

import lombok.Data;

// Value Object(VO) = �옄諛붾퉰(Java Bean) �겢�옒�뒪 = DTO(Data Transfer Object)
@Data
public class MemberVO {
	private String id;
	private String passwd;
	private String name;
	private Integer age;
	private String gender;
	private String email;
	private String address;
	private String tel;
	private String mtel;
	private Timestamp regDate;
	

	
	
}