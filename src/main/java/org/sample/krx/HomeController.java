package org.sample.krx;

import java.util.Map;

import org.json.JSONObject;
import org.json.XML;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@RequestMapping(value = "/krx")
	public void krx(Model model) {
		String html = ParserUtil.getHtml("http://asp1.krx.co.kr/servlet/krx.asp.XMLSise?code=035420");
		JSONObject json = XML.toJSONObject(html);
		Map<String, Object> resultMap = ParserUtil.parseJsonToMap(json.toString());
		
		model.addAttribute("map", resultMap);
	}
	
}
