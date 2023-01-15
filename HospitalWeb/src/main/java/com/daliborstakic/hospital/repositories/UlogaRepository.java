package com.daliborstakic.hospital.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import model.Uloga;

public interface UlogaRepository extends JpaRepository<Uloga, Integer> {
	Uloga findByNaziv(String naziv);
}
