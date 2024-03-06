package com.xyc.onlinecinemaproject.Entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@TableName("admin")
@Data
public class Admin {
    @TableId("a_id")
    private Integer id;
    @TableField("a_admin")
    private String admin;
    @TableField("a_password")
    private String passWord;
}
