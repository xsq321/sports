const mysql = require('mysql')
//建立连接池
const db = mysql.createPool({
  host: '127.0.0.1',
  user: 'root',
  password: 'admin123',
  database: 'sports',
  //设置时区
  timezone: "08:00"
})
module.exports = db