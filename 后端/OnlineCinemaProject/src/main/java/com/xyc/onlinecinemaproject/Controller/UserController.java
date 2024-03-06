package com.xyc.onlinecinemaproject.Controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.xyc.onlinecinemaproject.Entity.JsonResult;
import com.xyc.onlinecinemaproject.Entity.User;
import com.xyc.onlinecinemaproject.Mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserMapper userMapper;

    @GetMapping("/findAll")
    public List<User> findAll(){
        return userMapper.selectList(null);
    }

    /**
     * 通过id查询单个用户信息
     */
    @GetMapping("/getUserById")
    public JsonResult<User> getUserById(@RequestParam Integer id){
        System.out.println("id"+id);
        User user = userMapper.selectById(id);
        System.out.println("user"+user);
        if (user == null){
            return new JsonResult<>("0","用户不存在！");
        }
        return new JsonResult<>(user);
    }

    /**
     * 管理员查询用户分页
     */
    @GetMapping("/page")
    public Page<User> page(@RequestParam Integer current,@RequestParam Integer size) {
        Page<User> page = new Page<>(current, size);
        userMapper.selectPage(page, null);
        return page;
    }

    /**
     * 管理员添加用户
     */
    @PostMapping("/insert")
    public String insertUser(@RequestBody User user){
        int result = userMapper.insert(user);
        if(result>=1){
            return "添加成功！";
        }
        return "用户名已存在！";
    }

    /**
     * 用户修改信息
     */
    @PutMapping("/update")
    public String updateUser(@RequestBody User user){
        int result = userMapper.updateById(user);
        if(result>0){
            return "修改成功！";
        }
        return "修改失败！";
    }

    /**
     * 删除用户
     */
    @DeleteMapping("/delete")
    public String deleteUser(@RequestParam Integer id){
        int result = userMapper.deleteById(id);
        if(result>=1){
            return "删除成功！";
        }
        return "删除失败！";
    }
}
