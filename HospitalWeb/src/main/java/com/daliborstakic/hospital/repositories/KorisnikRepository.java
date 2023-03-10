package com.daliborstakic.hospital.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import model.Korisnik;

public interface KorisnikRepository extends JpaRepository<Korisnik, Integer> {
	Korisnik findByUsername(String username);
}
