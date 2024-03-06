<template>
    <div class="viewMovie">
        <div class="search">
            <el-input placeholder="请输入电影名、类型、主演等关键字" v-model.trim.lazy="searchValue" clearable style="width: 400px;"></el-input>
            <el-button @click="search" type="info">筛选</el-button>
            <el-button @click="showAll" type="info">全部</el-button>
        </div>
        <el-table :data="tableData" style="width: 100%">

            <el-table-column label="Id" width="80">
            <template slot-scope="scope">
                <span>{{ scope.row.id }}</span>
            </template>
            </el-table-column>

            <el-table-column label="海报" width="80">
            <template slot-scope="scope">
                <div class="block">
                    <el-avatar v-if="scope.row.poster=='http://localhost:9000/images/default.jpg'" shape="square" :size="50" :src="scope.row.poster"></el-avatar>
                    <img v-else :src="scope.row.poster" style="width: 100%; height: 100%;" />
                </div>
            </template>
            </el-table-column>
            
            <el-table-column label="类型" width="80">
            <template slot-scope="scope">
                <span>{{ scope.row.type }}</span>
            </template>
            </el-table-column>

            <el-table-column label="电影名" width="80">
            <template slot-scope="scope">
                <span>{{ scope.row.name }}</span>
            </template>
            </el-table-column>

            <el-table-column label="主演" width="80">
            <template slot-scope="scope">
                <span>{{ scope.row.director }}</span>
            </template>
            </el-table-column>

            <el-table-column label="时长" width="80">
            <template slot-scope="scope">
                <span>{{ scope.row.duration }}分钟</span>
            </template>
            </el-table-column>

            <el-table-column label="点击量" width="80">
            <template slot-scope="scope">
                <span>{{ scope.row.count }}</span>
            </template>
            </el-table-column>

            <el-table-column label="简介" width="180">
            <template slot-scope="scope">
                <span>{{ scope.row.description }}</span>
            </template>
            </el-table-column>

            <el-table-column label="电影" width="100">
            <template slot-scope="scope">
                <video :src="scope.row.url" controls width="100px" height="100px"></video>
            </template>
            </el-table-column>

            <el-table-column label="上传海报" width="80">
            <template slot-scope="scope">
                <span>
                    <el-upload style="border: 1px solid #999; border-radius: 5px; text-align: center; line-height: 50px; width: 50px; height: 50px;"
                    class="avatar-uploader"
                    action="http://localhost:9000/file/upload"
                    :data={type:1,id:scope.row.id,}
                    :show-file-list="false"
                    :on-success="handleAvatarSuccessImage"
                    :before-upload="beforeAvatarUploadImage">
                    <img v-if="imageUrl" :src="imageUrl" class="avatar">
                    <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                    </el-upload>
                </span>
            </template>
            </el-table-column>

            <el-table-column label="上传电影" width="80">
            <template slot-scope="scope">
                    <el-upload style="border: 1px solid #999; border-radius: 5px; text-align: center; line-height: 50px; width: 50px; height: 50px;"
                    class="avatar-uploader"
                    action="http://localhost:9000/file/upload"
                    multiple
                    :data={type:2,id:scope.row.id,}
                    :show-file-list="false"
                    :on-success="handleAvatarSuccessVideo"
                    :before-upload="beforeAvatarUploadVideo">
                    <i class="el-icon-plus avatar-uploader-icon"></i>
                    </el-upload>
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
        <!-- :current-page.sync="currentPage"设置当前页 -->
        <el-pagination style="text-align: center;"
        background
        layout="prev, pager, next"
        :current-page.sync="currentPage"
        :page-size="pageSize"
        :total="total"
        @current-change="page">
        </el-pagination>

        <!-- 内嵌Form -->
        <el-dialog title="电影信息修改" :visible.sync="dialogFormVisible">
            <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
            
            <el-form-item label="ID">
                <el-input v-model="ruleForm.id" :disabled="true"></el-input>
            </el-form-item>

            <el-form-item label="电影名" prop="name">
                <el-input v-model="ruleForm.name"></el-input>
            </el-form-item>

            <el-form-item label="类型" prop="type">
                <el-select v-model="ruleForm.type" placeholder="请选择">
                    <el-option
                    v-for="item in typeData"
                    :key="item.id"
                    :label="item.type"
                    :value="item.type">
                    </el-option>
                </el-select>
                <!-- <el-input v-model="ruleForm.type"></el-input> -->
            </el-form-item>
            
            <el-form-item label="导演" prop="director">
                <el-input v-model="ruleForm.director"></el-input>
            </el-form-item>
            
            <el-form-item label="时长" prop="duration">
                <el-input v-model="ruleForm.duration"></el-input>
            </el-form-item>
            
            <el-form-item label="简介">
                <el-input v-model="ruleForm.description"></el-input>
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
import axios from 'axios';
export default {
    name:'ViewMovie',
    data() {
      return {
        tableData: [],  //电影信息
        typeData:[],    //电影类型
        imageUrl: '',
        dialogImageUrl: '',
        dialogFormVisible: false,
        searchValue:'', //筛选关键字（前端自用<-*****）
        keyWord:'',     //筛选关键字（传给后端->*****）
        // 表单数据
        ruleForm: {
            id:'',
            url:'',
            director: '',
            description:'',
            count:'',
            name:'',
            type:'',
            duration:'',
            poster:''
        },
        pageSize:5,
        total:0,
        currentPage:'', //当前页
        // 规则校验
        rules: {
            name: [
            { required: true, message: '不能为空', trigger: 'blur' },
            ],
            type: [
            { required: true, message: '不能为空', trigger: 'blur' },
            ],
            director: [
            { required: true, message: '不能为空', trigger: 'blur' },
            ],
            duration: [
            { required: true, message: '不能为空', trigger: 'blur' },
            ]
        }
      }
    },
    methods:{
        // 海报上传是否成功
        handleAvatarSuccessImage(res, file) {
        this.$message({
            message:res,
            type:'success'
        })
        this.imageUrl = URL.createObjectURL(file.raw);
        this.$axios.get("/movie/findAll").then((res)=>{
            this.test = res.data
        })
        setTimeout(()=>{
            // location.reload()
            this.page(this.currentPage)
            this.imageUrl = ''
        },1000)
        },
        //   对上传文件进行校验
        beforeAvatarUploadImage(file) {
        const isJPG = file.type === 'image/jpeg';
        const isLt2M = file.size / 1024 / 1024 < 2;

        if (!isJPG) {
            this.$message.error('上传海报图片只能是 JPG 格式!');
        }
        if (!isLt2M) {
            this.$message.error('上传海报图片大小不能超过 2MB!');
        }
        return isJPG && isLt2M;
        },
        // 视频上传是否成功
        handleAvatarSuccessVideo(res,file){
        this.$message({
            message:res,
            type:'success'
        })
        window.location.reload()  //重载
        },
        //   对上传文件进行校验
        beforeAvatarUploadVideo(file) {
        const isMP4 = file.type === 'video/mp4';

        if (!isMP4) {
            this.$message.error('上传视频只能是 MP4 格式!');
        }
        return isMP4;
        },
        //分页
        page(currentChange){
            this.currentPage = currentChange
            this.$axios.get(`/movie/getMovieSearch?keyWord=${this.keyWord}&current=${this.currentPage}&size=${this.pageSize}`).then(res=>{
                this.tableData = res.data.data.records
                this.total = res.data.data.total
                console.log(this.currentPage)
            })
        },
        //编辑
        handleEdit(index, row) {
            this.dialogFormVisible = true  //打开弹层
            function movieData(id){
                return axios.get(`/movie/getMovieById?id=`+id)
            }
            function typeData(){
                return axios.get(`/type/getTypeAll`)
            }
            axios.all([movieData(row.id),typeData()]).then(axios.spread((movieData,typeData)=>{
                this.ruleForm = movieData.data
                this.typeData = typeData.data
                console.log(movieData,typeData)
            }))
        },
        //修改
        submitForm(formName) {
        this.$refs[formName].validate((valid) => {
          if (valid) {
            this.$axios.put("/movie/update",this.ruleForm).then(res=>{
                alert(res.data)
                this.page(this.currentPage)
                this.dialogFormVisible = false  //关闭弹层
            })
          } else {
            console.log('error submit!!');
            return false;
          }
        });
      },
        //删除
        handleDelete(index, row) {
            this.$axios.delete(`/movie/delete?id=${row.id}`).then(res=>{
                alert(res.data)
                location.reload()
            }).catch(res=>{
                console.log(res.data)
            })
        },
        // 筛选
        search(){
            if(this.searchValue == ""){
                this.$message({
                    type:'warning',
                    message:'不能为空哦*>0_0<*'
                })
                return
            }
            this.keyWord = this.searchValue
            this.page(1)
        },
        // 显示全部
        showAll(){
            location.reload()
        }
    },
    created(){
        this.keyWord = ''
        this.page(1)
    }
}
</script>

<style scoped>
    
</style>