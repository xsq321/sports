<template>
  <div id="login">
    <div id="logo">
      <i class="el-icon-bicycle"></i>
      运动会管理系统
    </div>
    <el-card class="box-card">
      <div class="header">
        用户登录
      </div>
      <el-form :model="loginForm" :rules="loginRules">
        <el-form-item prop="username">
          <el-input v-model="loginForm.username" prefix-icon="el-icon-user" placeholder="请输入用户名" style="background-color:#bfcbd9"></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input v-model="loginForm.password" type="password" prefix-icon="el-icon-lock" placeholder="请输入密码"></el-input>
        </el-form-item>
        <el-form-item class="footer">
          <el-button type="primary" @click="submitForm()">登录</el-button>
          <el-button style="margin-left:50px" @click="registerVisible=true">注册</el-button>
        </el-form-item>
      </el-form>
    </el-card>
    <!-- 注册对话框 -->
    <el-dialog title="注册" :visible.sync="registerVisible">
      <el-form :model='registerForm' :rules="rules" class="demo-ruleForm">
        <el-form-item label="用户名" :label-width="formLabelWidth" prop="username">
          <el-input v-model="registerForm.username"></el-input>
        </el-form-item>
        <el-form-item label="密码" :label-width="formLabelWidth" prop="password">
          <el-input v-model="registerForm.password"></el-input>
        </el-form-item>
        <el-form-item label="姓名" :label-width="formLabelWidth" prop="truename">
          <el-input v-model="registerForm.truename"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="registerVisible = false">取 消</el-button>
        <el-button type="primary" @click="register">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { getUser, insertUser } from '../api/user'
export default {
  data () {
    return {
      loginForm: {
        username: '',
        password: ''
      },
      loginRules: {
        username: [
          { required: true, message: '请输入用户名', trigger: 'blur' },
          { min: 3, max: 10, message: '长度在 3 到 10 个字符', trigger: 'blur' }
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' },
          { min: 3, max: 15, message: '长度在 3 到 15 个字符', trigger: 'blur' }
        ],
      },
      registerVisible: false,
      registerForm: {
        username: '',
        password: '',
        rank: '运动员',
        truename: '',
      },
      rules: {
        username: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
        password: [{ required: true, message: '请输入密码', trigger: 'blur' }],
        truename: [{ required: true, message: '请输入真实姓名', trigger: 'blur' }]
      },
      formLabelWidth: '120px',
    }
  },
  methods: {
    submitForm () {
      getUser(this.loginForm).then(res => {
        if (res.data.status === 0) {
          let user = res.data.data[0]
          //登录成功时，修改vuex中user的值，实现数据通信
          this.$store.commit('setUser', user)
          this.$message({
            message: '登录成功',
            type: 'success'
          })
          this.$router.push({ path: '/home' })
        } else {
          this.$message.error('登录失败，请检查用户名与密码')
        }
      })
    },
    register () {
      if (this.registerForm.username && this.registerForm.password && this.registerForm.truename) {
        // 注册就相当于向users表中添加用户
        insertUser(this.registerForm).then(res => {
          if (res.data.status === 1) {
            this.$message({
              message: '注册成功',
              type: 'success'
            })
          }
        })
        this.registerVisible = false
      }
    }
  },
}
</script>

<style scoped>
#logo {
  font-size: 30px;
  position: absolute;
  top: 30px;
  left: 100px;
  color: white;
}
.header {
  font-size: 25px;
  margin-bottom: 30px;
  text-align: center;
}
#login {
  width: 100%;
  height: 100%;
  background-color: #304156;
}
.box-card {
  width: 400px;
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
  background-color: #bfcbd9;
}
.footer {
  display: flex;
  justify-content: center;
}
.el-input {
  font-size: 16px;
}
.el-icon-bicycle {
  font-size: 30px;
}
</style>