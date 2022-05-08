const express = require('express')
const router = express.Router()
const db = require('../db/index')

//查找用户列表
router.get('/user', (req, res) => {
  const sql = 'select * from users'
  db.query(sql, (err, results) => {
    res.send({
      data: results
    })
  })
})
//添加用户列表
router.post('/user', (req, res) => {
  const sql = 'insert into users set ?'
  db.query(sql, req.body, (err, results) => {
    res.send({
      status: 1
    })
  })
})
//删除
router.post('/user/delete', (req, res) => {
  const sql = 'delete from users where id=?'
  db.query(sql, req.body.id, (err, results) => {
    res.send({
      status: 1
    })
  })
})
//更新
router.post('/user/update', (req, res) => {
  const sql = 'update users set ? where id=?'
  db.query(sql, [req.body, req.body.id], (err, results) => {
    res.send({
      status: 1
    })
  })
})

module.exports = router