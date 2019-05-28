package com.spring.client.gallery.controller;

import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.client.gallery.service.GalleryService;
import com.spring.client.gallery.vo.GalleryVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping(value="/gallery/*")
@Log4j
@AllArgsConstructor
public class GalleryController {
	private GalleryService galleryService;
	
	
	//파라미터를 버인딩할 때 마 버음으로 호출되는 @InitBinder 이용해서 반환을 처리할 수 있다.
	@InitBinder
	public void initBinder (WebDataBinder binder) {
		binder.registerCustomEditor(MultipartFile.class, "file", new StringTrimmerEditor(true));
	}
	
	/**********************************************
	 * 갤러리 리스트 페이지 구현하기
	 ********************************************/
	
	@GetMapping("/galleryList")
	public String galleryList() {
		log.info("galleryList 호출성공");
		
		
		return "gallery/galleryList";
	}
	/**********************************
	 * 글쓰기 구현하기
	 * @param galleryVO
	 * @return String
	 ****************************************/
	
	@ResponseBody
	@RequestMapping(value="/galleryInsert",
	method=RequestMethod.POST, produces = "text/plain; charset=UTF-8")
	public String galleryInsert(@ModelAttribute GalleryVO gvo) {
		log.info("galleryInsert 호출 성공");
		
		log.info("file name : " + gvo.getFile().getOriginalFilename());
		String value = "";
		int result = 0;
		
		result = galleryService.galleryInsert(gvo);
		if(result==1) {
			value = "성공";
		}else {
			value = "실패";
		}
		return value;
	}
	
	/*******************************************************
	 * 갤러리 목록 구현하기
	 *******************************************************/
	
	@ResponseBody
	@RequestMapping(value="/galleryData", produces = "text/plain; charset=UTF-8")
	public String galleryData(GalleryVO gvo) {
		log.info("galleryData 호출 성공");
		String listData = galleryService.galleryList(gvo);
		
		return listData;
	}
	
	/***************************************************
	 * 갤러리 비밀번호 확인
	 * 참고:@ResponseBody는 전달된 뷰를 통해서 출려하는 것이 아니라 HTTP Response Body에 직접 출력하는 방식.
	 ****************************************************/
	@ResponseBody
	@PostMapping(value="/pwdConfirm", produces=MediaType.TEXT_PLAIN_VALUE)
	public String pwdConfirm(@ModelAttribute GalleryVO gvo) {
		log.info("pwdConfirm 호출 성공");
		
		//아래 변수에는 입력 성공에 대한 상태값 저장(1 or 0)
		int result=0;
		result = galleryService.pwdConfirm(gvo);
		log.info("result = " + result);
		
		return String.valueOf(result);
		
	}
	
	/***********************************
	 * 글 삭제 구현하기
	 **********************************************/
	@ResponseBody
	@RequestMapping(value="/galleryDelete", method=RequestMethod.POST, produces="text/plain; charset=UTF-8")
	public String galleryDelete(@ModelAttribute GalleryVO gvo) {
		int result = 0;
		String value = "";
		result = galleryService.galleryDelete(gvo);
		if(result ==1) {
			value="성공";
		}else {
			value="실패";
		}
		return value;
	}
	
	/*****************************************************
	 * 글 상세보기 구현
	 * @param galleryVO
	 * @return String
	 *********************************************/
	@ResponseBody
	@GetMapping(value="/galleryDetail", produces="text/plain; charset=UTF-8")
	public String galleryDetail(@ModelAttribute GalleryVO gvo) {
		log.info("galleryDetail 호출 성공");
		
		String detail = galleryService.galleryDetail(gvo);
		return detail;
	}

	/***************************************************
	 * 글수정 구현하기
	 * ***********************************************/
	
	@ResponseBody
	@PostMapping(value="/galleryUpdate", produces="text/plain; charset=UTF-8")
	public String galleryUpdate(@ModelAttribute GalleryVO gvo) {
		log.info("galleryUpdate 호출 성공");
		
		String value ="";
		int result = 0;
		
		result = galleryService.galleryUpdate(gvo);
		if(result==1) {
			value = "성공";
		}else {
			value ="실패";
		}
		return value;
	
	}


}
