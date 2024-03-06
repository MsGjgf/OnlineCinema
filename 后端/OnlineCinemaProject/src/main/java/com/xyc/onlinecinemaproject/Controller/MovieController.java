package com.xyc.onlinecinemaproject.Controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.xyc.onlinecinemaproject.Entity.JsonResult;
import com.xyc.onlinecinemaproject.Entity.Movie;
import com.xyc.onlinecinemaproject.Mapper.MovieMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/movie")
public class MovieController {

    @Autowired
    private MovieMapper movieMapper;

    /**
     * 获取所有电影信息
     */
    @GetMapping("/getMovieAll")
    public List<Movie> getMovieAll(){
        return movieMapper.selectList(null);
    }

    /**
     * 通过id获取电影信息
     */
    @GetMapping("/getMovieById")
    public Movie getUserById(@RequestParam Integer id){
        return movieMapper.selectById(id);
    }

    /**
     * 按类型、当前页、每页数进行获取电影信息
     */
    @GetMapping("/getMovieTypePage")
    public Page<Movie> getMovieTypePage(@RequestParam String type,@RequestParam Integer current,@RequestParam Integer size){
        QueryWrapper<Movie> queryWrapper = new QueryWrapper<>();
        Page<Movie> page = new Page<>(current,size);
        if (type.equals("全部")) {
            movieMapper.selectPage(page,null);
            return page;
        }
        queryWrapper.eq("m_type",type);
        movieMapper.selectPage(page,queryWrapper);
        return page;
    }

    /**
     * 通过关键字获取有关的电影信息
     */
    @GetMapping("getMovieSearch")
    public JsonResult<Page<Movie>> getMovieSearch(@RequestParam String keyWord,@RequestParam Integer current, @RequestParam Integer size){
        QueryWrapper<Movie> queryWrapper = new QueryWrapper<>();
        queryWrapper.like("m_name",keyWord).or()
                    .like("m_director",keyWord).or()
                    .like("m_type",keyWord);
        Page<Movie> page = new Page<>(current, size);
        movieMapper.selectPage(page, queryWrapper);
        return new JsonResult<>(page);
    }

    /**
     * 通过关键字获取有关的电影信息（不分页）
     */
    @GetMapping("getMovieSear")
    public JsonResult<List<Movie>> getMovieSear(@RequestParam String keyWord){
        QueryWrapper<Movie> queryWrapper = new QueryWrapper<>();
        queryWrapper.like("m_name",keyWord).or()
                .like("m_director",keyWord).or()
                .like("m_type",keyWord);
        List<Movie> list = movieMapper.selectList(queryWrapper);
        return new JsonResult<>(list);
    }

    /**
     * 插入电影信息
     */
    @PostMapping("insert")
    public String insertMovie(@RequestBody Movie movie){
        int result = movieMapper.insert(movie);
        if(result>=1){
            return "添加成功！";
        }
        return "添加失败！";
    }

    /**
     * 修改电影信息
     */
    @PutMapping("update")
    public String updateMovie(@RequestBody Movie movie){
        int result = movieMapper.updateById(movie);
        if (result>=1){
            return "修改成功！";
        }
        return "修改失败！";
    }

    /**
     * 删除电影
     */
    @DeleteMapping("/delete")
    public String deleteMovie(@RequestParam Integer id){
        int result = movieMapper.deleteById(id);
        if(result>=1){
            return "删除成功！";
        }
        return "删除失败！";
    }

    /**
     * 热门推荐
     */
    @GetMapping("/hot")
    public Page<Movie> hot(@RequestParam Integer current,@RequestParam Integer size){
        Page<Movie> page = new Page<>(current,size);
        QueryWrapper<Movie> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("m_count");
        movieMapper.selectPage(page,queryWrapper);
        return page;
    }
}
