class SQLController
  @$inject = ['$scope', '$sce', '$state', '$timeout', 'SQL']

  constructor: ($scope, $sce, $stateParams, $timeout, SQL)->

    $scope.query_answers = []
    $scope.message = ''

    $scope.send_query = (num)->
      SQL.query(num).then (response)->
        $scope.query_answers[num-1] = response.data

    $scope.to_trusted = (html_code)->
      return $sce.trustAsHtml(html_code);

App.controller 'SQLController', SQLController