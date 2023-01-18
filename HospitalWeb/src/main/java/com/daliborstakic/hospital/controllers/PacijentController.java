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
import com.daliborstakic.hospital.repositories.OmiljeniRepository;
import com.daliborstakic.hospital.repositories.PacijentRepository;
import com.daliborstakic.hospital.repositories.SpecijalizacijaRepository;
import com.daliborstakic.hospital.repositories.ZakazivanjeRepository;

import model.Doktor;
import model.Omiljeni;
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

	@Autowired
	OmiljeniRepository omiljeniRepository;

	@GetMapping(value = "pocetna")
	public String redirectToPocetna(HttpServletRequest request) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String currentPrincipalName = authentication.getName();

		Pacijent pacijent = pacijentRepository.findPacijentByUsername(currentPrincipalName);

		List<Omiljeni> omiljeni = omiljeniRepository.findByPacijent(pacijent);

		request.getSession().setAttribute("pacijent", pacijent);
		request.getSession().setAttribute("omiljeni", omiljeni);

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
		request.getSession().setAttribute("doktori", doktori);

		return "pacijent/unosZakazivanja";
	}

	@GetMapping(value = "odaberiDoktora")
	public String redirectToZakazivanje(HttpServletRequest request) {
		Integer idDoktor = Integer.parseInt(request.getParameter("idDoktor"));
		Doktor doktor = doktorRepository.findById(idDoktor).get();

		request.getSession().setAttribute("doktor", doktor);

		return "pacijent/unosZakazivanja";
	}

	@PostMapping(value = "sacuvajZakazivanje")
	public ModelAndView saveZakazivanje(HttpServletRequest request) throws ParseException {
		Zakazivanje zakazivanje = new Zakazivanje();

		String datum = request.getParameter("datum");
		Date date = new SimpleDateFormat("yyyy-MM-dd").parse(datum);

		zakazivanje.setDatum(date);

		Doktor doktor = (Doktor) request.getSession().getAttribute("doktor");

		zakazivanje.setDoktor(doktor);

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String currentPrincipalName = authentication.getName();

		Pacijent pacijent = pacijentRepository.findPacijentByUsername(currentPrincipalName);

		zakazivanje.setPacijent(pacijent);

		zakazivanjeRepository.save(zakazivanje);

		request.getSession().removeAttribute("doktor");
		request.getSession().removeAttribute("doktori");

		return new ModelAndView("redirect:/pacijent/pocetna");
	}

	@GetMapping(value = "prikaziZakazivanja")
	public String redirectToPrikazivanjaPage(HttpServletRequest request) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String currentPrincipalName = authentication.getName();

		Pacijent pacijent = pacijentRepository.findPacijentByUsername(currentPrincipalName);

		List<Zakazivanje> zakazivanja = zakazivanjeRepository.findByPacijent(pacijent);

		request.getSession().removeAttribute("zakazivanje");
		request.getSession().setAttribute("zakazivanja", zakazivanja);

		return "pacijent/prikaziZakazivanja";
	}

	@GetMapping(value = "odaberiZakazivanje")
	public String izmeniZakazivanje(HttpServletRequest request) {
		Integer idZakazivanje = Integer.parseInt(request.getParameter("idZakazivanje"));
		Zakazivanje zakazivanje = zakazivanjeRepository.findById(idZakazivanje).get();

		request.getSession().setAttribute("zakazivanje", zakazivanje);

		return "pacijent/prikaziZakazivanja";
	}

	@PostMapping(value = "pomeriZakazivanje")
	public ModelAndView pomeriZakazivanje(HttpServletRequest request) throws ParseException {
		Zakazivanje zakazivanje = (Zakazivanje) request.getSession().getAttribute("zakazivanje");

		String datum = request.getParameter("datum");
		Date date = new SimpleDateFormat("yyyy-MM-dd").parse(datum);

		zakazivanje.setDatum(date);

		zakazivanjeRepository.save(zakazivanje);

		return new ModelAndView("redirect:/pacijent/prikaziZakazivanja");
	}

	@GetMapping(value = "prikazDoktora")
	public String redirectToPrikazDoktora(HttpServletRequest request) {
		List<Doktor> doktori = doktorRepository.findAll();

		request.setAttribute("doktori", doktori);

		return "pacijent/prikazDoktora";
	}

	@GetMapping(value = "omiljenDoktor")
	public ModelAndView saveToOmiljen(HttpServletRequest request) {
		Integer idDoktor = Integer.parseInt(request.getParameter("idDoktor"));
		Doktor doktor = doktorRepository.findById(idDoktor).get();

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String currentPrincipalName = authentication.getName();

		Pacijent pacijent = pacijentRepository.findPacijentByUsername(currentPrincipalName);

		Omiljeni omiljeni = new Omiljeni();

		omiljeni.setDoktor(doktor);
		omiljeni.setPacijent(pacijent);

		doktor.addOmiljeni(omiljeni);
		pacijent.addOmiljeni(omiljeni);

		omiljeniRepository.save(omiljeni);

		return new ModelAndView("redirect:/pacijent/pocetna");
	}
}
