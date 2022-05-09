import axios from './axios'

export const getUsers = () => {
  return axios.request({
    url: '/user',
    method: 'get',
  })
}

export const insertUser = (param) => {
  return axios.request({
    url: '/user',
    method: 'post',
    data: param
  })
}

export const deleteUser = (id) => {
  return axios.request({
    url: '/user/delete',
    method: 'post',
    data: { id: id }
  })
}

export const updateUser = (param) => {
  return axios.request({
    url: '/user/update',
    method: 'post',
    data: param
  })
}
//注意是getUser，因为只能获取到一条用户数据
export const getUser = (param) => {
  return axios.request({
    url: '/user/login',
    method: 'post',
    data: param
  })
}