<template>
    <div class="Type">
        <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
        <el-form-item label="电影类型" prop="region">
            <el-select @change="change" v-model="ruleForm.region" placeholder="请选择">
                <el-option v-for="item of typeData" 
                :key="item.id" 
                :label="item.type" 
                :value="item.type">
                </el-option>
            </el-select>
        </el-form-item>
        <el-form-item label="类型修改" prop="name" style="width: 320px;">
            <el-input v-model="ruleForm.name"></el-input>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" @click="submitForm('ruleForm')">立即修改</el-button>
        </el-form-item>
        </el-form>

        添加：<el-input v-model="addType" style="width: 200px;"></el-input>
        <el-button type="primary" @click="add">添加</el-button>
    </div>
</template>

<script>
import axios from 'axios'
export default {
    name:'Type',
    data(){
        return{
            typeData:'',
            typeValue:'',
            addType:'',
            ruleForm: {
                region: '',
                name:''
            },
            rules: {
                name: [
                    { required: true, message: '请输入修改类型', trigger: 'blur' },
                    { min: 2, max: 5, message: '长度在 2 到 5 个字符', trigger: 'blur' }
                ],
                region: [
                    { required: true, message: '请先选择类型', trigger: 'change' }
                ]
            }
        }
    },
    methods:{
        // 下拉框改变时
        change(){
            this.ruleForm.name = this.ruleForm.region
        },
        // 类型修改提交
        submitForm(formName) {
            this.$refs[formName].validate((valid) => {
                if (valid) {
                    axios.post(`/type/postTypeByType?oldType=${this.ruleForm.region}&newType=${this.ruleForm.name}`).then(res=>{
                        if(res.data.code == "200"){
                            this.$message({
                                type:'success',
                                message:res.data.msg
                            })
                        }else{
                            this.$message.error(res.data.msg)
                        }
                        setTimeout(()=>{
                            location.reload()
                        },1000)
                    })
                } else {
                    console.log('error submit!!');
                    return false;
                }
            })
        },
        //  添加
        add(){
            if(this.addType.length<2 || this.addType.length>5){
                this.$message.error("2到5字符")
                return
            }else{
                axios.post(`/type/insertType?type=${this.addType}`).then(res=>{
                    if(res.data.code == "200"){
                        this.$message({
                            type:'success',
                            message:res.data.msg
                        })
                        location.reload()
                    }else{
                        this.$message.error(res.data.msg)
                    }
                })
            }
        }
    },
    created(){
        axios.get(`/type/getTypeAll`).then(res=>{
            this.typeData = res.data
        })
    }
}
</script>

<style>

</style>