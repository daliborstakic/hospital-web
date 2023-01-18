package com.daliborstakic.hospital.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import model.Doktor;
import model.Pacijent;
import model.Zakazivanje;

public interface ZakazivanjeRepository extends JpaRepository<Zakazivanje, Integer> {
	List<Zakazivanje> findByPacijent(Pacijent pacijent);

	List<Zakazivanje> findByDoktor(Doktor doktor);
}
