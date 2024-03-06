package com.xyc.onlinecinemaproject.Mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xyc.onlinecinemaproject.Entity.Movie;
import org.springframework.stereotype.Repository;

@Repository //将当前mapper接口标识为持久层组件
public interface MovieMapper extends BaseMapper<Movie> {
}
