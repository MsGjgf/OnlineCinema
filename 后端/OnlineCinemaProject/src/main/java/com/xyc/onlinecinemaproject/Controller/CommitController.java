package com.xyc.onlinecinemaproject.Controller;

import com.xyc.onlinecinemaproject.Entity.Commit;
import com.xyc.onlinecinemaproject.Mapper.CommitMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/commit")
public class CommitController {

    @Autowired
    private CommitMapper commitMapper;

    /**
     * 通过电影id获取评论和每个评论的用户信息(xml查询)
     */
    @RequestMapping("/getCommitByMovieId")
    public List<Map<String, Object>> getCommitUser(@RequestParam Integer id){
        return commitMapper.getCommitByMovieId(id);
    }

    /**
     * 发起评论
     */
    @PostMapping("/insert")
    public String Insert(@RequestParam Integer uid,@RequestParam Integer mid,@RequestParam String remark){
        if(remark.isBlank()){
            return "内容不能为空！";
        }
        Commit commit = new Commit();
        commit.setUid(uid);
        commit.setMid(mid);
        commit.setRemark(remark);
        commit.setDate(new Date());
        int result = commitMapper.insert(commit);
        if(result>=1){
            return "评论成功！";
        }
        return "评论失败";
    }
}
