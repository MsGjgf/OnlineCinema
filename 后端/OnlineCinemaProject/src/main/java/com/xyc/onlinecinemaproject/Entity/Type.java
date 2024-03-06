package com.xyc.onlinecinemaproject.Entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@TableName("type")
@Data
public class Type {
    @TableId("t_id")
    private Integer id;
    @TableField("t_type")
    private String type;
    @TableLogic
    private Integer isDeleted;
}
