import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../components/Home.vue'
import Login from '../components/Login.vue'
import Start from '../views/Start.vue'
import Rank from '../views/Rank.vue'
import CreateSports from '../views/CreateSports.vue'
import Item from '../views/Item'
import Join from '../views/Join'
import Input from '../views/Input'
import Score from '../views/Score'
import Player from '../views/Player'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    redirect: '/login'
  },
  {
    path: '/login',
    name: 'login',
    component: Login
  },
  {
    path: '/home',
    name: 'home',
    component: Home,
    children: [
      {
        path: '',
        redirect: 'start'
      },
      {
        path: 'start',
        component: Start
      },
      {
        path: 'rank',
        component: Rank
      },
      {
        path: 'create',
        component: CreateSports
      },
      {
        path: 'item',
        component: Item
      },
      {
        path: 'join',
        component: Join
      },
      {
        path: 'input',
        component: Input
      },
      {
        path: 'score',
        component: Score
      },
      {
        path: 'player',
        component: Player
      }
    ]
  }
]

const router = new VueRouter({
  routes
})

export default router
