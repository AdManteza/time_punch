/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

// Vue Yo!
import Vue from 'vue/dist/vue.esm'

// Turbolinks
import TurbolinksAdapter from 'vue-turbolinks'
Vue.use(TurbolinksAdapter)

// Talk to the backend
import VueResource from 'vue-resource'
Vue.use(VueResource)

// Bootstrap-Vue
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import BootstrapVue from 'bootstrap-vue'
Vue.use(BootstrapVue)

// My components
import clockin from '../time_tracks/clock_in.vue'
import clockout from '../time_tracks/clock_out.vue'
import timetracks from '../time_tracks/index.vue'
import digitalclock from '../digital_clock.vue'
import info from '../info.vue'

// Global events
Vue.prototype.$eventHub = new Vue()

document.addEventListener('turbolinks:load', () => {
  Vue.http.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')

  const app = new Vue({
    el: '[data-behavior="vue"]',
    components: {
      clockin,
      clockout,
      timetracks,
      digitalclock,
      info
    }
  })
})
