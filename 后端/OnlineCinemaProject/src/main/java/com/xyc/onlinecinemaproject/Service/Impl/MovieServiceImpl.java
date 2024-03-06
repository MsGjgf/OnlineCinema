package com.xyc.onlinecinemaproject.Service.Impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xyc.onlinecinemaproject.Entity.Movie;
import com.xyc.onlinecinemaproject.Mapper.MovieMapper;
import com.xyc.onlinecinemaproject.Service.MovieService;
import org.springframework.stereotype.Service;

@Service
public class MovieServiceImpl extends ServiceImpl<MovieMapper, Movie> implements MovieService {
}
