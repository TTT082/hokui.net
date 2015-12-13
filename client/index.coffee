require './style/index.sass'


(require './lib/font') 'Source Sans Pro': true


Vue = require 'vue'
Vue.config.debug = process.env.NODE_ENV isnt 'production'

Vue.use require 'vue-validator'
Vue.use require 'vue-resource'

console.log Vue.http.transforms
# Vue.http.transforms.request.push (options)->
#     options
#
# Vue.http.transforms.response.push (response)->
#     console.log response
#     response


Vue.use require './lib/router'
Vue.use require './lib/token'
Vue.use require './lib/auth'
Vue.use require './lib/loader'
Vue.use require './lib/toast'
# Vue.use require './lib/responsive'
Vue.use require './lib/resolver'
#
# # Vue.use require './component/change'
# Vue.use require './component/date-bind'
# Vue.use require './component/date-format'
# Vue.use require './component/date-badge'
# Vue.use require './component/model-delete'
# Vue.use require './component/editable'
# Vue.use require './component/loading'
# Vue.use require './component/modal'
#
Vue.router.route require './route'

(require './handler') Vue

app = new Vue
    el: '#app'
    template: '<div v-view="root"></div>'

start = ->
    Vue.router.start()
    Vue.loader false

if Vue.token.exists()
    Vue.loader()
    Vue.resolver.append Vue.auth.check().then start, start
else
    Vue.nextTick start