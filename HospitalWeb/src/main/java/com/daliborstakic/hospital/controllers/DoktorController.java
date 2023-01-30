package com.daliborstakic.hospital.controllers;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.daliborstakic.hospital.repositories.DijagnozaRepository;
import com.daliborstakic.hospital.repositories.DoktorRepository;
import com.daliborstakic.hospital.repositories.LekRepository;
import com.daliborstakic.hospital.repositories.ObavestenjeRepository;
import com.daliborstakic.hospital.repositories.PregledRepository;
import com.daliborstakic.hospital.repositories.ReceptRepository;
import com.daliborstakic.hospital.repositories.SimptomRepository;
import com.daliborstakic.hospital.repositories.TehnicarRepository;
import com.daliborstakic.hospital.repositories.ZakazivanjeRepository;

import model.Dijagnoza;
import model.Doktor;
import model.Lek;
import model.Obavestenje;
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

	@Autowired
	ObavestenjeRepository obavestenjeRepository;

	@GetMapping(value = "pocetna")
	public String redirectToHome(HttpServletRequest request) throws ParseException {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String currentPrincipalName = authentication.getName();

		Doktor doktor = doktorRepository.findDoktorByUsername(currentPrincipalName);

		String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		Date now = new SimpleDateFormat("yyyy-MM-dd").parse(today);

		List<Obavestenje> obavestenja = obavestenjeRepository.findByDoktor(doktor.getIdDoktor());
		List<Zakazivanje> zakazivanja = zakazivanjeRepository.findByDoktorToday(doktor.getIdDoktor(), now);

		request.setAttribute("obavestenja", obavestenja);
		request.setAttribute("zakazivanja", zakazivanja);

		return "doktor/doktorHome";
	}

	@GetMapping(value = "unesiPregled")
	public String redirectToUnesiPregled(HttpServletRequest request) {
		request.getSession().removeAttribute("zakazivanje");
		request.getSession().removeAttribute("zakazivanja");

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String currentPrincipalName = authentication.getName();

		Doktor doktor = doktorRepository.findDoktorByUsername(currentPrincipalName);

		List<Zakazivanje> zakazivanja = zakazivanjeRepository.findByDoktor(doktor.getIdDoktor());

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
	public ModelAndView savePregled(HttpServletRequest request, @ModelAttribute("pregled") Pregled pregled,
			@ModelAttribute("recept") Recept recept) throws ParseException {
		String date = request.getParameter("date");
		Date datum = new SimpleDateFormat("yyyy-MM-dd").parse(date);

		pregled.setDatum(datum);

		Zakazivanje zakazivanje = (Zakazivanje) request.getSession().getAttribute("zakazivanje");

		pregled.setDoktor(zakazivanje.getDoktor());
		pregled.setPacijent(zakazivanje.getPacijent());

		String opis = request.getParameter("opis");

		recept.setOpis(opis);

		for (Lek lek : recept.getLeks()) {
			lek.getRecepts().add(recept);
			lekRepository.save(lek);
		}

		pregled.setRecept(recept);

		zakazivanje.setPostojiPregled(true);

		zakazivanjeRepository.save(zakazivanje);

		receptRepository.save(recept);
		pregledRepository.save(pregled);

		return new ModelAndView("redirect:/doktor/pocetna");
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

	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
	}

	@GetMapping(value = "prikaziPreglede")
	public String redirectToPrikazi(HttpServletRequest request) {
		return "/doktor/prikaziPreglede";
	}

	@GetMapping(value = "vratiPreglede")
	public String getPregleds(HttpServletRequest request) {
		String search = request.getParameter("pretraga");
		search.trim();

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String currentPrincipalName = authentication.getName();

		Doktor doktor = doktorRepository.findDoktorByUsername(currentPrincipalName);

		List<Pregled> pregledi = pregledRepository.findByDoktorAndPacijent(search, doktor.getIdDoktor());

		pregledi.sort((p1, p2) -> p1.getDatum().compareTo(p2.getDatum()));

		request.setAttribute("pregledi", pregledi);

		return "/doktor/prikaziPreglede";
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

	@GetMapping(value = "prikaziRecept")
	public String redirectToPrikaziRecept(HttpServletRequest request) {
		Integer idRecept = Integer.parseInt(request.getParameter("idRecept"));
		Recept recept = receptRepository.findById(idRecept).get();

		request.setAttribute("recept", recept);

		return "doktor/prikaziRecept";
	}

	@GetMapping(value = "otkaziPregled")
	public String otkaziZakazivanje(HttpServletRequest request) {
		Integer idZakazivanje = Integer.parseInt(request.getParameter("idZakazivanje"));
		Zakazivanje zakazivanje = zakazivanjeRepository.findById(idZakazivanje).get();

		Obavestenje obavestenje = new Obavestenje();
		obavestenje.setDoktor(zakazivanje.getDoktor());
		obavestenje.setPacijent(zakazivanje.getPacijent());
		obavestenje.setKreator("DOKTOR");
		obavestenje.setPoruka("Otkazan vam je pregled kod " + zakazivanje.getDoktor().getIme() + " "
				+ zakazivanje.getDoktor().getPrezime() + ", datuma: " + zakazivanje.getDatum().toString());

		obavestenjeRepository.save(obavestenje);
		zakazivanjeRepository.deleteById(idZakazivanje);

		return "doktor/prikazZakazivanje";
	}

	@GetMapping(value = "obrisiObavestenja")
	public ModelAndView obrisiObavestenja() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String currentPrincipalName = authentication.getName();

		Doktor doktor = doktorRepository.findDoktorByUsername(currentPrincipalName);

		obavestenjeRepository.deleteByDoktor(doktor.getIdDoktor());

		return new ModelAndView("redirect:/doktor/pocetna");
	}

	@GetMapping(value = "prikaziSimptome")
	public String redirectToPrikaziSimptome(HttpServletRequest request, Model model) {
		request.getSession().removeAttribute("dijagnoze");

		List<Simptom> simptomi = simptomRepository.findAll();

		model.addAttribute("dijagnoza", new Dijagnoza());

		request.getSession().setAttribute("simptomi", simptomi);

		return "doktor/prikaziSimptome";
	}

	@GetMapping(value = "pretraziDijagnoze")
	public String prikaziDijagnoze(HttpServletRequest request, @ModelAttribute("dijagnoza") Dijagnoza dijagnoza) {
		List<Integer> simptomsIds = dijagnoza.getSimptoms().stream().map(p -> p.getIdSimptom())
				.collect(Collectors.toList());

		List<Dijagnoza> dijagnoze = dijagnozaRepository.findBySymptomIds(simptomsIds);

		request.getSession().setAttribute("dijagnoze", dijagnoze);

		return "doktor/prikaziSimptome";
	}

	@GetMapping(value = "prikaziPregledeDijagnoze")
	public String prikaziPregledeDijagnoze(HttpServletRequest request,
			@ModelAttribute("dijagnoza") Dijagnoza dijagnoza) {
		Integer idDijagnoza = Integer.parseInt(request.getParameter("idDijagnoza"));
		Dijagnoza odabranaDijagnoza = dijagnozaRepository.findById(idDijagnoza).get();

		request.setAttribute("odabranaDijagnoza", odabranaDijagnoza);

		return "doktor/prikaziSimptome";
	}
}
