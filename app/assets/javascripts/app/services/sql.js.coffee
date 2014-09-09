angular.module('App').factory 'SQL', ['$http', ($http)->

  return {
    query: (num)->
      $http
        .get '/sql/'+num
        .then (data)->
          return data
  }

]