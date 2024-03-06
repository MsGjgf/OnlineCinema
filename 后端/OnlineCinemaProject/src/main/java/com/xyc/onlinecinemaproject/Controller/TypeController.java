package com.xyc.onlinecinemaproject.Controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xyc.onlinecinemaproject.Entity.JsonResult;
import com.xyc.onlinecinemaproject.Entity.Type;
import com.xyc.onlinecinemaproject.Mapper.TypeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/type")
public class TypeController {

    @Autowired
    private TypeMapper typeMapper;

    /**
     * 获取所有电影类型
     */
    @GetMapping("/getTypeAll")
    public List<Type> getTypeAll(){
        return typeMapper.selectList(null);
    }

    /**
     * 通过类型名修改类型
     */
    @PostMapping("/postTypeByType")
    public JsonResult<Type> putTypeByType(@RequestParam String oldType,@RequestParam String newType){
        QueryWrapper<Type> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("t_type",oldType);
        Type id = typeMapper.selectOne(queryWrapper);
        System.out.println(id);

        Type type = new Type();
        type.setId(id.getId());
        type.setType(newType);
        int result = typeMapper.updateById(type);
        if (result>0){
            return new JsonResult<>("200","更新成功！");
        }
        return new JsonResult<>("0","更新失败！");
    }

    /**
     * 添加电影类型
     */
    @PostMapping("/insertType")
    public JsonResult<Type> insertType(@RequestParam String type){
        Type type1 = new Type();
        type1.setType(type);
        try {
            typeMapper.insert(type1);
            return new JsonResult<>("200","添加成功！");
        }catch (Exception e) {
            return new JsonResult<>("0","类型已存在！");
        }
    }
}
