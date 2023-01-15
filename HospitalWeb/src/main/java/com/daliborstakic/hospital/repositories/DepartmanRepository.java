package com.daliborstakic.hospital.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import model.Departman;

public interface DepartmanRepository extends JpaRepository<Departman, Integer> {

}
