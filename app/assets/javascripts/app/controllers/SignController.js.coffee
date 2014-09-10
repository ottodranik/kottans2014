App.controller 'SignController', ['$scope', 'auth', 'modal', '$rootScope', ($scope, auth, modal, $rootScope)->

  $scope.messages = {}
  $scope.formData = { user: {} }

  $scope.signUp = ->
    auth
      .signUp $scope.formData
      .success (data)=>
        $scope.messages[0] = 'Регистрация прошла успешно'
      .error (data)=>
        $scope.messages = {}
        if data.success?
          $scope.messages[0] = data.message
        else
          i = 0
          for own key, value of data
            for own key2, value2 of value
              $scope.messages[i] = key + ': ' + value2
              i++

  $scope.signIn = ->
    auth
      .signIn $scope.formData
      .success (data)->
        $rootScope.user = data.user
      .error (data)->
        $scope.messages = {}
        if data.success?
          $scope.messages[0] = data.message
        else
          i = 0
          for own key, value of data
            $scope.messages[i] = value
            i++

  $scope.signOut = ->
    auth.signOut()

  $scope.goSignUp = ->
    modal.destroy()
    modal.create('signup')

  $scope.goSignIn = ->
    modal.destroy()
    modal.create('signin')

]
