<template>
    <div class="index">
        <el-carousel indicator-position="outside">
            <el-carousel-item v-for="item in 4" :key="item">
                <img :src="require(`../../assets/banner/banner${item}.jpg`)" style="width: 100%; height: 100%;"/>
            </el-carousel-item>
        </el-carousel>
        <h3>热门电影推荐</h3>
        <ul>
            <li v-for="item of data" :key="item.id" @click="goDetail(item.id)">
                <el-card shadow="hover">
                    <img :src="item.poster"/>
                    <div class="title">
                        <h3>{{item.name}}</h3>
                        <h4>主演：{{item.director}}</h4>
                    </div>                
                </el-card>           
            </li>
        </ul>
    </div>
</template>

<script>
import axios from 'axios'
export default {
    name:'Index',
    data(){
        return{
            data:[]
        }
    },
    methods:{
        goDetail(id){
            this.$router.push({
                path:'/user/detail',
                query:{id}
            })
        }
    },
    created(){
        axios.get(`/movie/hot?current=1&size=6`).then(res=>{
            this.data = res.data.records
        })
    }
}
</script>

<style scoped>
    /* 轮播图 */
    .el-carousel__item h3 {
        color: #475669;
        font-size: 18px;
        opacity: 0.75;
        line-height: 300px;
        margin: 0;
    }
    
    .el-carousel__item:nth-child(2n) {
        background-color: #99a9bf;
    }
    
    .el-carousel__item:nth-child(2n+1) {
        background-color: #d3dce6;
    }
    /* 热门推荐 */
    ul{
        padding: 0px;
        display: flex;
        justify-content: space-around;
        flex-wrap: wrap;
    }
    ul li{
        margin-bottom: 20px;
    }
    ul li :first-child{
        position: relative;
        background-color: skyblue;
    }
    ul li img{
        width: 300px;
        height: 350px;
    }
    ul li:hover{
        cursor: pointer;
    }
    ul li:hover .title{
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