package com.xyc.onlinecinemaproject.Controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xyc.onlinecinemaproject.Entity.*;
import com.xyc.onlinecinemaproject.Mapper.*;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/")
public class LoginController {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private AdminMapper adminMapper;

    /**
     * 用户注册
     */
    @PostMapping("/register")
    public JsonResult<User> register(@RequestParam String userName,@RequestParam String passWord){

        //注册时，检查用户是否存在
        QueryWrapper<User> queryWrapper =new QueryWrapper<>();
        queryWrapper.eq("u_account",userName);
        Long result = userMapper.selectCount(queryWrapper);
        if (result>0){
            return new JsonResult<>("0","用户名已存在！");
        }

        //插入用户注册信息
        User user = new User();
        user.setAccount(userName);
        user.setPassWord(passWord);
        int result1 = userMapper.insert(user);
        if (result1>0){
            return new JsonResult<>("200","注册成功！");
        }
        return new JsonResult<>("0","注册失败！");
    }

    /**
     * 用户登录
     */
    @PostMapping("/loginUser")
    public JsonResult<Map<String,Object>> loginUser(@RequestParam String userName,@RequestParam String passWord){
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("u_account",userName)
                    .eq("u_password",passWord);
        Long result = userMapper.selectCount(queryWrapper);
        if (result>0){
            User user = userMapper.selectOne(queryWrapper);
            //生成令牌
            Map<String, Object> claims = new HashMap<>();
            claims.put("id",user.getId());
            claims.put("userName",user.getAccount());

            String jwt = Jwts.builder()
                    .signWith(SignatureAlgorithm.HS256,"JavaWeb")  //签名算法
                    .setClaims(claims)  //自定义内容（载荷）
                    .setExpiration(new Date(System.currentTimeMillis() + 3600 * 1000))  //设置有效期为1小时
                    .compact();
            claims.put("token",jwt);
            return new JsonResult<>(claims,"登录成功！");
        }
        return new JsonResult<>("0","用户名或密码不正确！");
    }

    /**
     * 管理员登录
     */
    @PostMapping("/loginAdmin")
    public JsonResult<Map<String,Object>> loginAdmin(@RequestParam String userName,@RequestParam String passWord){
        QueryWrapper<Admin> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("a_admin",userName)
                    .eq("a_password",passWord);
        Long result = adminMapper.selectCount(queryWrapper);
        if (result>0){
            Admin admin = new Admin();
            //生成令牌
            Map<String, Object> claims = new HashMap<>();
            claims.put("id",admin.getId());
            claims.put("userName",admin.getAdmin());

            String jwt = Jwts.builder()
                    .signWith(SignatureAlgorithm.HS256,"JavaWeb")  //签名算法
                    .setClaims(claims)  //自定义内容（载荷）
                    .setExpiration(new Date(System.currentTimeMillis() + 3600 * 1000))  //设置有效期为1小时
                    .compact();
            claims.put("token",jwt);
            return new JsonResult<>(claims,"登陆成功！");
        }
        return new JsonResult<>("0","用户名或密码不正确");
    }
}
