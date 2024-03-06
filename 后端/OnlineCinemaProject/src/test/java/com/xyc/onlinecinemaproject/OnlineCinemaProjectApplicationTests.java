package com.xyc.onlinecinemaproject;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@SpringBootTest
class OnlineCinemaProjectApplicationTests {

    @Test
    void contextLoads() {

    }

    /**
     * 生成JWT
     */
    @Test
    public void testGenJwt(){
        Map<String, Object> claims = new HashMap<>();
        claims.put("id",1);
        claims.put("name","tom");

        String jwt = Jwts.builder()
                .signWith(SignatureAlgorithm.HS256,"JavaWeb")  //签名算法
                .setClaims(claims)  //自定义内容（载荷）
                .setExpiration(new Date(System.currentTimeMillis() + 3600 * 1000))  //设置有效期为1小时
                .compact();
        System.out.println(jwt);
    }

    /**
     * 解析JWT
     */
    @Test
    public void testParseJwt(){
        Claims claims = Jwts.parser()
                .setSigningKey("JavaWeb")   //指定签名密钥
                //解析令牌
                .parseClaimsJws("eyJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoidG9tIiwiaWQiOjEsImV4cCI6MTcwMDMyNTk4NX0.nJwT8bM873dmlm1nh8sj_xQbNtqNJwFQofbfD9pqmgY")
                .getBody();
        System.out.println(claims);
    }

}
