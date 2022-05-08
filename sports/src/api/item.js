import axios from './axios'

export const getItem = () => {
  return axios.request({
    url: '/item',
    method: 'get',
  })
}

export const insertItem = (param) => {
  return axios.request({
    url: '/item',
    method: 'post',
    data: param
  })
}

export const deleteItem = (id) => {
  return axios.request({
    url: '/item/delete',
    method: 'post',
    data: { id: id }
  })
}

export const updateItem = (param) => {
  return axios.request({
    url: '/item/update',
    method: 'post',
    data: param
  })
}