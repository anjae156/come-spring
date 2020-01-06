package com.exam.domain;

import lombok.Data;

@Data
public class AttachVO {
	private String uuid;
	private String uploadpath;
	private String filename;
	private String filetype; // "I"는 Image파일타입(jpg,gif,png)
	private int bno;
	
}
