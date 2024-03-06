<template>
    <div class="addUser">
        <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
            <el-form-item label="用户名" prop="account">
                <el-input v-model="ruleForm.account"></el-input>
            </el-form-item>
            
            <el-form-item label="密码" prop="passWord">
                <el-input type="password" v-model="ruleForm.passWord" autocomplete="off"></el-input>
            </el-form-item>
            
            <el-form-item label="手机号码" prop="phone">
                <el-input v-model="ruleForm.phone"></el-input>
            </el-form-item>
            
            <el-form-item label="地址">
                <el-input v-model="ruleForm.address"></el-input>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" @click="submitForm('ruleForm')">立即添加</el-button>
                <el-button @click="resetForm('ruleForm')">重置</el-button>
            </el-form-item>
        </el-form>
    </div>
</template>

<script>
export default {
    name:'AddUser',
    data() {
      return {
        ruleForm: {
          account: '',
          passWord:'',
          phone:'',
          address:''
        },
        rules: {
          account: [
            { required: true, message: '请输入用户名', trigger: 'blur' },
            { min: 3, max: 5, message: '长度在 3 到 5 个字符', trigger: 'blur' }
          ],
          passWord: [
            { required: true, message: '请输入密码', trigger: 'blur' },
            { min: 6, max: 12, message: '长度在 6 到 12 个字符', trigger: 'blur' }
          ],
          phone: [
            { required: true, message: '请输入手机号', trigger: 'blur' },
            { min: 11, max: 11, message: '长度在为11个字符', trigger: 'blur' }
          ]
        }
      };
    },
    methods: {
        submitForm(formName) {
        this.$refs[formName].validate((valid) => {
          if (valid) {
            this.$axios.post("/user/insert",this.ruleForm).then(res=>{
                alert(res.data)
                location.reload()
            }).catch(err=>{
                alert("用户名已存在！")
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

</style>