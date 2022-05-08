<template>
  <div id="header">
    <div class="box">
      <i class="el-icon-s-fold"></i>
      <span style="margin-left:10px;">运动会管理系统</span>
    </div>
    <div class="box">
      <el-badge is-dot class="item"><i class="el-icon-bell" id="info"></i></el-badge>
      <el-avatar icon="el-icon-user-solid" :size="30" style="margin-left:20px;"></el-avatar>
      <el-dropdown trigger="click" style="margin-left:5px;">
        <!-- 需动态改变用户名称 -->
        <span class="el-dropdown-link">
          admin<i class="el-icon-arrow-down el-icon--right"></i>
        </span>
        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item>个人中心</el-dropdown-item>
          <el-dropdown-item>首页</el-dropdown-item>
          <el-dropdown-item>修改密码</el-dropdown-item>
          <el-dropdown-item>退出登录</el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
    </div>
  </div>
</template>

<script>
export default {

}
</script>

<style scoped>
#header {
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.box {
  font-size: 20px;
  color: white;
  display: flex;
  align-items: center;
}
#info:hover {
  cursor: pointer;
}
.el-dropdown-link {
  cursor: pointer;
  color: white;
}
</style>