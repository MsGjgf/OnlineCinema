package com.xyc.onlinecinemaproject.Service.Impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xyc.onlinecinemaproject.Entity.Commit;
import com.xyc.onlinecinemaproject.Mapper.CommitMapper;
import com.xyc.onlinecinemaproject.Service.CommitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@Service
public class CommitServiceImpl extends ServiceImpl<CommitMapper, Commit> implements CommitService {
}
