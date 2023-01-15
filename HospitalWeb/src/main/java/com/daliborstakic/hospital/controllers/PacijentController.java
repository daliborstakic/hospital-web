package com.daliborstakic.hospital.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/pacijent")
public class PacijentController {
	@GetMapping(value = "pocetna")
	public String redirectToPocetna() {
		return "pacijent/pacijentHome";
	}
}
