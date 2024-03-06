package com.xyc.onlinecinemaproject.Service.Impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xyc.onlinecinemaproject.Entity.User;
import com.xyc.onlinecinemaproject.Mapper.UserMapper;
import com.xyc.onlinecinemaproject.Service.UserService;
import org.springframework.stereotype.Service;

@Service
public class UserMapperImpl extends ServiceImpl<UserMapper, User> implements UserService {

}
