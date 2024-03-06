package com.xyc.onlinecinemaproject.Mapper;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xyc.onlinecinemaproject.Entity.Commit;
import org.apache.ibatis.annotations.MapKey;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@Repository
public interface CommitMapper extends BaseMapper<Commit> {
    @MapKey("c_id")
    List<Map<String, Object>> getCommitByMovieId(@RequestParam Integer id);
}
