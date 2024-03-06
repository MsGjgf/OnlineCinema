package com.xyc.onlinecinemaproject.Entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.Date;

@Data
@TableName("commit")
public class Commit {

    @TableId("c_id")
    private Integer id;

    @TableField("remark")
    private String remark;

    @TableField("u_id")
    private Integer uid;

    @TableField("m_id")
    private Integer mid;

    @TableField("m_date")
    private Date date;
}
