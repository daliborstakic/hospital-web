package com.daliborstakic.hospital.controllers;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.daliborstakic.hospital.repositories.DoktorRepository;
import com.daliborstakic.hospital.repositories.PacijentRepository;
import com.daliborstakic.hospital.repositories.SpecijalizacijaRepository;
import com.daliborstakic.hospital.repositories.ZakazivanjeRepository;

import model.Doktor;
import model.Pacijent;
import model.Specijalizacija;
import model.Zakazivanje;

@Controller
@RequestMapping(value = "/pacijent")
public class PacijentController {
	@Autowired
	DoktorRepository doktorRepository;

	@Autowired
	SpecijalizacijaRepository specijalizacijaRepository;

	@Autowired
	PacijentRepository pacijentRepository;

	@Autowired
	ZakazivanjeRepository zakazivanjeRepository;

	@GetMapping(value = "pocetna")
	public String redirectToPocetna() {
		return "pacijent/pacijentHome";
	}

	@GetMapping(value = "zakaziPregled")
	public String redirectToZakaziPregled(HttpServletRequest request) {
		List<Specijalizacija> specijalizacije = specijalizacijaRepository.findAll();

		request.getSession().setAttribute("specijalizacije", specijalizacije);

		return "pacijent/unosZakazivanja";
	}

	@GetMapping(value = "prikaziDoktoreZaZakazivanje")
	public String preuzmiDoktore(HttpServletRequest request) {
		Integer idSpecijalizacija = Integer.parseInt(request.getParameter("specijalizacija"));
		Specijalizacija specijalizacija = specijalizacijaRepository.findById(idSpecijalizacija).get();

		List<Doktor> doktori = doktorRepository.findBySpecijalizacija(specijalizacija);
		request.setAttribute("doktori", doktori);

		return "pacijent/unosZakazivanja";
	}

	@GetMapping(value = "odaberiDoktora")
	public String redirectToZakazivanje(HttpServletRequest request) {
		request.setAttribute("idDoktor", request.getParameter("idDoktor"));

		return "pacijent/odaberiTermin";
	}

	@PostMapping(value = "sacuvajZakazivanje")
	public ModelAndView saveZakazivanje(HttpServletRequest request) throws ParseException {
		Zakazivanje zakazivanje = new Zakazivanje();

		String datum = request.getParameter("datum");

		System.out.println(datum);

		Date date = new SimpleDateFormat("yyyy-mm-dd").parse(datum);

		System.out.println(date);

		zakazivanje.setDatum(date);

		Integer doktorId = Integer.parseInt(request.getParameter("idDoktor"));
		Doktor doktor = doktorRepository.findById(doktorId).get();

		System.out.println(zakazivanje.getDatum());

		zakazivanje.setDoktor(doktor);
		doktor.addZakazivanje(zakazivanje);

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String currentPrincipalName = authentication.getName();

		Pacijent pacijent = pacijentRepository.findPacijentByUsername(currentPrincipalName);

		zakazivanje.setPacijent(pacijent);
		pacijent.addZakazivanje(zakazivanje);

		zakazivanjeRepository.save(zakazivanje);

		return new ModelAndView("redirect:/pacijent/pocetna");
	}
}
