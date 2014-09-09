Array::move = (old_index, new_index) ->
  if new_index >= this.length
    k = new_index - this.length
    this.push 'undefined'  while (k--) + 1
  this.splice new_index, 0, this.splice(old_index, 1)[0]
  this # for testing purposes


class MainController
  @$inject = ['$scope', '$sce', '$state', '$rootScope', '$timeout', 'Project']

  constructor: ($scope, $sce, $stateParams, $rootScope, $timeout, Project)->

    $rootScope.error_message  = null
    $scope.editing            = false
    $scope.item               = null
    $scope.item_copy          = null
    $scope.default_name       = null
    $scope.type               = null
    $scope.pIndex             = null
    $scope.tIndex             = null
    $scope.sort_cur           = []
    $scope.projects           = null
    $scope.buttons_show       = false
    $scope.infoShow           = true
    $scope.i = 0
    $scope.j = 0
    $scope.projects           = Project.query()


    $scope.active = (type, item, pIndex, tIndex)->
      return false if($scope.editing && type != $scope.type)
      $('.project-title-block').eq(pIndex).addClass('editing') if type == 'project'
      $scope.cancel(pIndex, tIndex)
      $scope.item_copy    = angular.copy(item)
      $scope.type         = type
      $scope.item         = item
      $scope.pIndex       = pIndex
      $scope.tIndex       = tIndex
      $scope.default_name = item.name
      $scope.editing      = { id: item.id }

    $scope.save = (type, item, pIndex)->
      if $scope.item && $scope.item.id
        params = { _pid: $scope.item.id } if type == 'project'
        params = { _pid: $scope.item.project_id, _member: 'tasks', _tid: $scope.item.id } if type == 'task'
        Project.update(params, $scope.item).$promise.then (response)->
          if !response.error
            $scope.cancel()
          else
            $rootScope.error_show(response.error)
      else
        params = {}
        if type == 'project'
          item = new Project()
          item.position = $scope.projects.length + 1
        if type == 'task'
          params = { _pid: $scope.projects[pIndex].id, _member: 'tasks' }
          item.position = $scope.projects[pIndex].tasks.length + 1
        Project.save(params, item).$promise.then (response)->
          if !response.error
            if type == 'project'
              response['tasks'] = []
              $scope.projects.push(response)
            else if type == 'task'
              $scope.projects[pIndex].tasks.push(response)
              $scope.projects[pIndex].task = null
            $scope.cancel()
          else
            $rootScope.error_show(response.error)

    $scope.cancel = (pIndex, tIndex, callback)->
      if pIndex != null && pIndex != undefined
        $scope.projects[$scope.pIndex] = angular.copy($scope.item_copy) if $scope.type == 'project'
        $scope.projects[$scope.pIndex].tasks[$scope.tIndex] = angular.copy($scope.item_copy) if $scope.type == 'task'
        $scope.projects[$scope.pIndex].task = null if $scope.type == 'task'
      $scope.item         = null
      $scope.type         = null
      $scope.item_copy    = null
      $scope.pIndex       = null
      $scope.tIndex       = null
      $scope.default_name = null
      $scope.editing      = false
      callback() if callback

    $scope.destroy = (type, item, pIndex, tIndex)->
      params = { _pid: item.id } if type == 'project'
      params = { _pid: item.project_id, _member: 'tasks', _tid: item.id } if type == 'task'
      Project.delete( params ).$promise.then (response)->
        if !response.error
          $scope.projects.splice(pIndex, 1)               if type == 'project'
          $scope.projects[pIndex].tasks.splice(tIndex, 1) if type == 'task'
        else
          $rootScope.error_show(response.error)

    $scope.status = (type, item, pIndex)->
      $scope.item = item
      $scope.save(type, item)

    $scope.position = (type, item, pos)->
      $scope.item = item
      $scope.item.position = pos
      $scope.save(type, item)

    $scope.save_deadline = (type, item, date)->
      $scope.item = item
      $scope.item.deadline = date
      $scope.save(type, item)


    $scope.check_default_name = (name)->
      return name == $scope.default_name

    $rootScope.error_show = (error)->
      $rootScope.error_message = error.name
      $timeout ->
        $rootScope.error_message = null
      , 5000

    $scope.get_timestamp = (date)->
      return new Date(date).getTime()

    $scope.check_deadline = (item)->
      newDtime = $scope.get_timestamp(item.new_deadline)
      Dtime = $scope.get_timestamp(item.deadline)
      if !item.deadline || typeof item.deadline == 'undefined'
        return 'red-bg'
      else if !item.new_deadline || ( newDtime != Dtime )
        # item.new_deadline = item.deadline
        dt = new Date();
        dtTime = $scope.get_timestamp(dt)
        if dtTime > Dtime
          return 'red-bg'
        else if(Dtime > dtTime - 86400000 && Dtime < dtTime*1 + 86400000)
          return 'warning-bg'


App.controller 'MainController', MainController