<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home/start' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item :to="{ path: '/home/create' }">运动会</el-breadcrumb-item>
      <el-breadcrumb-item>创建运动会</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card class="box-card">
      <div id="header">
        <el-input placeholder="请输入运动会名称" clearable style="width:300px" v-model="sportsName">
          <el-button icon="el-icon-search" slot="append" @click="search"></el-button>
        </el-input>
        <el-button style="margin-left:50px;" type="primary" @click="addSportsVisible = true">创建运动会</el-button>
        <!-- 创建运动会对话框 -->
        <el-dialog title="创建运动会" :visible.sync="addSportsVisible">
          <el-form :model='addForm' :rules="rules" class="demo-ruleForm">
            <el-form-item label="运动会名称" :label-width="formLabelWidth" prop="sportsname">
              <el-input v-model="addForm.sportsname"></el-input>
            </el-form-item>
            <el-form-item label="开始时间" :label-width="formLabelWidth" prop="startTime">
              <el-date-picker v-model="addForm.startTime" type="date" placeholder="选择日期" value-format="yyyy-MM-ddTHH:mm:ss">
              </el-date-picker>
            </el-form-item>
            <el-form-item label="预计结束时间" :label-width="formLabelWidth" prop="endTime">
              <el-date-picker v-model="addForm.endTime" type="date" placeholder="选择日期" value-format="yyyy-MM-ddTHH:mm:ss">
              </el-date-picker>
            </el-form-item>
            <el-form-item label="是否开启" :label-width="formLabelWidth">
              <el-select v-model="addForm.state" placeholder="请选择">
                <el-option label="开启" value="1"></el-option>
                <el-option label="结束" value="0"></el-option>
              </el-select>
            </el-form-item>
          </el-form>
          <div slot="footer" class="dialog-footer">
            <el-button @click="addSportsVisible = false">取 消</el-button>
            <el-button type="primary" @click="addSports">确 定</el-button>
          </div>
        </el-dialog>
      </div>
      <!-- 表格 -->
      <el-table :data="pageData" border stripe style="width: 100%;margin-top: 20px">
        <el-table-column type="index"></el-table-column>
        <el-table-column prop="sportsname" label="运动会名称"></el-table-column>
        <el-table-column prop="startTime" label="运动会开始时间">
          <template slot-scope="scope">
            <span v-text="scope.row.startTime.slice(0,10)"></span>
          </template>
        </el-table-column>
        <el-table-column prop="endTime" label="运动会结束时间">
          <template slot-scope="scope">
            <span v-text="scope.row.endTime.slice(0,10)"></span>
          </template>
        </el-table-column>
        <el-table-column prop="state" label="运动会状态">
          <template slot-scope="scope">
            <span v-text="scope.row.state===1?'正在进行':'已结束'"></span>
          </template>
        </el-table-column>
        <!-- 操作 -->
        <el-table-column label="操作" width="150px">
          <template slot-scope="scope">
            <div>
              <el-button type="primary" icon="el-icon-edit" size="mini" @click="openUpdate(scope.row.id)"></el-button>
              <!-- 修改运动会对话框 -->
              <el-dialog title="修改运动会" :visible.sync="updateSportsVisible">
                <el-form :model='updateForm' :rules="rules" class="demo-ruleForm">
                  <el-form-item label="运动会名称" :label-width="formLabelWidth" prop="sportsname">
                    <el-input v-model="updateForm.sportsname"></el-input>
                  </el-form-item>
                  <el-form-item label="开始时间" :label-width="formLabelWidth" prop="startTime" value-format="yyyy-MM-dd HH:mm:ss">
                    <el-date-picker v-model="updateForm.startTime" type="date"></el-date-picker>
                  </el-form-item>
                  <el-form-item label="结束时间" :label-width="formLabelWidth" prop="endTime" value-format="yyyy-MM-dd HH:mm:ss">
                    <el-date-picker v-model="updateForm.endTime" type="date"></el-date-picker>
                  </el-form-item>
                  <el-form-item label="是否开启" :label-width="formLabelWidth">
                    <el-select v-model="updateForm.state" placeholder="请选择">
                      <el-option label="开启" value="1"></el-option>
                      <el-option label="结束" value="0"></el-option>
                    </el-select>
                  </el-form-item>
                </el-form>
                <div slot="footer" class="dialog-footer">
                  <el-button @click="updateSportsVisible = false">取 消</el-button>
                  <el-button type="primary" @click="updateSports">确 定</el-button>
                </div>
              </el-dialog>
              <!-- 删除用户 -->
              <el-button type="danger" icon="el-icon-delete" size="mini" @click="deleteSports(scope.row.id)" style="margin-left:10px;"></el-button>
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
import { getSports, insertSports, deleteSports, updateSports } from '../api/sports.js'
export default {
  data () {
    return {
      sportsName: '', //用于列表过滤
      sportsData: [], originData: [],
      page: 1,
      pageSize: 10,
      addSportsVisible: false,
      updateSportsVisible: false,
      formLabelWidth: '120px',
      addForm: {
        sportsname: '',
        startTime: '',
        endTime: '',
        state: 1
      },
      updateForm: {},
      rules: {
        sportsname: [{ required: true, message: '请输入运动会名称', trigger: 'blur' }],
        startTime: [{ required: true, message: '请选择开始时间', trigger: 'blur' }],
        endTime: [{ required: true, message: '请选择结束时间', trigger: 'blur' }],
      }
    }
  },
  methods: {
    change (p) {
      this.page = p
    },
    addSports () {
      if (this.addForm.sportsname && this.addForm.startTime && this.addForm.endTime) {
        insertSports(this.addForm).then(res => {
          if (res.data.status === 1) {
            this.$router.go(0)
          }
        })
        this.addSportsVisible = false
      }
    },
    openUpdate (id) {
      var value = this.pageData.find(e => e.id === id)
      this.updateForm = {
        id: value.id,
        sportsname: value.sportsname,
        startTime: value.startTime,
        endTime: value.endTime,
        state: value.state,
      }
      this.updateSportsVisible = true
    },
    updateSports () {
      updateSports(this.updateForm) //api函数
      this.$router.go(0)
      this.updateSportsVisible = false
    },
    async deleteSports (id) {
      const confirmResult = await this.$confirm('此操作将永久删除该届运动会, 是否继续?', '提示', {
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
        deleteSports(id).then(res => {
          if (res.data.status === 1) this.$router.go(0)
        })
      }
    },
    search () {
      this.sportsData = this.sportsData1.filter(item => {
        if (item.sportsname === this.sportsName || !this.sportsName) return true
      })
    }
  },
  computed: {
    total: {
      get () {
        return this.sportsData.length
      }
    },
    //动态计算每页的数据
    pageData: {
      get () {
        if (this.sportsData.length > this.pageSize * this.page) {
          return this.sportsData.slice((this.page - 1) * this.pageSize, (this.page - 1) * this.pageSize + this.pageSize)
        } else return this.sportsData.slice((this.page - 1) * this.pageSize)
      }
    },
  },
  created () {
    getSports().then(res => {
      this.originData = res.data.data
      this.originData.reverse()
      this.sportsData = this.originData
      this.sportsData1 = this.originData
    })
  }
}
</script>

<style scoped>
</style>