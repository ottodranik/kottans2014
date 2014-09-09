angular.module('App').factory 'auth', ['$rootScope', '$http', '$q', '$window', '$timeout', '$state', ($rootScope, $http, $q, $window, $timeout, $state)->
  # dfd = $q.defer()
  # dfd.resolve(null)

  return {
    authReady: ()->
      $http
        .get '/auth/check.json'
        .then (data)->
          return data

    isLoggedIn: ->
      !!$rootScope.user

    getUser: ->
      $http
        .post '/login.json', $.param(data), {
          headers : { 'Content-Type': 'application/x-www-form-urlencoded' }
        }
        .success (data)->
          $rootScope.user = data
          $window.location.href = '/'

    updateUser: (data)->
      container = {}
      container.user = data
      $http
        .put '/account.json', $.param(container), {
          headers : { 'Content-Type': 'application/x-www-form-urlencoded' }
        }
        .success (data)->
          $rootScope.user = data

    signUp: (data)->
      $http
        .post '/account.json', $.param(data), {
          headers : { 'Content-Type': 'application/x-www-form-urlencoded' }
        }
        .success ->
          $window.location.href = '/'

    signIn: (data)->
      $http
        .post '/login.json', $.param(data), {
          headers : { 'Content-Type': 'application/x-www-form-urlencoded' }
        }
        .success ->
          $window.location.href = '/'

    signOut: ->
      $http
        .get '/logout'
        .then ->
          $rootScope.user = null
          $window.location.href = '/'
  }
]