const express = require('express')
const router = express.Router()
const db = require('../db/index')

//获取
router.get('/score', (req, res) => {
  const sql = 'select * from score'
  db.query(sql, (err, results) => {
    res.send({
      data: results
    })
  })
})
//插入
router.post('/score', (req, res) => {
  const sql = 'insert into score set ?'
  db.query(sql, req.body, (err, results) => {
    res.send({
      status: 1
    })
  })
})
//删除
router.post('/score/delete', (req, res) => {
  const sql = 'delete from score where id=?'
  db.query(sql, req.body.id, (err, results) => {
    res.send({
      status: 1
    })
  })
})
//修改
router.post('/score/update', (req, res) => {
  const sql = 'update score set ? where id=?'
  db.query(sql, [req.body, req.body.id], (err, results) => {
    res.send({
      status: 1
    })
  })
})

module.exports = router