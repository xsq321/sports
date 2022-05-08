<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home/start' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item :to="{ path: '/home/score' }">成绩管理</el-breadcrumb-item>
      <el-breadcrumb-item>成绩录入</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card class="box-card">
      <!-- 头部 -->
      <div id="header">
        <el-select v-model="itemName" clearable placeholder="请选择比赛项目">
          <el-option v-for="item in itemOptions" :key="item.value" :label="item.label" :value="item.value">
          </el-option>
        </el-select>
        <el-button icon="el-icon-search" size="medium" style="margin-left:-2px;padding:10.5px 17px" @click="myFilter"></el-button>
        <el-select v-model="sportsName" clearable placeholder="请选择运动会届时" remote style="margin-left:50px;">
          <el-option v-for="item in sportsOptions" :key="item.value" :label="item.label" :value="item.value">
          </el-option>
        </el-select>
      </div>
      <!-- 表格 -->
      <el-table :data="pageData" border stripe style="width: 100%;margin-top: 20px">
        <el-table-column type="index"></el-table-column>
        <el-table-column prop="username" label="用户名"></el-table-column>
        <el-table-column prop="truename" label="姓名"></el-table-column>
        <el-table-column prop="itemname" label="项目名"></el-table-column>
        <el-table-column prop="scorer" label="记分员"></el-table-column>
        <!-- 操作 -->
        <el-table-column label="成绩" width="230px">
          <template slot-scope="scope">
            <div>
              <!-- 成绩录入 -->
              <el-input v-model="scope.row.score" placeholder="请输入成绩" style="width:120px;margin-right:10px" size="medium"></el-input>
              <el-button type="primary" size="mini" @click="confirm(scope.row.id,scope.row.score)">确认</el-button>
            </div>
          </template>
        </el-table-column>
      </el-table>
      <!-- 分页 -->
      <div class="card-footer">
        <el-pagination @current-change="change" :page-size="pageSize" layout="total, prev, pager, next" :total="total">
        </el-pagination>
      </div>
    </el-card>

  </div>
</template>

<script>
import { getScore, updateScore } from '../api/score'
import { getItem } from '../api/item'
import { getSports } from '../api/sports'
export default {
  data () {
    return {
      itemName: '',
      sportsName: '',
      itemOptions: [],
      sportsOptions: [],
      originData: [],
      scoreData: [],
      scoreData1: [],
      scoreData2: [],
      page: 1,
      pageSize: 10,
    }
  },
  methods: {
    change (p) {
      this.page = p
    },
    myFilter () {
      this.scoreData2 = this.scoreData1.filter((item) => {
        if (item.itemname === this.itemName || !this.itemName) return true
      })
      this.scoreData = this.scoreData2
    },
    confirm (id, score) {
      let obj = {}
      obj.id = id
      obj.score = score
      updateScore(obj).then(res => {
        this.$message({
          type: 'success',
          message: '提交成功，成绩已保存'
        })
      }).catch(err => {
        this.$message({
          type: 'info',
          message: '提交失败'
        })
        console.log(err)
      })
    }
  },
  computed: {
    total: {
      get () {
        return this.scoreData.length
      }
    },
    pageData: {
      get () {
        if (this.scoreData.length > this.pageSize * this.page) {
          return this.scoreData.slice((this.page - 1) * this.pageSize, (this.page - 1) * this.pageSize + this.pageSize)
        } else return this.scoreData.slice((this.page - 1) * this.pageSize)
      }
    },
  },
  watch: {
    sportsName: {
      handler (newValue) {
        this.scoreData1 = this.originData.filter(item => {
          if (item.sportsname === newValue || !newValue) return item
        })
        this.scoreData = this.scoreData1
      },
    }
  },
  created () {
    getItem().then(res => {
      let items = res.data.data
      for (let i = 0; i < items.length; i++) {
        let obj = {}
        obj.value = items[i].itemname
        obj.label = obj.value
        this.itemOptions[i] = obj
      }
      this.itemOptions.reverse()
    })
    getSports().then(res => {
      let sports = res.data.data
      for (let i = 0; i < sports.length; i++) {
        if (sports[i].state === 1) {
          //将sportsName设定初始值，使其默认为当前正在举行的运动会
          this.sportsName = sports[i].sportsname
        }
        let obj = {}
        obj.value = sports[i].sportsname
        obj.label = obj.value
        this.sportsOptions[i] = obj
      }
      this.sportsOptions.reverse()
    })
    getScore().then(res => {
      this.originData = res.data.data
      this.scoreData1 = this.originData.filter(item => {
        if (item.sportsname === this.sportsName) return item
      })
      this.scoreData = this.scoreData1
    })
  }
}
</script>

<style scoped>
</style>