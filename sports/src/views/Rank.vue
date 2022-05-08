<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home/start' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>用户管理</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card class="box-card">
      <!-- 头部 -->
      <div id="header">
        <el-select v-model="value" clearable placeholder="请选择权限等级">
          <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value">
          </el-option>
        </el-select>
        <el-button icon="el-icon-search" size="medium" style="margin-left:-2px;padding:10.5px 17px" @click="myFilter"></el-button>
        <el-button style="margin-left:50px;" type="primary" @click="addUserVisible = true">添加用户</el-button>
        <!-- 添加用户对话框 -->
        <el-dialog title="添加用户" :visible.sync="addUserVisible">
          <el-form :model='addForm' :rules="rules" class="demo-ruleForm">
            <el-form-item label="用户名" :label-width="formLabelWidth" prop="username">
              <el-input v-model="addForm.username"></el-input>
            </el-form-item>
            <el-form-item label="密码" :label-width="formLabelWidth" prop="password">
              <el-input v-model="addForm.password"></el-input>
            </el-form-item>
            <el-form-item label="姓名" :label-width="formLabelWidth">
              <el-input v-model="addForm.truename"></el-input>
            </el-form-item>
            <el-form-item label="权限" :label-width="formLabelWidth" prop="rank">
              <el-select v-model="addForm.rank" placeholder="请选择权限">
                <el-option label="超级管理员" value="超级管理员"></el-option>
                <el-option label="记分员" value="记分员"></el-option>
                <el-option label="运动员" value="运动员"></el-option>
              </el-select>
            </el-form-item>
          </el-form>
          <div slot="footer" class="dialog-footer">
            <el-button @click="addUserVisible = false">取 消</el-button>
            <el-button type="primary" @click="addUser">确 定</el-button>
          </div>
        </el-dialog>
      </div>
      <!-- 用户列表表格 -->
      <el-table :data="pageData" border stripe style="width: 100%;margin-top: 20px">
        <el-table-column type="index"></el-table-column>
        <el-table-column prop="username" label="用户名"></el-table-column>
        <el-table-column prop="password" label="密码"></el-table-column>
        <el-table-column prop="truename" label="姓名"></el-table-column>
        <el-table-column prop="rank" label="权限"></el-table-column>
        <el-table-column prop="state" label="状态">
          <template slot-scope="scope">
            <el-switch v-model="scope.row.state" :disabled="scope.row.id===1?true:false">
            </el-switch>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="150px">
          <template slot-scope="scope">
            <div>
              <el-button type="primary" icon="el-icon-edit" size="mini" @click="openUpdate(scope.row.id)" :disabled="scope.row.id===1?true:false"></el-button>
              <!-- 修改用户对话框 -->
              <el-dialog title="修改用户" :visible.sync="updateUserVisible">
                <el-form :model='updateForm' :rules="rules" class="demo-ruleForm">
                  <el-form-item label="用户名" :label-width="formLabelWidth" prop="username">
                    <el-input v-model="updateForm.username"></el-input>
                  </el-form-item>
                  <el-form-item label="密码" :label-width="formLabelWidth" prop="password">
                    <el-input v-model="updateForm.password"></el-input>
                  </el-form-item>
                  <el-form-item label="姓名" :label-width="formLabelWidth">
                    <el-input v-model="updateForm.truename"></el-input>
                  </el-form-item>
                  <el-form-item label="权限" :label-width="formLabelWidth" prop="rank">
                    <el-select v-model="updateForm.rank" placeholder="请选择权限">
                      <el-option label="超级管理员" value="超级管理员"></el-option>
                      <el-option label="记分员" value="记分员"></el-option>
                      <el-option label="运动员" value="运动员"></el-option>
                    </el-select>
                  </el-form-item>
                </el-form>
                <div slot="footer" class="dialog-footer">
                  <el-button @click="updateUserVisible = false">取 消</el-button>
                  <el-button type="primary" @click="updateUser">确 定</el-button>
                </div>
              </el-dialog>
              <!-- 删除用户 -->
              <el-button type="danger" icon="el-icon-delete" size="mini" @click="deleteUser(scope.row.id)" style="margin-left:10px;" :disabled="scope.row.id===1?true:false"></el-button>
            </div>
          </template>
        </el-table-column>
      </el-table>
      <!-- 分页功能 -->
      <div class="card-footer">
        <el-pagination @current-change="change" :page-size="pageSize" layout="total, prev, pager, next" :total="total">
        </el-pagination>
      </div>
    </el-card>
  </div>
</template>

<script>
import { getUsers, insertUser, deleteUser, updateUser } from '../api/user.js'
// import axios from 'axios'
export default {
  data () {
    return {
      options: [
        { value: '超级管理员', label: '超级管理员' },
        { value: '记分员', label: '计分员' },
        { value: '运动员', label: '运动员' }
      ],
      value: '', //代表权限等级，用于列表过滤
      userData: [
        { id: 1, username: 'admin', password: '123456', rank: '超级管理员', } //测试数据
      ],
      originData: [],
      page: 1,
      pageSize: 10,
      //添加用户数据
      addUserVisible: false,
      updateUserVisible: false,
      formLabelWidth: '120px',
      addForm: {
        username: '',
        password: '',
        rank: '运动员',
        truename: '',
      },
      updateForm: {},
      rules: {
        username: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
        password: [{ required: true, message: '请输入密码', trigger: 'blur' }],
        rank: [{ required: true, message: '请选择权限等级', trigger: 'change' }]
      }
    }
  },
  methods: {
    change (p) {
      this.page = p
    },
    myFilter () {
      this.userData = this.originData.filter((item) => {
        if (item.rank === this.value || !this.value) return true
      })
    },
    //添加用户
    addUser () {
      if (this.addForm.username && this.addForm.password) {
        insertUser(this.addForm).then(res => {
          if (res.data.status === 1) {
            this.$router.go(0)
          }
        })
        this.addUserVisible = false
      }
    },
    //打开修改用户对话框是，传入id改变updateForm的值
    openUpdate (id) {
      var value = this.pageData.find(e => e.id === id)
      this.updateForm = {
        id: value.id,
        username: value.username,
        password: value.password,
        rank: value.rank,
        truename: value.truename,
      }
      this.updateUserVisible = true
    },
    updateUser () {
      updateUser(this.updateForm) //api函数
      this.$router.go(0)
      this.updateUserVisible = false
    },
    async deleteUser (id) {
      const confirmResult = await this.$confirm('此操作将永久删除该用户, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then((con) => {
        this.$message({
          type: 'success',
          message: '删除成功!'
        })
        return con
      }).catch((err) => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
        return err
      });
      if (confirmResult === 'confirm') {
        deleteUser(id).then(res => {
          if (res.data.status === 1) this.$router.go(0)
        })
      }
    }
  },
  computed: {
    total: {
      get () {
        return this.userData.length
      }
    },
    //动态计算每页的数据
    pageData: {
      get () {
        if (this.userData.length > this.pageSize * this.page) {
          return this.userData.slice((this.page - 1) * this.pageSize, (this.page - 1) * this.pageSize + this.pageSize)
        } else return this.userData.slice((this.page - 1) * this.pageSize)
      }
    },
  },
  created () {
    getUsers().then(res => {
      for (let i = 0; i < res.data.data.length; i++) {
        res.data.data[i].state = res.data.data[i].state ? true : false
      }//mysql不能使用boolean值，只能通过1,0来进行代替
      this.originData = res.data.data
      this.userData = this.originData
    })
  }
}
</script>

<style>
.box-card {
  margin-top: 10px;
}
.card-footer {
  margin-top: 10px;
}
</style>