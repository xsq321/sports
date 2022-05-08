<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home/start' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item :to="{ path: '/home/join' }">参赛管理</el-breadcrumb-item>
      <el-breadcrumb-item>报名管理</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card class="box-card">
      <div id="header">
        <el-input placeholder="请输入项目名称" clearable style="width:300px" v-model="itemname">
          <el-button icon="el-icon-search" slot="append" @click="search"></el-button>
        </el-input>
        <el-select v-model="sportsName" clearable placeholder="请选择运动会届时" remote style="margin-left:50px;">
          <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value">
          </el-option>
        </el-select>
      </div>
      <!-- 表格 -->
      <el-table :data="pageData" border stripe style="width: 100%;margin-top: 20px">
        <el-table-column type="index"></el-table-column>
        <el-table-column prop="itemname" label="项目名称"></el-table-column>
        <el-table-column prop="place" label="比赛地点" min-width="120px"></el-table-column>
        <el-table-column prop="startTime" label="开始时间" min-width="170px">
          <template slot-scope="scope">
            <span v-text="scope.row.startTime.slice(0,16)"></span>
          </template>
        </el-table-column>
        <el-table-column prop="endTime" label="结束时间" min-width="170px">
          <template slot-scope="scope">
            <span v-text="scope.row.endTime.slice(0,16)"></span>
          </template>
        </el-table-column>
        <el-table-column prop="state" label="是否可报名">
          <template slot-scope="scope">
            <span v-text="itemState(scope.row.state)"></span>
          </template>
        </el-table-column>
        <!-- 操作 -->
        <el-table-column label="操作">
          <template slot-scope="scope">
            <div>
              <el-button type="primary" size="mini" @click="openJoin(scope.row.id)" :disabled="scope.row.state===1?false:true">报名</el-button>
              <!-- 报名对话框 -->
              <el-dialog title="报名" :visible.sync="joinVisible">
                <el-form :model='joinForm' :rules="rules" class="demo-ruleForm">
                  <el-form-item label="用户名/学号" :label-width="formLabelWidth" prop="username">
                    <el-input v-model="joinForm.username"></el-input>
                  </el-form-item>
                  <el-form-item label="姓名" :label-width="formLabelWidth" prop="truename">
                    <el-input v-model="joinForm.truename"></el-input>
                  </el-form-item>
                  <el-form-item label="项目名称" :label-width="formLabelWidth" prop="itemname">
                    <el-input v-model="joinForm.itemname"></el-input>
                  </el-form-item>
                </el-form>
                <div slot="footer" class="dialog-footer">
                  <el-button @click="joinVisible = false">取 消</el-button>
                  <el-button type="primary" @click="insertJoin()">确 定</el-button>
                </div>
              </el-dialog>
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
import { getItem } from '../api/item'
import { getSports } from '../api/sports'
import { insertScore } from '../api/score'
export default {
  data () {
    return {
      itemName: '',
      itemname: '',
      sportsName: '',
      options: [],
      page: 1,
      pageSize: 10,
      originData: [],
      joinForm: {},
      joinVisible: false,
      formLabelWidth: '120px',
      rules: {
        username: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
        truename: [{ required: true, message: '请输入真实姓名', trigger: 'blur' }],
        itemname: [{ required: true, message: '请输入项目名', trigger: 'blur' }],
      }
    }
  },
  methods: {
    change (p) {
      this.page = p
    },
    openJoin (id) {
      var value = this.pageData.find(e => e.id === id)
      this.joinForm = {
        username: '',
        truename: '',
        sportsname: value.sportsname,
        itemname: value.itemname,
        scorer: value.scorer
      }
      this.joinVisible = true
    },
    itemState (s) {
      if (s === 0) return '否（未开始）'
      else if (s === 1) return '是'
      else if (s === 2) return '否（比赛阶段）'
      else return '否（已结束）'
    },
    insertJoin () {
      insertScore(this.joinForm)  //api函数
      this.$router.go(0)
      this.joinVisible = false
    },
    search () {
      this.itemName = this.itemname
    }
  },
  computed: {
    total: {
      get () {
        return this.itemData.length
      }
    },
    pageData: {
      get () {
        if (this.itemData.length > this.pageSize * this.page) {
          return this.itemData.slice((this.page - 1) * this.pageSize, (this.page - 1) * this.pageSize + this.pageSize)
        } else return this.itemData.slice((this.page - 1) * this.pageSize)
      }
    },
    itemData: {
      get () {
        return this.originData.filter(item => {
          if ((item.sportsname === this.sportsName || !this.sportsName) && (item.itemname === this.itemName || !this.itemName)) return true
        })
      }
    }
  },
  // watch: {
  //   sportsName: {
  //     handler (newValue) {
  //       this.itemData = this.originData.filter(item => {
  //         if (item.sportsname === newValue || !newValue) return item
  //       })
  //     }
  //   }
  // },
  created () {
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
        this.options[i] = obj
      }
      this.options.reverse()
    })
    getItem().then(res => {
      this.originData = res.data.data
      this.originData.reverse()
      // this.itemData = this.originData.filter(item => {
      //   if (item.sportsname === this.sportsName) return item
      // })
    })
  }
}
</script>

<style scoped>
</style>