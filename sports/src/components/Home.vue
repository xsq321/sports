<template>
  <el-container id="home">
    <el-header height="50px">
      <Header></Header>
    </el-header>
    <el-container>
      <el-aside width="260px">
        <Aside></Aside>
      </el-aside>
      <el-main>
        <Main></Main>
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
import Header from './common/Header'
import Aside from './Aside'
import Main from './Main'
export default {
  data () {
    return {

    }
  },
  components: {
    Header, Aside, Main
  }
}
</script>

<style scoped>
#home {
  height: 100%;
}
.el-header {
  background-color: rgb(46, 44, 44);
  color: white;
}
.el-aside {
  background-color: #304156;
  color: white;
}
.el-main {
  background-color: #eaedf1;
}
.div {
  height: 100px;
  background-color: white;
}
</style>
