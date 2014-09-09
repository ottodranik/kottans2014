App.controller 'MainController', ['$scope', 'socket', 'auth', '$rootScope', 'Questions', 'share', ($scope, socket, auth, $rootScope, Questions, share) ->
 
  $scope.views = 
    start:
      visible: true
    loginPopup:
      visible: false
    successPopup:
      visible: false
      points: 0
    unsuccessPopup:
      visible: false
      message: ''
    successShare:
      visible: false

  socket.on 'popup', (data)->
    data = JSON.parse data
    if data.type == 'info:code_success'
      $scope.views.successPopup.points = data.options.points 
      $scope.setCurrentView 'successPopup'
    if data.type == 'info:share'      
      $scope.setCurrentView 'successShare'

  socket.on 'code', (data)->
    data = JSON.parse data
    if !data.success
      $scope.setCurrentView 'unsuccessPopup'
      $scope.views.unsuccessPopup.message = data.message     
    
  
  $scope.init = ->
    $scope.preloader = false           

  $scope.setCurrentView = (viewName)->
    for own view, params of $scope.views
      params.visible = false
    $scope.views[viewName].visible = true

  $scope.enterCode = ->
    if auth.isLoggedIn()
      $rootScope.$broadcast 'openMenu'
    else
      $scope.setCurrentView 'loginPopup'

  $scope.share = (provider)->
    shareMessage = "Я получил 15 баллов за активацию кода."
    share(provider, 
      message: shareMessage 
      type: 'info:code_success'
    )
    .then (data)->
      console.log data

  
  
]
