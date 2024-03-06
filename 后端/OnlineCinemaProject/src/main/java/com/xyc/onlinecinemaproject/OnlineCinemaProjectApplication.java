package com.xyc.onlinecinemaproject;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
//扫描mapper接口所在的包
@MapperScan("com.xyc.onlinecinemaproject.Mapper")
public class OnlineCinemaProjectApplication {

    public static void main(String[] args) {
        SpringApplication.run(OnlineCinemaProjectApplication.class, args);
    }

}
