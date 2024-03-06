package com.xyc.onlinecinemaproject.Config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class Config implements WebMvcConfigurer {
//    跨域
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedOriginPatterns("*")
                .allowedHeaders("*")
                .allowedMethods("GET","POST","PUT","DELETE","HEAD","OPTIONS")
                .allowCredentials(true)
                .maxAge(3600);
    }
//    配置上传的静态文件无需重启idea
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
                //配置需要映射的文件夹
        registry.addResourceHandler("/images/**")
                //配置文件夹在系统中的绝对路径
                .addResourceLocations("file:"+System.getProperty("user.dir")+"/src/main/resources/static/images/");
        registry.addResourceHandler("/movie/**")
                .addResourceLocations("file:"+System.getProperty("user.dir")+"/src/main/resources/static/movie/");
    }
}
