const express = require('express')
const router = express.Router()
const db = require('../db/index')

router.get('/sports', (req, res) => {
  const sql = 'select * from sports'
  db.query(sql, (err, results) => {
    res.send({
      data: results
    })
  })
})
//添加
router.post('/sports', (req, res) => {
  const sql = 'insert into sports set ? '
  //日期格式不对，需进行一定操作
  // req.body.startTime = req.body.startTime.slice(0, 10)
  // req.body.endTime = req.body.endTime.slice(0, 10)
  db.query(sql, req.body, (err, results) => {
    // console.log(err)
    res.send({
      status: 1
    })
  })
})
//删除
router.post('/sports/delete', (req, res) => {
  const sql = 'delete from sports where id=?'
  db.query(sql, req.body.id, (err, results) => {
    res.send({
      status: 1
    })
  })
})
//修改
router.post('/sports/update', (req, res) => {
  const sql = 'update sports set ? where id=?'
  // req.body.startTime = req.body.startTime.slice(0, 10)
  // req.body.endTime = req.body.endTime.slice(0, 10)
  db.query(sql, [req.body, req.body.id], (err, results) => {
    res.send({
      status: 1
    })
  })
})


module.exports = router