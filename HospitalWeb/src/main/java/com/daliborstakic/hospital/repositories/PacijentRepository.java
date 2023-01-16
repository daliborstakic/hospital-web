package com.daliborstakic.hospital.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import model.Pacijent;

public interface PacijentRepository extends JpaRepository<Pacijent, Integer> {
	@Query("select p from Pacijent p inner join p.korisnik k where k.username = ?1")
	Pacijent findPacijentByUsername(String username);
}
