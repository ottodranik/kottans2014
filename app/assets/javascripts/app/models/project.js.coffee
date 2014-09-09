angular.module('App').provider 'Project', ->
  @$get = [
    '$resource'
    ($resource)->
      Project = $resource('/projects/:_pid/:_member/:_tid/:_method', {},
        {
          update:
            method: 'PUT'
        }
      )
      return Project
  ]
  return