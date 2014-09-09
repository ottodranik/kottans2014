App.controller 'MenuController' , ['$scope', '$rootScope', 'socket', '$location', ($scope, $rootScope, socket, $location)->
  $scope.views =
    menu: 
      visible : false
    
  
  $scope.submit = ()->
    console.log $scope.formData.code
    $scope.go '/'
    socket.emit 'code.activate', $scope.formData.code 
    $scope.formData.code = ''
    $scope.views.menu.visible = false

  
  $scope.setCurrentView = (viewName)->
    for own view, params of $scope.views
      params.visible = false
    $scope.views[viewName].visible = true

  $rootScope.$on 'openMenu', ()->
    $scope.setCurrentView 'menu'

  $scope.go = (path)->
    $location.path path
    $scope.views.menu.visible = false



  # $rootScope.$on 'openLogin', ()->
  #   $scope.setCurrentView 'loginPopup'    
    
    
]