angular.module('App')

  .directive 'onRepeatFinishProjects', ->
    restrict: 'A'
    replace: false
    link: (scope, element, attrs)->
      parent = element[0].parentElement
      if scope.$last
        $(parent).sortable {
          start: (event, ui)->
            scope.sort_cur[0] = ui.item.index()
          update: (event, ui)->
            scope.sort_cur[1] = ui.item.index()
            newPos = ui.item.index() + 1
            pIndex = ui.item[0].attributes['data-project-index'].value
            item = scope.projects[pIndex]
            scope.projects.move(scope.sort_cur[0], scope.sort_cur[1])
            scope.sort_cur = []
            scope.position('project', item, newPos)
          }
        $(parent).disableSelection()

  .directive 'onRepeatFinishTasks', ->
    restrict: 'A'
    replace: false
    link: (scope, element, attrs)->
      parent = element[0].parentElement
      if scope.$last
        $(parent).sortable {
          start: (event, ui)->
            scope.sort_cur[0] = ui.item.index()
          update: (event, ui)->
            scope.sort_cur[1] = ui.item.index()
            newPos = ui.item.index() + 1
            pIndex = ui.item[0].attributes['data-project-index'].value
            tIndex = ui.item[0].attributes['data-task-index'].value
            item = scope.projects[pIndex].tasks[tIndex]
            scope.projects[pIndex].tasks.move(scope.sort_cur[0], scope.sort_cur[1])
            scope.sort_cur = []
            scope.position('task', item, newPos)
        }
        $(parent).disableSelection()