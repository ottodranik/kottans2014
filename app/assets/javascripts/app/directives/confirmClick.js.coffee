angular.module('App')

  .directive 'confirmClick', ->
    restrict: 'A'
    replace: false
    link: (scope, element, attrs)->
      msg = attrs.ngConfirmClick || "Are you sure?"
      clickAction = attrs.confirmedClick
      element.on 'click', (event)->
        if window.confirm(msg)
          scope.$eval(clickAction)