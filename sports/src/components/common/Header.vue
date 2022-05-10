<template>
  <div id="header">
    <div class="box">
      <i class="el-icon-s-fold"></i>
      <span style="margin-left:10px;">运动会管理系统</span>
    </div>
    <div class="box">
      <el-badge is-dot class="item"><i class="el-icon-bell" id="info" @click="visible = true"></i></el-badge>
      <el-dialog title="查看消息" :visible.sync="visible">
        <el-table :data="messageDate">
          <el-table-column property="send" label="发布者" width="150"></el-table-column>
          <el-table-column property="receive" label="接收者" width="200"></el-table-column>
          <el-table-column property="message" label="信息内容"></el-table-column>
        </el-table>
        <el-button type="primary" style="margin:20px auto" v-if="isAdmin||isScorer">发布信息</el-button>
      </el-dialog>
      <el-avatar icon="el-icon-user-solid" :size="30" style="margin-left:20px;"></el-avatar>
      <el-dropdown trigger="click" style="margin-left:5px;">
        <!-- 需动态改变用户名称 -->
        <span class="el-dropdown-link">
          {{user.username}}<i class="el-icon-arrow-down el-icon--right"></i>
        </span>
        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item>个人中心</el-dropdown-item>
          <el-dropdown-item>修改密码</el-dropdown-item>
          <el-dropdown-item @click="exit()">退出登录</el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      user: {},
      visible: false,
      isAdmin: false,
      isScorer: false,
      isPlayer: false,
      messageDate: [
        { send: 'admin', receive: '所有运动员', message: '第一届运动会已结束，感谢大家的参与' },
        { send: 'admin', receive: '所有运动员', message: '第一届运动会正在进行中' },
        { send: 'admin', receive: '所有运动员', message: '第一届运动会正在报名中' },
      ]
    }
  },
  methods: {
    exit () {
      console.log('skdjfi')
      this.$router.push({ path: '/login' })
    }
  },
  created () {
    let val = this.$store.state.user
    if (val.id) {
      sessionStorage.setItem('user', JSON.stringify(val))
    }
    this.user = JSON.parse(sessionStorage.getItem('user'))

    let rank = this.user.rank
    if (rank === '超级管理员') {
      this.isAdmin = true
    } else if (rank === '记分员') {
      this.isScorer = true
    } else {
      this.isPlayer = true
    }
  }
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