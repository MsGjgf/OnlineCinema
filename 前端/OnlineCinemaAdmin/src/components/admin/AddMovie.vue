<template>
    <div class="addMovie">
        <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">

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
            </el-form-item>
            
            <el-form-item label="主演" prop="director">
                <el-input v-model="ruleForm.director"></el-input>
            </el-form-item>
            
            <el-form-item label="时长" prop="duration">
                <el-input v-model="ruleForm.duration"></el-input>
            </el-form-item>
            
            <el-form-item label="简介">
                <el-input type="textarea" v-model="ruleForm.description"></el-input>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" @click="submitForm('ruleForm')">立即添加</el-button>
                <el-button @click="resetForm('ruleForm')">重置</el-button>
            </el-form-item>
        </el-form>
    </div>
</template>

<script>
import axios from 'axios';
export default {
    name:'AddMovie',
    data() {
      return {
        typeData:[],
        ruleForm: {
            director: '',
            description:'',
            name:'',
            type:'',
            duration:''
        },
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
      };
    },
    methods: {
        submitForm(formName) {
        this.$refs[formName].validate((valid) => {
          if (valid) {
            this.$axios.post("/movie/insert",this.ruleForm).then(res=>{
                alert(res.data)
                location.reload()
            }).catch(err=>{
                alert("网路异常！")
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