package com.xyc.onlinecinemaproject.Entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
//设置实体类对应的表名
@TableName("movie")
public class Movie {

    @TableId("m_id")
    private Integer id;

    @TableField("m_name")
    private String name;

    @TableField("m_director")
    private String director;

    @TableField("m_type")
    private String type;

    @TableField("m_duration")
    private Integer duration;

    @TableField("m_poster")
    private String poster;

    @TableField("m_description")
    private String description;

    @TableField("m_count")
    private Integer count;

    @TableField("m_url")
    private String url;
}
