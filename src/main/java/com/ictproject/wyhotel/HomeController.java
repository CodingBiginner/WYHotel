package com.ictproject.wyhotel;

import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.ictproject.wyhotel.promotion.service.IPromotionService;
import com.ictproject.wyhotel.util.papago.PapagoService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class HomeController {

	@Autowired
	private IPromotionService promotionService;
	
	@Autowired
	private PapagoService papagoService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String ip = request.getHeader("X-FORWARDED-FOR");
		if (ip == null)
			ip = request.getRemoteAddr();
		
		model.addAttribute("promotionList", promotionService.getList(null, null, null));
		model.addAttribute("locale", locale);
		
		log.info("===============");
		log.info("Connected IP : " + ip);
		log.info("===============");
		
		String osName = System.getProperty("os.name").toLowerCase();
        System.out.println("os.name property: " + osName);
		
		return "home";
	}
	
	@PostMapping("/translate")
	@ResponseBody
	public JSONObject translateMessage(@RequestBody Map<String, Object> data) {
		String stringJson = papagoService.translateMessage((String)data.get("message"), (String)data.get("language"));
		System.out.println(stringJson);		
		
		try {			
			return (JSONObject)(new JSONParser().parse(stringJson));
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		}	
	}
}
