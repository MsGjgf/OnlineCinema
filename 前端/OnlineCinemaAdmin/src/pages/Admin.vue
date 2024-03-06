<template>
  <div class="admin">
    <i class="el-icon-close" @click="exit" style="position: absolute; left: 95%; font-size: 50px; cursor: pointer;"></i>
    <h1 style="text-align: center; font-family:STLiti; font-size:50px">Welcome to online cinema system!</h1>
    <hr>
    <el-container style="height: auto; min-height: 500px;">
      <el-aside>
      <el-menu router default-active="1" class="el-menu-vertical-demo" @open="handleOpen" @close="handleClose">
        
        <el-submenu index="1">
          <template slot="title"><i class="el-icon-user"></i><span>用户管理</span></template>
            <el-menu-item index="/viewuser">查看用户信息</el-menu-item>
            <el-menu-item index="/adduser">添加用户</el-menu-item>
        </el-submenu>
        
        <el-submenu index="2">
          <template slot="title"><i class="el-icon-video-camera"></i><span>电影管理</span></template>
            <el-menu-item index="/viewmovie">查看电影信息</el-menu-item>
            <el-menu-item index="/addmovie">上传电影</el-menu-item>
        </el-submenu>
        
        <el-menu-item index="/type">
          <i class="el-icon-s-grid"></i><span slot="title">电影类型</span>
        </el-menu-item>
      
      </el-menu>
      </el-aside>

      <el-main>
        <router-view></router-view>
      </el-main>
      
    </el-container>
  </div>
</template>

<script>
export default {
  name:"Admin",
  methods:{
      handleOpen(key, keyPath) {
        console.log(key, keyPath);
      },
      handleClose(key, keyPath) {
        console.log(key, keyPath);
      },
      exit(){
        sessionStorage.clear()
        this.$message({
          type:'success',
          message:'退出成功！'
        })
        this.$router.push("/login")
      }
  }
}
</script>

<style>

</style>