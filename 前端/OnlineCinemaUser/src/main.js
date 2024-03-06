// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import 'element-ui/lib/theme-chalk/base.css'
import axios from 'axios'

// axios.defaults.headers.common["token"] = sessionStorage.getItem("token");

Vue.use(ElementUI)
Vue.prototype.$axios = axios  //加载到原型上
Vue.config.productionTip = false

// 全局设置基本路径http://localhost:9000
axios.defaults.baseURL = 'http://localhost:9000'

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>'
})
