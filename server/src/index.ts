import express from 'express'
import 'dotenv/config'
import  testRouter from './routers/test'

const app = express()

app.use(express.json())
app.use(express.urlencoded({ extended: true }))

app.use('/test',testRouter)

const port = process.env.PORT || 8888
app.listen(port, () => {
    console.log(`Server is running on the port ${port}`)
})