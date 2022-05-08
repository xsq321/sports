import axios from './axios'

//报名：插入数据
export const insertScore = (param) => {
  return axios.request({
    url: '/score',
    method: 'post',
    data: param
  })
}

//取消报名：删除数据
export const deleteScore = (id) => {
  return axios.request({
    url: '/score/delete',
    method: 'post',
    data: { id: id }
  })
}

//获取参赛信息、报名信息表
export const getScore = () => {
  return axios.request({
    url: '/score',
    method: 'get',
  })
}

//成绩录入：修改数据
export const updateScore = (param) => {
  return axios.request({
    url: '/score/update',
    method: 'post',
    data: param
  })
}