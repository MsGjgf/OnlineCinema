package com.xyc.onlinecinemaproject.Entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("user")
public class User {

    @TableId("u_id")
    private Integer id;

    @TableField("u_url")
    private String url;

    @TableField("u_account")
    private String account;

    @TableField("u_password")
    private String passWord;

    @TableField("u_phone")
    private String phone;

    @TableField("u_address")
    private String address;
}
