<template>
    <div class="search">
        <el-page-header @back="goBack" :content="$route.name"></el-page-header>
        <el-empty v-if="movieData==null" description="暂未收录相关电影"></el-empty>
        <ul v-else>
            <li v-for="item of movieData" :key="item.id" @click="goDetail(item.id)">
                <el-card shadow="hover">
                    <img :src="item.poster"/>
                    <div class="title">
                        <h3>{{item.name}}</h3>
                        <h4>{{item.director}}</h4>
                    </div>                
                </el-card>           
            </li>
        </ul>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    name:"Search",
    data(){
        return{
            movieData:{}
        }
    },
    methods:{
        // 返回上一级路由
        goBack(){
            this.$router.go(-1)
        },
        // 进入详情页
        goDetail(id){
            this.$router.push({
                path:'/user/detail',
                query:{id}
            })
        }
    },
    watch:{
        '$route.query.keyWord':{
            immediate:true,
            deep:true,
            handler(newVal){
                axios.get(`/movie/getMovieSear?keyWord=${newVal}`).then(res=>{
                    this.movieData = res.data.data
                })
            }
        }        
    }
}
</script>

<style scoped>
    ul{
        padding: 0px;
        display: flex;
        justify-content: space-around;
        flex-wrap: wrap;
    }
    ul li :first-child{
        position: relative;
        margin-bottom: 10px;
        background-color: skyblue;
    }
    ul li img{
        width: 300px;
        height: 350px;
    }
    ul li:hover{
        cursor: pointer;
    }
    ul li .title{
        display: block;
    }
    .title{
        display: none;
        position: absolute;
        top: 60%;
        width: 100%;
        background-color: skyblue;
        color: black;
        opacity: 0.9;
        text-align: center;
        font-family: '宋体';
        font-size: 20px;
        font-weight: bold;
    }
</style>