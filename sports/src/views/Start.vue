<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item>首页</el-breadcrumb-item>
    </el-breadcrumb>

    <el-card class="box-card">
      欢迎： <el-link type="primary">{{user.rank}}</el-link> {{user.username}}
    </el-card>
  </div>
</template>

<script>
export default {
  data () {
    return {
      user: {}
    }
  },
  created () {
    this.user = JSON.parse(sessionStorage.getItem('user'))
  }
}
</script>

<style scoped>
.box-card {
  margin-top: 10px;
  font-size: 20px;
}
</style>