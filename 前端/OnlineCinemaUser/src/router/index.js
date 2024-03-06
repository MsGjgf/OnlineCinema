import Vue from 'vue'
import Router from 'vue-router'

import Register from '@/pages/Register'
import Login from '@/pages/Login'

import User from '@/pages/User'
import Index from '@/components/user/Index'
import MovieInfo from '@/components/user/MovieInfo'
import PersonalCenter from '@/components/user/PersonalCenter'
import Detail from '@/components/user/Detail'
import Search from '@/components/user/Search'

Vue.use(Router)

const router = new Router({
    mode:'history',
    routes:[
        {
            path:'/register',
            name:'注册',
            component:Register
        },
        {
            path:'/login',
            name:'登录',
            component:Login
        },
        {
            path:'/user',
            name:'用户',
            redirect:'/index',
            component:User,
            children:[
                {
                    path:'/index',
                    name:'首页',
                    component:Index
                },
                {
                    path:'/movieinfo',
                    name:'电影信息',
                    component:MovieInfo
                },
                {
                    path:'/search',
                    name:'搜索结果',
                    component:Search
                },
                {
                    path:'/person',
                    name:'个人中心',
                    component:PersonalCenter
                },
                {
                    path:'detail',
                    name:'电影详情',
                    component:Detail
                }
            ]
        }           
    ]
})

// 路由守卫/路由拦截/导航守卫
router.beforeEach((to, from, next) => {
    //  验证token
    if(sessionStorage.getItem("token") || to.path === "/login" || to.path === "/register"){
        next()
    }else{
        next("/login")
    }
})

export default router