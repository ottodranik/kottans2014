App.controller 'NewsController', ['$scope', 'socket', '$sce','$routeParams', ($scope, socket, $sce, $routeParams)->
  $scope.news =[]
  $scope.currentPage = 0
  $scope.noMoreNews = false
  $scope.newsItem = {}
  
  socket.onPublic 'news', (data)->
    console.log "get News page ", $scope.currentPage
    parsedNews = JSON.parse data   
    if parsedNews.news?
      #single news handler
      $scope.newsItem= parsedNews.news
      return true
    #news list handler
    $scope.noMoreNews = !parsedNews.length    
    for news in parsedNews
      $scope.news.push news

  $scope.nextPage = ->
    if not $scope.noMoreNews
      socket.emit 'news.read', ++$scope.currentPage
    else
      console.log('no more news')

  $scope.$on('$destroy', =>
    socket.offPublic 'news'
  )

  $scope.getPage = (id)->
    socket.emit 'news.get', id

  $scope.to_trusted = (html_code) ->
    $sce.trustAsHtml html_code

  $scope.init = ->
    if $routeParams.id?
      $scope.getPage $routeParams.id
      console.log 'single news'
    else
      $scope.nextPage()
]