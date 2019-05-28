package com.spring.client.board.vo;

import com.spring.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;


/*equals와 hashCode 메소드 자동 생성 시 부모 클래스의 필드까지 감안할지 안 할지에 대해서 설정시
 * callSuper = true로 설정하면 부모 클래스 필드 값들도 동일 한지 체크하며,
 * callSuper = false로 설정(기본값)하면 자신 클래스의 필드 값들만 고려한다.*/

@Data
@EqualsAndHashCode(callSuper=false)
public class BoardVO extends CommonVO{
	private int    b_num     =0; 
	private String b_name    =""; 
	private String b_title   ="";
	private String b_content =""; 
	private String b_date    ="";
	private String b_pwd     ="";
	private String r_cnt     ="";
}

