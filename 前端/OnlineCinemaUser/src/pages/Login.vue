<template>
    <div class="login">
        <h1 style="text-align: center;">欢迎登录</h1>
        <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
            <el-form-item label="用户名" prop="userName" style="width: 350px;">
                <el-input v-model.trim="ruleForm.userName"></el-input>
            </el-form-item>
            <el-form-item label="密码" prop="passWord" style="width: 350px;">
                <el-input v-model.trim="ruleForm.passWord" type="password"></el-input>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" @click="submitForm('ruleForm')">立即登录</el-button>
                <el-button @click="resetForm('ruleForm')">重置</el-button>
                <el-button style="margin: auto;" type="primary" @click="register">去注册</el-button>
            </el-form-item>
            
        </el-form>
    </div>
</template>

<script>
export default {
    name:'Login',
    data() {
      return {
        ruleForm: {
            userName:'',
            passWord:''
        },
        rules: {
          userName: [
            { required: true, message: '请输入用户名', trigger: 'blur' },
            { min: 3, max: 5, message: '长度在 3 到 5 个字符', trigger: 'blur' }
          ],
          passWord: [
            { required: true, message: '请输入密码', trigger: 'blur' },
            { min: 6, max: 12, message: '长度在 6 到 12 个字符', trigger: 'blur' }
          ]
        }
      };
    },
    methods: {
      register(){
        this.$router.push("/register")
      },
      submitForm(formName) {
        this.$refs[formName].validate((valid) => {
          if (valid) {
            this.$axios.post(`/loginUser?userName=${this.ruleForm.userName}&passWord=${this.ruleForm.passWord}`).then(res=>{
                if(res.data.code == "200"){
                    this.$message({
                        type:"success",
                        message:res.data.msg
                    })
                    sessionStorage.setItem("token",res.data.data.token)
                    sessionStorage.setItem("userInfo",res.data.data.id)
                    this.$router.push('/user')
                }else{
                    this.$message.error(res.data.msg)
                }
            })
          } else {
            console.log('error submit!!');
            return false;
          }
        });
      },
      resetForm(formName) {
        this.$refs[formName].resetFields();
      }
    }
}
</script>

<style>
    .demo-ruleForm{
        position: absolute;
        top: 20%;
        left: 35%;
    }
</style>