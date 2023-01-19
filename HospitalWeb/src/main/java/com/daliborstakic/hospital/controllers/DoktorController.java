package com.daliborstakic.hospital.controllers;

import java.text.ParseException;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.daliborstakic.hospital.repositories.DijagnozaRepository;
import com.daliborstakic.hospital.repositories.DoktorRepository;
import com.daliborstakic.hospital.repositories.LekRepository;
import com.daliborstakic.hospital.repositories.PregledRepository;
import com.daliborstakic.hospital.repositories.ReceptRepository;
import com.daliborstakic.hospital.repositories.SimptomRepository;
import com.daliborstakic.hospital.repositories.TehnicarRepository;
import com.daliborstakic.hospital.repositories.ZakazivanjeRepository;

import model.Dijagnoza;
import model.Doktor;
import model.Lek;
import model.Pregled;
import model.Recept;
import model.Simptom;
import model.Tehnicar;
import model.Zakazivanje;

@Controller
@RequestMapping(value = "/doktor")
public class DoktorController {
	@Autowired
	DoktorRepository doktorRepository;

	@Autowired
	ZakazivanjeRepository zakazivanjeRepository;

	@Autowired
	LekRepository lekRepository;

	@Autowired
	DijagnozaRepository dijagnozaRepository;

	@Autowired
	SimptomRepository simptomRepository;

	@Autowired
	TehnicarRepository tehnicarRepository;

	@Autowired
	ReceptRepository receptRepository;

	@Autowired
	PregledRepository pregledRepository;

	@GetMapping(value = "pocetna")
	public String redirectToHome() {
		return "doktor/doktorHome";
	}

	@GetMapping(value = "unesiPregled")
	public String redirectToUnesiPregled(HttpServletRequest request) {
		request.getSession().removeAttribute("zakazivanje");

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String currentPrincipalName = authentication.getName();

		Doktor doktor = doktorRepository.findDoktorByUsername(currentPrincipalName);

		List<Zakazivanje> zakazivanja = zakazivanjeRepository.findByDoktor(doktor);

		request.getSession().setAttribute("zakazivanja", zakazivanja);

		return "doktor/prikazZakazivanja";
	}

	@GetMapping(value = "odaberiZakazivanje")
	public String preuzmiZakazivanje(HttpServletRequest request, ModelMap map) {
		Integer idZakazivanje = Integer.parseInt(request.getParameter("idZakazivanje"));
		Zakazivanje zakazivanje = zakazivanjeRepository.findById(idZakazivanje).get();

		List<Dijagnoza> dijagnoze = dijagnozaRepository.findAll();
		List<Lek> lekovi = lekRepository.findAll();
		List<Tehnicar> tehnicari = tehnicarRepository.findAll();

		Map<Tehnicar, String> tehnicariMap = tehnicari.stream()
				.collect(Collectors.toMap(Function.identity(), Tehnicar::punoIme));

		map.addAttribute("pregled", new Pregled());
		map.addAttribute("recept", new Recept());

		request.setAttribute("lekovi", lekovi);
		request.setAttribute("dijagnoze", dijagnoze);
		request.setAttribute("tehnicari", tehnicariMap);
		request.getSession().setAttribute("zakazivanje", zakazivanje);

		return "doktor/prikazZakazivanja";
	}

	@PostMapping(value = "sacuvajPregled")
	public String savePregled(@ModelAttribute("pregled") Pregled pregled, @ModelAttribute("recept") Recept recept)
			throws ParseException {
		System.out.println(pregled.getDijagnoza().getNaziv());

		return "/";
	}

	@GetMapping(value = "unesiSimptome")
	public String redirectToUnosSimptoma(Model model) {
		Simptom simptom = new Simptom();

		model.addAttribute("simptom", simptom);

		return "doktor/unesiSimptome";
	}

	@PostMapping(value = "sacuvajSimptom")
	public ModelAndView saveSimptom(@ModelAttribute("simptom") Simptom simptom) {
		simptomRepository.save(simptom);

		return new ModelAndView("redirect:/doktor/pocetna");
	}

	@GetMapping(value = "unosDijagnoza")
	public String redirectToUnesiDijagnoza(HttpServletRequest request, Model model) {
		Dijagnoza dijagnoza = new Dijagnoza();
		model.addAttribute("dijagnoza", dijagnoza);

		List<Simptom> simptomi = simptomRepository.findAll();

		request.setAttribute("simptomi", simptomi);

		return "doktor/unesiDijagnozu";
	}

	@PostMapping(value = "sacuvajDijagnozu")
	public ModelAndView saveDijagnoza(@ModelAttribute("dijagnoza") Dijagnoza dijagnoza, HttpServletRequest request) {
		List<Simptom> simptomi = dijagnoza.getSimptoms();

		dijagnozaRepository.save(dijagnoza);

		for (Simptom simptom : simptomi) {
			simptom.getDijagnozas().add(dijagnoza);
			simptomRepository.save(simptom);
		}

		return new ModelAndView("redirect:/doktor/pocetna");
	}
}
