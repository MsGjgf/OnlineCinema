package com.xyc.onlinecinemaproject.Controller;

import com.xyc.onlinecinemaproject.Entity.JsonResult;
import com.xyc.onlinecinemaproject.Entity.Movie;
import com.xyc.onlinecinemaproject.Entity.User;
import com.xyc.onlinecinemaproject.Mapper.MovieMapper;
import com.xyc.onlinecinemaproject.Mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.system.ApplicationHome;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

@Controller
@RequestMapping("/file")
public class FileController {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private MovieMapper movieMapper;

    @RequestMapping("/upload")
    @ResponseBody
    public JsonResult<Map<String,Object>> upload(@RequestParam("file")MultipartFile file, @RequestParam Integer id, @RequestParam Integer type){
        //获取原始名字
        String fileName = file.getOriginalFilename();
//        获取后缀名
        String suffixName = fileName.substring(fileName.lastIndexOf("."));
        //判断后缀名类型
        String dir = "";
        Set<String> typeSet = new HashSet<>();
        typeSet.add(".jpg");
        if(typeSet.contains(suffixName)){
            dir = "images";
        }
        typeSet.clear();
        typeSet.add(".mp4");
        if (typeSet.contains(suffixName)){
            dir = "movie";
        }
        if (dir.isEmpty()) {
            return new JsonResult<>("0","格式不正确");
        }
        /************前方高能*************/
        //通过this.getClass()
        ApplicationHome applicationHome = new ApplicationHome(this.getClass());
        //通过getDir获取target/classes文件，getParentFile获取上一级
        String pre = applicationHome.getDir().getParentFile().getParentFile().getAbsolutePath()
                + "\\src\\main\\resources\\static\\"+dir+"\\";
        //文件保存路径
        String filePath = pre;
        //文件重命名，防止重复
        String flag = UUID.randomUUID() + fileName;
        fileName = filePath + flag;
        //文件对象
        File dest = new File(fileName);
        //判断路径是否存在，如果不存在则创建
        if(!dest.getParentFile().exists()){
            dest.getParentFile().mkdirs();
        }
        try{
            //保存到服务器中
            file.transferTo(dest);
            if (type==0){                   //0代表用户头像
                User user = new User();
                user.setId(id);
                user.setUrl("http://localhost:9000/"+dir+"/"+flag);
                userMapper.updateById(user);
            }else if (type==1){             //1代表海报
                Movie movie = new Movie();
                movie.setId(id);
                movie.setPoster("http://localhost:9000/"+dir+"/"+flag);
                movieMapper.updateById(movie);
            } else if (type==2) {           //2代表电影
                Movie movie = new Movie();
                movie.setId(id);
                movie.setUrl("http://localhost:9000/"+dir+"/"+flag);
                movieMapper.updateById(movie);
            }
            return new JsonResult<>("200","上传成功");
        }catch (Exception e){
            e.printStackTrace();
        }
        return new JsonResult<>("0","上传失败");
    }
}
