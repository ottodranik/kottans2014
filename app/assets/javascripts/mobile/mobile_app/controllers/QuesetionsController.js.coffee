App.controller 'QuestionsController', ['$scope', 'socket', 'auth', 'Questions', '$routeParams', ($scope, socket, auth, Questions, $routeParams) ->
  $scope.views = 
    start:
      visible: true
    question:
      visible: false
    menu:
      visible: false
    successPopup:
      visible: false
    unsuccessPopup:
      visible: false
    alreadyDonePopup:
      visible: false
  
  $scope.question = {}
  
  $scope.init = ()->
    $scope.activationName = $routeParams.activationName.charAt(0).toUpperCase() + $routeParams.activationName.slice(1)
    if !Questions.isDone $routeParams.activationName
      $scope.question = Questions.getQuestions $routeParams.activationName
    else
      $scope.setCurrentView 'alreadyDonePopup'
      console.log 'already done'

  $scope.$on '$destroy', ()->
    socket.off 'code'
    socket.off 'popup'


  $scope.setCurrentView = (viewName)->
    for own view, params of $scope.views
      params.visible = false
    $scope.views[viewName].visible = true

  $scope.submit = ()->
    if parseInt($scope.answer) == $scope.question.correct
      $scope.setCurrentView 'successPopup' 
      Questions.setResult $routeParams.activationName, true
    else
      $scope.setCurrentView 'unsuccessPopup'
      Questions.setResult $routeParams.activationName, false

  $scope.showMenu = ()->
    $scope.views.menu.visible = true
]