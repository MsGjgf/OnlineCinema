import Vue from 'vue'
import Router from 'vue-router'

import Login from '@/pages/Login'

import Admin from '@/pages/Admin'
import ViewUser from '@/components/admin/ViewUser'
import AddUser from '@/components/admin/AddUser'
import ViewMovie from '@/components/admin/ViewMovie'
import AddMovie from '@/components/admin/AddMovie'
import Type from '@/components/admin/Type'

Vue.use(Router)

const router = new Router({
    mode:'history',
    routes:[
        {
            path:'/login',
            name:'登录',
            component:Login
        },
        {
            path:'/admin',
            name:'管理员',
            redirect:'/viewuser',
            component:Admin,
            children:[
                {
                    path:'/viewuser',
                    name:'查看用户信息',
                    component:ViewUser
                },
                {
                    path:'/adduser',
                    name:'添加用户',
                    component:AddUser
                },
                {
                    path:'/viewmovie',
                    name:'查看电影信息',
                    component:ViewMovie,
                },
                {
                    path:'/addmovie',
                    name:'添加电影',
                    component:AddMovie
                },
                {
                    path:'/type',
                    name:'电影类型',
                    component:Type
                }
            ]
        }          
    ]
})

// 路由守卫/路由拦截/导航守卫
router.beforeEach((to, from, next) => {
    //  验证token
    if(sessionStorage.getItem("token") || to.path === "/login"){
        next()
    }else{
        next("/login")
    }
})

export default router