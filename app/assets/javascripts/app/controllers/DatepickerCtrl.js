var DatepickerCtrl = function ($scope) {
  $scope.today = function() {
    $scope.dt = new Date();
  };
  $scope.today();

  $scope.clear = function () {
    $scope.dt = null;
  };

  $scope.toggleMin = function() {
    $scope.minDate = $scope.minDate ? null : new Date();
  };
  $scope.toggleMin();

  $scope.open = function($event) {
    $event.preventDefault();
    $event.stopPropagation();
    $scope.opened = true;
  };

  $scope.dateOptions = {
    formatYear: 'shortDate',
    startingDay: 1
  };

  $scope.select_date = function(type, item, date) {
    $scope.$parent.save_deadline(type, item, date);
  };

  $scope.format = 'yyyy-MM-dd';

};