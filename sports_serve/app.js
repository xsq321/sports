const express = require('express')
const app = express()
const cors = require('cors')
app.use(cors())
app.use(express.urlencoded({ extended: false }))
app.use(express.json())

const userRouter = require('./router/user.js')
const sportsRouter = require('./router/sports')
const itemRouter = require('./router/item.js')
const scoreRouter = require('./router/score.js')
app.use('/api', userRouter)
app.use('/api', sportsRouter)
app.use('/api', itemRouter)
app.use('/api', scoreRouter)

app.listen(8080, function () {
  console.log('api server running at http://127.0.0.1:8080')
})