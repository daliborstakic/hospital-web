package com.daliborstakic.hospital;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;

@EntityScan("model")
@SpringBootApplication
public class HospitalWebApplication {
	public static void main(String[] args) {
		SpringApplication.run(HospitalWebApplication.class, args);
	}
}
