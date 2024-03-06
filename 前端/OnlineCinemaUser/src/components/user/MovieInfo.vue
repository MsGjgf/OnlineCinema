<template>
    <div class="movieInfo">
        <h3>类型</h3>
        <el-radio-group v-model="radio" @change="handleChange">
            <el-radio-button v-once label="全部"></el-radio-button>
            <el-radio-button v-for="item of movieType" :label=item.type :key="item.type"></el-radio-button>
        </el-radio-group>
        <div>
            <ul>
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
        <el-pagination style="text-align: center;"
        background
        layout="prev, pager, next"
        :page-size="pageSize"
        :total="total"
        @current-change="page">
        </el-pagination>
    </div>
</template>

<script>
import axios from 'axios'
export default {
    name:'MovieInfo',
    data(){
        return{
            radio:'全部',
            movieType:[],
            movieData:'',
            pageSize:3,
            total:0,
        }
    },
    methods:{
        // 按条件请求电影
        handleChange(){
            axios.get(`/movie/getMovieTypePage?type=${this.radio}&current=1&size=${this.pageSize}`).then(res=>{
                this.movieData = res.data.records
                this.total = res.data.total
            })
        },
        // 按条件分页
        page(currentChange){
            axios.get(`/movie/getMovieTypePage?type=${this.radio}&current=${currentChange}&size=${this.pageSize}`).then(res=>{
                this.movieData = res.data.records
                this.total = res.data.total
            })
        },
        // 进入详情页
        goDetail(id){
            this.$router.push({
                path:'/user/detail',
                query:{id}
            })
        }
    },
    created(){
        //请求所有电影类型
        axios.get(`/type/getTypeAll`).then(res=>{
            this.movieType = res.data
            this.handleChange()
        })
    }
}
</script>

<style scoped>
    ul{
        padding: 0px;
        display: flex;
        justify-content: space-around;
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