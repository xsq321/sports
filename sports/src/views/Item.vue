<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home/start' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item :to="{ path: '/home/create' }">运动会</el-breadcrumb-item>
      <el-breadcrumb-item>比赛项目管理</el-breadcrumb-item>
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
        <el-button style="margin-left:10px;" type="primary" @click="add()">添加项目</el-button>
        <!-- 添加项目对话框 -->
        <el-dialog title="添加项目" :visible.sync="addItemVisible">
          <el-form :model='addForm' :rules="rules" class="demo-ruleForm">
            <el-form-item label="运动会名称" :label-width="formLabelWidth">
              <el-input v-model="addForm.sportsname" disabled></el-input>
            </el-form-item>
            <el-form-item label="项目名称" :label-width="formLabelWidth" prop="itemname">
              <el-input v-model="addForm.itemname"></el-input>
            </el-form-item>
            <el-form-item label="比赛地点" :label-width="formLabelWidth" prop="place">
              <el-input v-model="addForm.place"></el-input>
            </el-form-item>
            <el-form-item label="开始时间" :label-width="formLabelWidth" prop="startTime">
              <el-date-picker v-model="addForm.startTime" type="datetime" placeholder="选择日期" value-format="yyyy-MM-ddTHH:mm:ss">
              </el-date-picker>
            </el-form-item>
            <el-form-item label="结束时间" :label-width="formLabelWidth" prop="endTime">
              <el-date-picker v-model="addForm.endTime" type="datetime" placeholder="选择日期" value-format="yyyy-MM-ddTHH:mm:ss">
              </el-date-picker>
            </el-form-item>
            <el-form-item label="记分员" :label-width="formLabelWidth">
              <el-select v-model="addForm.scorer" placeholder="请选择">
                <el-option v-for="item in scorerOptions" :key="item.id" :label="item.username" :value="item.username"></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="最大人数" :label-width="formLabelWidth">
              <el-input v-model="addForm.max"></el-input>
            </el-form-item>
          </el-form>
          <div slot="footer" class="dialog-footer">
            <el-button @click="addItemVisible = false">取 消</el-button>
            <el-button type="primary" @click="addItem">确 定</el-button>
          </div>
        </el-dialog>
      </div>
      <!-- 表格 -->
      <el-table :data="pageData" border stripe style="width: 100%;margin-top: 20px">
        <el-table-column type="index"></el-table-column>
        <el-table-column prop="itemname" label="项目名称" min-width="110px"></el-table-column>
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
        <el-table-column prop="state" label="项目进程" min-width="100px">
          <template slot-scope="scope">
            <span v-text="itemState(scope.row.state)"></span>
          </template>
        </el-table-column>
        <el-table-column prop="scorer" label="记分员"></el-table-column>
        <!-- 操作 -->
        <el-table-column label="操作" min-width="140px">
          <template slot-scope="scope">
            <div>
              <el-button type="primary" icon="el-icon-edit" size="mini" @click="openUpdate(scope.row.id)"></el-button>
              <!-- 修改项目对话框 -->
              <el-dialog title="修改项目" :visible.sync="updateItemVisible">
                <el-form :model='updateForm' :rules="rules" class="demo-ruleForm">
                  <el-form-item label="项目名称" :label-width="formLabelWidth" prop="itemname">
                    <el-input v-model="updateForm.itemname"></el-input>
                  </el-form-item>
                  <el-form-item label="比赛地点" :label-width="formLabelWidth" prop="place">
                    <el-input v-model="updateForm.place"></el-input>
                  </el-form-item>
                  <el-form-item label="开始时间" :label-width="formLabelWidth" prop="startTime">
                    <el-date-picker v-model="updateForm.startTime" type="datetime" value-format="yyyy-MM-dd HH:mm:ss"></el-date-picker>
                  </el-form-item>
                  <el-form-item label="结束时间" :label-width="formLabelWidth" prop="endTime">
                    <el-date-picker v-model="updateForm.endTime" type="datetime" value-format="yyyy-MM-dd HH:mm:ss"></el-date-picker>
                  </el-form-item>
                  <el-form-item label="项目进程" :label-width="formLabelWidth">
                    <el-select v-model="updateForm.state" placeholder="请选择">
                      <el-option label="未开始" value="0"></el-option>
                      <el-option label="报名阶段" value="1"></el-option>
                      <el-option label="比赛阶段" value="2"></el-option>
                      <el-option label="已结束" value="3"></el-option>
                    </el-select>
                  </el-form-item>
                  <el-form-item label="记分员" :label-width="formLabelWidth">
                    <el-select v-model="updateForm.scorer" placeholder="请选择">
                      <el-option v-for="item in scorerOptions" :key="item.id" :label="item.username" :value="item.username"></el-option>
                    </el-select>
                  </el-form-item>
                  <el-form-item label="最大人数" :label-width="formLabelWidth">
                    <el-input v-model="updateForm.max"></el-input>
                  </el-form-item>
                </el-form>
                <div slot="footer" class="dialog-footer">
                  <el-button @click="updateItemVisible = false">取 消</el-button>
                  <el-button type="primary" @click="updateItem">确 定</el-button>
                </div>
              </el-dialog>
              <!-- 删除用户 -->
              <el-button type="danger" icon="el-icon-delete" size="mini" @click="deleteItem(scope.row.id)" style="margin-left:10px;"></el-button>
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
import { getItem, insertItem, deleteItem, updateItem } from '../api/item.js'
import { getSports } from '../api/sports'
import { getUsers } from '../api/user'
export default {
  data () {
    return {
      options: [
        { value: '待加载', label: '待加载...' }
      ],
      scorerOptions: [],
      sportsName: '',
      itemname: '', //用于列表过滤
      itemName: '', //点击查找按钮才赋值，触发计算属性 itemData
      originData: [],
      page: 1,
      pageSize: 10,
      addItemVisible: false,
      updateItemVisible: false,
      formLabelWidth: '120px',
      addForm: {
        sportsname: '',
        itemname: '',
        place: '',
        startTime: '',
        endTime: '',
        scorer: '',
        max: 100
      },
      updateForm: {},
      rules: {
        itemname: [{ required: true, message: '请输入项目名称', trigger: 'blur' }],
        place: [{ required: true, message: '请输入比赛地点', trigger: 'blur' }],
        startTime: [{ required: true, message: '请选择开始时间', trigger: 'blur' }],
        endTime: [{ required: true, message: '请选择结束时间', trigger: 'blur' }],
      }
    }
  },
  methods: {
    change (p) {
      this.page = p
    },
    addItem () {
      if (this.addForm.itemname && this.addForm.startTime && this.addForm.endTime && this.addForm.place) {
        insertItem(this.addForm).then(res => {
          if (res.data.status === 1) {
            this.$router.go(0)
          }
        })
        this.addItemVisible = false
      }
    },
    openUpdate (id) {
      var value = this.pageData.find(e => e.id === id)
      this.updateForm = {
        id: value.id,
        itemname: value.itemname,
        place: value.place,
        startTime: value.startTime,
        endTime: value.endTime,
        state: value.state,
        scorer: value.scorer,
        max: value.max
      }
      this.updateItemVisible = true
    },
    updateItem () {
      updateItem(this.updateForm) //api函数
      this.$router.go(0)
      this.updateItemVisible = false
    },
    async deleteItem (id) {
      const confirmResult = await this.$confirm('此操作将永久删除该比赛项目, 是否继续?', '提示', {
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
        deleteItem(id).then(res => {
          if (res.data.status === 1) this.$router.go(0)
        })
      }
    },
    add () {
      this.addItemVisible = true
      this.addForm.sportsname = this.sportsName
    },
    itemState (s) {
      if (s === 0) return '未开始'
      else if (s === 1) return '报名阶段'
      else if (s === 2) return '比赛阶段'
      else return '已结束'
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
    //动态计算每页的数据
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
  //改变所选运动会时，自动重新渲染表格数据
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
    //获取所有运动会届时供用户选择
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
      //   if (item.sportsname === this.sportsName) return true
      // })
    })
    getUsers().then(res => {
      let users = res.data.data
      this.scorerOptions = users.filter(item => {
        if (item.rank === '记分员' && item.state === 1) return true
      })
    })
  }

}
</script>

<style scoped>
</style>