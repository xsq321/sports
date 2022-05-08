<template>
  <div>
    <el-col>
      <!-- router表示将index作为路由进行跳转 -->
      <el-menu :default-openeds="['3','4','5']" router :default-active="route" class="el-menu-vertical-demo" background-color="#304156" text-color="#BFCBD9" active-text-color="#409EFF">
        <el-menu-item index="start">
          <i class="el-icon-s-home" style="font-size:25px"></i>
          <span class="menu font">首页</span>
        </el-menu-item>
        <el-menu-item index="rank">
          <i class="el-icon-s-custom" style="font-size:25px"></i>
          <span class="menu font">用户管理</span>
        </el-menu-item>
        <el-submenu index="3">
          <template slot="title">
            <i class="el-icon-s-help" style="font-size:25px"></i>
            <span class="menu font">运动会管理</span>
          </template>
          <el-menu-item-group>
            <el-menu-item index="create" class="menu">创建运动会</el-menu-item>
            <el-menu-item index="item" class="menu">比赛项目管理</el-menu-item>
          </el-menu-item-group>
        </el-submenu>
        <el-submenu index="4">
          <template slot="title">
            <i class="el-icon-s-promotion" style="font-size:25px"></i>
            <span class="menu font">参赛管理</span>
          </template>
          <el-menu-item-group>
            <el-menu-item index="join" class="menu">报名管理</el-menu-item>
            <el-menu-item index="player" class="menu">参赛运动员管理</el-menu-item>
          </el-menu-item-group>
        </el-submenu>
        <el-submenu index="5">
          <template slot="title">
            <i class="el-icon-s-claim" style="font-size:25px"></i>
            <span class="menu font">成绩管理</span>
          </template>
          <el-menu-item-group>
            <el-menu-item index="score" class="menu">成绩查看</el-menu-item>
            <el-menu-item index="input" class="menu">成绩录入</el-menu-item>
          </el-menu-item-group>
        </el-submenu>
      </el-menu>
    </el-col>
  </div>
</template>

<script>
export default {
  data () {
    return {

    }
  },
  computed: {
    route: {
      get () {
        return this.$route.fullPath.slice(6)
      }
    }
  },
  mounted () {

  }
}
</script>

<style scoped>
.menu {
  font-size: 20px;
}

.font {
  margin-left: 10px;
}
</style>