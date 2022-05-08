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
        <el-form-item prop="name">
          <el-input v-model="loginForm.name" prefix-icon="el-icon-user" placeholder="请输入用户名" style="background-color:#bfcbd9"></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input v-model="loginForm.password" type="password" prefix-icon="el-icon-lock" placeholder="请输入密码"></el-input>
        </el-form-item>
        <el-form-item class="footer">
          <el-button type="primary" @click="submitForm(loginForm)">登录</el-button>
          <el-button @click="registerForm(loginForm)" style="margin-left:50px">注册</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script>
export default {
  data () {
    return {
      loginForm: {
        name: '',
        password: ''
      },
      loginRules: {
        name: [
          { required: true, message: '请输入用户名', trigger: 'blur' },
          { min: 3, max: 10, message: '长度在 3 到 10 个字符', trigger: 'blur' }
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' },
          { min: 3, max: 15, message: '长度在 3 到 15 个字符', trigger: 'blur' }
        ],
      }
    }
  },
  methods: {
    submitForm (loginForm) {
      this.$router.push({ path: '/home' })
      console.log(loginForm)
    }
  }
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