<template>
    <div class="viewUser">
        <el-table :data="tableData" style="width: 100%">

            <el-table-column label="Id" width="80">
            <template slot-scope="scope">
                <span>{{ scope.row.id }}</span>
            </template>
            </el-table-column>

            <el-table-column label="头像" width="120">
            <template slot-scope="scope">
                <div class="block"><el-avatar shape="square" :size="50" :src="scope.row.url"></el-avatar></div>
            </template>
            </el-table-column>
            
            <el-table-column label="用户名" width="120">
            <template slot-scope="scope">
                <span>{{ scope.row.account }}</span>
            </template>
            </el-table-column>

            <el-table-column label="密码" width="120">
            <template slot-scope="scope">
                <span>{{ scope.row.passWord }}</span>
            </template>
            </el-table-column>

            <el-table-column label="手机号" width="180">
            <template slot-scope="scope">
                <span>{{ scope.row.phone }}</span>
            </template>
            </el-table-column>

            <el-table-column label="地址" width="180">
            <template slot-scope="scope">
                <span>{{ scope.row.address }}</span>
            </template>
            </el-table-column>

            <el-table-column label="上传" width="80">
            <template slot-scope="scope">
                <span>
                    <el-upload style="border: 1px solid #999; border-radius: 5px; text-align: center; line-height: 50px; width: 50px; height: 50px;"
                    class="avatar-uploader"
                    action="http://localhost:9000/file/upload"
                    :data={type:0,id:scope.row.id,}
                    :show-file-list="false"
                    :on-success="handleAvatarSuccessImage"
                    :before-upload="beforeAvatarUploadImage">
                    <img v-if="imageUrl" :src="imageUrl" class="avatar">
                    <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                    </el-upload>
                </span>
            </template>
            </el-table-column>

            <el-table-column label="操作">
            <template slot-scope="scope">
                <el-button size="mini" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
                <el-button size="mini" type="danger" @click="handleDelete(scope.$index, scope.row)">删除</el-button>
            </template>
            </el-table-column>

        </el-table>

        <!-- 分页组件 -->
        <el-pagination style="text-align: center;"
        background
        layout="prev, pager, next"
        :page-size="pageSize"
        :total="total"
        @current-change="page">
        </el-pagination>

        <!-- 内嵌Form -->
        <el-dialog title="用户信息修改" :visible.sync="dialogFormVisible">
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
                <el-button @click="dialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="submitForm('ruleForm')">确 定</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
export default {
    name:'ViewUser',
    data() {
      return {
        tableData: [],
        imageUrl: '',
        dialogImageUrl: '',
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
        pageSize:5,
        total:0,
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
        // 头像上传是否成功
        handleAvatarSuccessImage(res, file) {
        this.$message({
            message:res,
            type:'success'
        })
        this.imageUrl = URL.createObjectURL(file.raw);
        this.$axios.get("/movie/findAll").then((res)=>{
            this.test = res.data
            this.imageUrl = ''      //上传完毕后置空
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
        //分页
        page(currentChange){
            this.$axios.get(`/user/page?current=${currentChange}&size=${this.pageSize}`).then(res=>{
                this.tableData = res.data.records
                this.total = res.data.total
            })
        },
        //编辑
        handleEdit(index, row) {
            console.log(row.id);
            this.dialogFormVisible = true  //打开弹层
            this.$axios.get(`/user/getUserById?id=${row.id}`).then(res=>{
                this.ruleForm = res.data.data
            })
        },
        //删除
        handleDelete(index, row) {
            this.$axios.delete(`/user/delete?id=${row.id}`).then(res=>{
                alert(res.data)
                location.reload()
            })
        },
        //修改
        submitForm(formName) {
            this.$refs[formName].validate((valid) => {
                if (valid) {
                    this.$axios.put("/user/update",this.ruleForm).then(res=>{
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
        }
    },
    created(){
        this.page(1)
    }
}
</script>

<style scoped>
    
</style>