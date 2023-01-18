package com.daliborstakic.hospital.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import model.Simptom;

public interface SimptomRepository extends JpaRepository<Simptom, Integer> {

}
