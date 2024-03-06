<template>
    <div class="detail">
        <el-page-header @back="goBack" :content="$route.name"></el-page-header>
        <ul class="box">
            <li class="box-right" style="position: relative;">
                <img class="play" @click="play" src="../../assets/play.png">
                <img :src="movieData.poster" style="width: 100%; height: 100%;">
            </li>
            <li class="box-left">
                <div class="description">
                    <h3>电影名：《{{movieData.name}}》</h3>
                    <h3>类型：{{movieData.type}}</h3>
                    <h3>导演：{{movieData.director}}</h3>
                    <h3>时长：{{movieData.duration}}分钟</h3>
                    <p>简介：{{movieData.description}}</p>
                    <p>点击量：{{movieData.count}}</p>
                </div>
                <div class="remark">
                    <el-input
                    type="textarea"
                    placeholder="请输入你的评论"
                    v-model="remark"
                    maxlength="30"
                    show-word-limit>
                    </el-input>
                    <el-button @click="remarkPost(movieData.id)" type="primary">评论</el-button>
                </div>
            </li>
        </ul>
        <div class="commit">
            <h3>本片评论</h3>
            <li v-for="item of remarkData" :key="item.id">
                <!-- 头像 -->
                <p>
                    <el-avatar :size="50" :src="item.u_url"></el-avatar>
                    <span>{{item.u_account}}</span>
                </p>
                <p style="margin-left: 50px;"><b>{{item.remark}}</b></p>
                <p style="text-align: right;"><i>评论于——{{item.m_date}}</i></p>
                <hr/>      
            </li>
        </div>
    </div>
</template>

<script>
import axios from 'axios'
export default {
    name:"Detail",
    data(){
        return{
            movieData:'',
            remarkData:'',
            remark:''
        }
    },
    methods: {
        // 回退
        goBack() {
            this.$router.go(-1)
        },

        // 播放视频
        play(){
            this.$alert(`<h2>${this.movieData.name}</h2><video ref="video" src="${this.movieData.url}" controls autoplay width="100%" height="100%"></video>`,{
                dangerouslyUseHTMLString:true,
                showConfirmButton: false
            }).catch(()=>{
                window.location.reload()
            })
        },

        // 发起评论
        remarkPost(mid){
            this.$axios.post(`/commit/insert?uid=${sessionStorage.getItem("userInfo")}&mid=${mid}&remark=${this.remark}`).then(res=>{
                if(res.status == 200){
                    this.$message({
                        message:res.data,
                        type:'success'
                    })
                    this.remark = ''
                    //更新数据
                    function getMovie(id){
                        return axios.get(`movie/getMovieById?id=${id}`);
                    }
                    function getRemark(id){
                        return axios.get(`/commit/getCommitByMovieId?id=${id}`);
                    }
                    this.$axios.all([getMovie(this.$route.query.id),getRemark(this.$route.query.id)]).then(axios.spread((resMovie,resRemark)=>{
                        this.movieData = resMovie.data
                        this.remarkData = resRemark.data
                    }))
                }else{
                    this.$message.error(res.data)
                }
            })
        }
    },
    created(){
        function getMovie(id){
            return axios.get(`movie/getMovieById?id=${id}`);
        }
        function getRemark(id){
            return axios.get(`/commit/getCommitByMovieId?id=${id}`);
        }
        this.$axios.all([getMovie(this.$route.query.id),getRemark(this.$route.query.id)]).then(axios.spread((resMovie,resRemark)=>{
            this.movieData = resMovie.data
            this.remarkData = resRemark.data
        }))
    }
}
</script>

<style>
    .box{
        display: flex;
        justify-content: center;
    }
    .box-right{
        width: 300px;
        height: 400px;
    }
    .box-left{
        padding: 0px 20px;
    }
    .commit{
        width: 780px;
        /* background-color: #FFFFFF; */
        margin: 0px auto;
    }
    .play{
        width: 100px;
        position:absolute;
        top: 40%;
        left: 40%;
        transition: 0.5s;
    }
    .play:hover{
        cursor: pointer;
        transform: scale(1.2);
    }
    .el-message-box{
        width: 1200px;
        height: 700px;
    }
</style>