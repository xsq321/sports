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
//通过用户名和密码获取用户数据
router.post('/user/login', (req, res) => {
  const sql = 'select * from users where username=? and password=?'
  db.query(sql, [req.body.username, req.body.password], (err, results) => {
    if (results.length === 1) {
      res.send({
        status: 0, //0表示成功，1表示失败
        data: results
      })
    } else {
      res.send({
        status: 1,
        msg: '账号密码错误'
      })
    }
  })
})

module.exports = router