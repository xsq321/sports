const express = require('express')
const router = express.Router()
const db = require('../db/index')

router.get('/item', (req, res) => {
  const sql = 'select * from item'
  db.query(sql, (err, results) => {
    res.send({
      data: results
    })
  })
})
//添加
router.post('/item', (req, res) => {
  const sql = 'insert into item set ? '
  //已改为在前端配置
  //日期格式不对，需进行一定操作
  // req.body.startTime = req.body.startTime.slice(0, 16)
  // req.body.endTime = req.body.endTime.slice(0, 16)
  db.query(sql, req.body, (err, results) => {
    // console.log(err)
    res.send({
      status: 1
    })
  })
})
//删除
router.post('/item/delete', (req, res) => {
  const sql = 'delete from item where id=?'
  db.query(sql, req.body.id, (err, results) => {
    res.send({
      status: 1
    })
  })
})
//修改
router.post('/item/update', (req, res) => {
  const sql = 'update item set ? where id=?'
  // req.body.startTime = req.body.startTime.slice(0, 16)
  // req.body.endTime = req.body.endTime.slice(0, 16)
  db.query(sql, [req.body, req.body.id], (err, results) => {
    res.send({
      status: 1
    })
  })
})


module.exports = router