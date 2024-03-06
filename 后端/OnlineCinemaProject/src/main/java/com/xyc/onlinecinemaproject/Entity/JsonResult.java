package com.xyc.onlinecinemaproject.Entity;

import lombok.Data;

@Data
public class JsonResult<T> {

    private String code;
    private String msg;
    private T data;

    public JsonResult(){
        this.code = "200";
        this.msg = "操作成功！";
    }

    public JsonResult(String code,String msg){
        this.code = code;
        this.msg = msg;
    }

    public JsonResult(T data){
        this.data = data;
        this.code = "200";
        this.msg = "操作成功！";
    }

    public JsonResult(T data,String msg){
        this.data = data;
        this.code = "200";
        this.msg = msg;
    }
}
