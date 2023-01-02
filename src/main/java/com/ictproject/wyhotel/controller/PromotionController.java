package com.ictproject.wyhotel.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ictproject.wyhotel.command.PromotionUploadVO;
import com.ictproject.wyhotel.command.PromotionVO;
import com.ictproject.wyhotel.promotion.service.IPromotionService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/promotion")
@Log4j
public class PromotionController {
	
	/**
	 * 작 성 일 : 2022/12/30
	 * 작 성 자 : 권 우 영
	 * */
	
	@Autowired
	private IPromotionService service;
		
	@GetMapping("/list")
	public void listPage(Model model) {		
		model.addAttribute("promotionList", service.getList());		
	}
	
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileLocation, String fileName) {
		
		File file = new File("C:/test/upload/" + fileLocation + "/" + fileName);
		
		ResponseEntity<byte[]> result = null;
		HttpHeaders headers = new HttpHeaders();
		try {
			headers.add("Content-Type", Files.probeContentType(file.toPath()));
			headers.add("img", "imgtag");
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), headers, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@GetMapping("/insert")
	public void insertPage() {}

	@PostMapping("/insert")
	public String insert(PromotionUploadVO upload) {	
		
		service.insert(upload);				
		
		return "redirect:/promotion/list";
	}
	
	@GetMapping("/update")
	public void updatePage(String promotionCodeData, Model model) {
		PromotionVO promotion = service.getPromotion(promotionCodeData);
		
		model.addAttribute("promotion", promotion);
	}
}