<template>
    <div class="user">      
        <ul class="nav">
            <li><router-link to="/index">首页</router-link></li>
            <li><router-link to="/movieinfo">电影信息</router-link></li>
            <li>
                <el-input placeholder="请输入关键字" v-model.trim="searchValue" style="width: 200px; height: 0px;">
                    <el-button @click="search" slot="append" icon="el-icon-search"></el-button>
                </el-input>
            </li>
            <li><router-link to="/person">个人中心</router-link></li>
            <li @click="exit" @mouseover="shutDown=true" @mouseleave="shutDown=false" style=" width: 50px; position: absolute; left: 95%; cursor: pointer;">
                <el-avatar :size="50" :src="userData.url"></el-avatar>
                <i v-show="shutDown" class="el-icon-switch-button" style="position: absolute; right: 1%; font-size: 50px; background-color: rgba(250,250,250,0.3); color: #999; border-radius: 50px;"></i>
            </li>
        </ul>
        <div class="container">
            <keep-alive include="MovieInfo">
                <router-view></router-view>
            </keep-alive>
        </div>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    name:'User',
    data(){
        return{
            userData:'',
            shutDown:false,
            searchValue:'',

        }
    },
    methods:{
        // 搜索
        search(){
            if(this.searchValue == ""){
                this.$message({
                    showClose:true,
                    message:"请输入关键字"
                })
                return
            }
            this.$router.push({
                path:'/search',
                query:{
                    keyWord:this.searchValue
                }
            })
        },
        
        // 退出登录
        exit(){
            sessionStorage.clear()
            this.$router.push("/login")
            this.$message({
                message:"退出成功！",
                type:'success'
            })
        }
    },
    created(){
        axios.get(`/user/getUserById?id=`+sessionStorage.getItem("userInfo")).then(res=>{
            this.userData = res.data.data
        })
    }
}
</script>

<style scoped>
    .user{
        min-width: 1000px;
        max-width: 1500px;
        margin: 0px auto;
    }
    .nav{
        display: flex;
        justify-content: space-around;
        background-color: skyblue;
        position: relative;
    }
    .nav li{
        width: 250px;
        height: 50px;
        line-height: 50px;
    }
    .container{
        margin: 0px auto;
        min-width: 800px;
        max-width: 1200px;
        background-color: #F6F6F6;
    }
</style>