package com.daliborstakic.hospital.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import model.Omiljeni;
import model.Pacijent;

public interface OmiljeniRepository extends JpaRepository<Omiljeni, Integer> {
	List<Omiljeni> findByPacijent(Pacijent pacijent);
}
