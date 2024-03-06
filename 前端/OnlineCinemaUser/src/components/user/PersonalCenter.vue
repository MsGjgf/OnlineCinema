<template>
    <div class="personalCenter">
        <h1>个人中心</h1>
        <hr>
        <ul>
            <li><span>头像：</span>
                <el-avatar shape="square" :size="50" :src="personData.url"></el-avatar>
                <el-upload style="border: 1px solid #999; float:right; margin-right: 25%; border-radius: 5px; text-align: center; line-height: 50px; width: 50px; height: 50px;"
                    class="avatar-uploader"
                    action="http://localhost:9000/file/upload"
                    :data={type:0,id:personData.id,}
                    :show-file-list="false"
                    :on-success="handleAvatarSuccessImage"
                    :before-upload="beforeAvatarUploadImage">
                    <img v-if="imageUrl" :src="imageUrl" class="avatar">
                    <i v-else class="el-icon-plus avatar-uploader-icon" title="替换头像"></i>
                </el-upload>
            </li>
            <li><span>用户名：</span>{{personData.account}}</li>
            <li><span>密码：</span>{{personData.passWord}}</li>
            <li><span>手机号：</span>{{personData.phone}}</li>
            <li><span>地址：</span>{{personData.address}}</li>
            <li><button @click="edit">修改信息</button></li>
        </ul>
        
        <!-- 内嵌Form -->
        <el-dialog title="修改信息" :visible.sync="dialogFormVisible">
            <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
                <el-form-item label="ID">
                    <el-input v-model="ruleForm.id" :disabled="true"></el-input>
                </el-form-item>

                <el-form-item label="用户名" prop="account">
                    <el-input v-model="ruleForm.account"></el-input>
                </el-form-item>
                
                <el-form-item label="密码" prop="passWord">
                    <el-input v-model="ruleForm.passWord" autocomplete="off"></el-input>
                </el-form-item>
                
                <el-form-item label="手机号码" prop="phone">
                    <el-input v-model="ruleForm.phone"></el-input>
                </el-form-item>
                
                <el-form-item label="地址">
                    <el-input v-model="ruleForm.address"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="closeDia">取 消</el-button>
                <el-button type="primary" @click="submitForm('ruleForm')">确 定</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
import axios from 'axios'
export default {
    name:"PersonalCenter",
    data(){
        return{
            personData:'',
            imageUrl: '',
            dialogFormVisible: false,
            // 表单数据
            ruleForm: {
                id:'',
                url:'',
                account: '',
                passWord:'',
                phone:'',
                address:''
            },
            // 规则校验
            rules: {
            account: [
                { required: true, message: '不能为空', trigger: 'blur' },
                { min: 3, max: 8, message: '长度在 3 到 8 个字符', trigger: 'blur' }
            ],
            passWord: [
                { required: true, message: '不能为空', trigger: 'blur' },
                { min:6 ,max:18,message:'长度在 6 到 18 个字符', trigger: 'blur' }
            ],
            phone:[
                {required:true,message:'不能为空',trigger:'blur'},
                {min:11,max:11,message:'手机号长度为11',trigger:'blur'}
            ]
            }
        }
    },
    methods:{
        // 取消操作
        closeDia(){
            this.dialogFormVisible = false
            location.reload()
        },
        // 编辑操作
        edit(){
            this.dialogFormVisible = true
            this.ruleForm = this.personData
        },
        //修改
        submitForm(formName) {
            this.$refs[formName].validate((valid) => {
                if (valid) {
                    axios.put(`/user/update`,this.ruleForm).then(res=>{
                        alert(res.data)
                        location.reload()
                    }).catch(err=>{
                        alert("用户名已存在！")
                        location.reload()
                    })
                } else {
                    console.log('error submit!!');
                    return false;
                }
            });
        },
        // 头像上传是否成功
        handleAvatarSuccessImage(res, file) {
            if(res.code == "200"){
                this.$message({
                    message:res.msg,
                    type:'success'
                })
            }else{
                this.$message.error(res.msg)
                return
            }   
        // this.imageUrl = URL.createObjectURL(file.raw);
        this.$axios.get("/movie/findAll").then((res)=>{
            this.test = res.data
            // this.imageUrl = ''      //上传完毕后置空
        })
        setTimeout(()=>{
            location.reload()
        },1000)
        },
        //   对上传文件进行校验
        beforeAvatarUploadImage(file) {
        const isJPG = file.type === 'image/jpeg';
        const isLt2M = file.size / 1024 / 1024 < 2;

        if (!isJPG) {
            this.$message.error('上传头像图片只能是 JPG 格式!');
        }
        if (!isLt2M) {
            this.$message.error('上传头像图片大小不能超过 2MB!');
        }
        return isJPG && isLt2M;
        },
    },
    created(){
        axios.get(`/user/getUserById?id=${sessionStorage.getItem("userInfo")}`).then(res=>{
            this.personData = res.data.data
        })
    }
}
</script>

<style scoped>
    ul,li,h1{
        margin: auto;
        width: 300px;
    }
    ul li span{
        display: inline-block;
        width: 100px;
        height: 50px;
        line-height: 50px;
        text-align: left;
    }
    button{
        float: right;
        margin-top: 14px;
    }
    .avatar-uploader .el-upload {
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }
  .avatar-uploader .el-upload:hover {
    border-color: #409EFF;
  }
  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 50px;
    height: 50px;
    line-height: 50px;
    text-align: center;
  }
  .avatar {
    width: 50px;
    height: 50px;
    display: inline-block;
  }
</style>