App.controller 'RulesController', ['$scope', '$rootScope', ($scope, $rootScope)->

	$scope.openMenu = ()->
		$rootScope.$broadcast 'openMenu'
]