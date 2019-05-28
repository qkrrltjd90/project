package com.spring.client.gallery.vo;

import org.springframework.web.multipart.MultipartFile;

import com.spring.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class GalleryVO extends CommonVO{
	private int g_num;
	private String g_name;
	private String g_subject;
	private String g_content; //여러개일경우 배열 사용
	public MultipartFile file;
	private String g_thumb;
	private String g_file;
	private String g_pwd;
	private String g_date;
	private int g_count;

}



