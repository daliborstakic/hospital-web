package com.daliborstakic.hospital.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import model.Pacijent;

public interface PacijentRepository extends JpaRepository<Pacijent, Integer> {
}
