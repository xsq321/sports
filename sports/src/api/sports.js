import axios from './axios'

//获取运动会列表
export const getSports = () => {
  return axios.request({
    url: '/sports',
    method: 'get',
  })
}
//向数据库表中插入新数据
export const insertSports = (param) => {
  return axios.request({
    url: '/sports',
    method: 'post',
    data: param
  })
}
//删除运动会
export const deleteSports = (id) => {
  return axios.request({
    url: '/sports/delete',
    method: 'post',
    data: { id: id }
  })
}
//修改运动会信息
export const updateSports = (param) => {
  return axios.request({
    url: '/sports/update',
    method: 'post',
    data: param
  })
}