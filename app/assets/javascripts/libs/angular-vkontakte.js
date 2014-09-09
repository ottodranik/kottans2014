(function(window, angular, undefined) {
  'use strict';

  // Module global settings.
  var settings = {};

  // Module global flags.
  var flags = {
    sdk: false,
    ready: false
  };

  // Module global loadDeferred
  var loadDeferred;

  /**
   * Vkontakte module
   */
  angular.module('vkontakte', []).

    // Declare module settings value
    value('settings', settings).

    // Declare module flags value
    value('flags', flags).

    /**
     * Vkontakte provider
     */
    provider('Vkontakte', [
      function() {

        /**
         * Vkontakte apiId
         * @type {Number}
         */
        settings.apiId = null;

        this.setApiId = function(apiId) {
          settings.apiId = apiId;
        };

        this.getApiId = function() {
          return settings.apiId;
        };


        settings.nameTransportPath = '/xd_receiver.html';

        this.setnameTransportPath = function(nameTransportPath) {
          settings.nameTransportPath = nameTransportPath;
        };

        this.getnameTransportPath = function() {
          return settings.nameTransportPath;
        };


        /**
         * load SDK
         */
        settings.loadSDK = true;

        this.setLoadSDK = function(a) {
          settings.loadSDK = !!a;
        }

        this.getLoadSDK = function() {
          return settings.loadSDK;
        }

        /**
         * Init Vkontakte API required stuff
         * This will prepare the app earlier (on settingsuration)
         * @arg {Object/String} initSettings
         * @arg {Boolean} _loadSDK (optional, true by default)
         */
        this.init = function(initSettings, _loadSDK) {
          // If string is passed, set it as apiId
          if (angular.isString(initSettings)) {
            settings.apiId = initSettings || settings.apiId;
          }

          // If object is passed, merge it with app settings
          if (angular.isObject(initSettings)) {
            angular.extend(settings, initSettings);
          }

          // Set if Vkontakte SDK should be loaded automatically or not.
          if (angular.isDefined(_loadSDK)) {
            settings.loadSDK = !!_loadSDK;
          }
        };

        /**
         * This defined the Vkontakte service
         */
        this.$get = [
          '$q',
          '$rootScope',
          '$timeout',
          '$window',
          function($q, $rootScope, $timeout, $window) {
            /**
             * This is the NgVkontakte class to be retrieved on Vkontakte Service request.
             */
            function NgVkontakte() {
              this.apiId = settings.apiId;
            }

            /**
             * Ready state method
             * @return {Boolean}
             */
            NgVkontakte.prototype.isReady = function() {
              return flags.ready;
            };

            /**
             * Map some asynchronous Vkontakte sdk methods to NgVkontakte
             */
            angular.forEach([
              'Api',
              'api',
              'UI',
              'login',
              'logout',
              'getLoginStatus'
            ], function(name) {
              NgVkontakte.prototype[name] = function() {

                var d = $q.defer(),
                    args = Array.prototype.slice.call(arguments), // Converts arguments passed into an array
                    userFn,
                    userFnIndex;

                // Get user function and it's index in the arguments array, to replace it with custom function, allowing the usage of promises
                angular.forEach(args, function(arg, index) {
                  if (angular.isFunction(arg)) {
                    userFn = arg;
                    userFnIndex = index;
                  }
                });

                // Replace user function intended to be passed to the Vkontakte API with a custom one
                // for being able to use promises.
                if (angular.isFunction(userFn) && angular.isNumber(userFnIndex)) {
                  args.splice(userFnIndex, 1, function(response) {
                    $timeout(function() {
                      if (angular.isUndefined(response.error)) {
                        d.resolve(response);
                      } else {
                        d.reject(response);
                      }

                      if (angular.isFunction(userFn)) {
                        userFn(response);
                      }
                    });
                  });
                }

                $timeout(function() {
                  // Call when loadDeferred be resolved, meaning Service is ready to be used.
                  loadDeferred.promise.then(function() {
                    if (name == 'Api') {
                      $window.VK.Api.call.apply(VK, args);
                    } else if (name == 'UI') {
                      $window.VK.UI.button.apply(VK, args);
                    } else if (name == 'api') {
                      $window.VK.api.apply(VK, args);
                    } else {
                      $window.VK.Auth[name].apply(VK, args);
                    }
                  }, function() {
                    throw 'Vkontakte API could not be initialized properly';
                  });
                });

                return d.promise;
              };
            });

            /**
             * Map Vkontakte sdk subscribe method to NgVkontakte. Renamed as subscribe
             * Thus, use it as Vkontakte.subscribe in the service.
             */
            NgVkontakte.prototype.subscribe = function() {

              var d = $q.defer(),
                  args = Array.prototype.slice.call(arguments), // Get arguments passed into an array
                  userFn,
                  userFnIndex;

              // Get user function and it's index in the arguments array, to replace it with custom function, allowing the usage of promises
              angular.forEach(args, function(arg, index) {
                if (angular.isFunction(arg)) {
                  userFn = arg;
                  userFnIndex = index;
                }
              });

              // Replace user function intended to be passed to the Vkontakte API with a custom one
              // for being able to use promises.
              if (angular.isFunction(userFn) && angular.isNumber(userFnIndex)) {
                args.splice(userFnIndex, 1, function(response) {
                  $timeout(function() {
                    if (angular.isUndefined(response.error)) {
                      d.resolve(response);
                    } else {
                      d.reject(response);
                    }

                    if (angular.isFunction(userFn)) {
                      userFn(response);
                    }
                  });
                });
              }

              $timeout(function() {
                // Call when loadDeferred be resolved, meaning Service is ready to be used
                loadDeferred.promise.then(function() {
                  $window.VK.Observer.subscribe.apply(VK, args);
                }, function() {
                  throw 'Vkontakte API could not be initialized properly';
                });
              });

              return d.promise;
            };

            /**
             * Map Vkontakte sdk unsubscribe method to NgVkontakte. Renamed as unsubscribe
             * Thus, use it as Vkontakte.unsubscribe in the service.
             */
            NgVkontakte.prototype.unsubscribe = function() {

              var d = $q.defer(),
                  args = Array.prototype.slice.call(arguments), // Get arguments passed into an array
                  userFn,
                  userFnIndex;

              // Get user function and it's index in the arguments array, to replace it with custom function, allowing the usage of promises
              angular.forEach(args, function(arg, index) {
                if (angular.isFunction(arg)) {
                  userFn = arg;
                  userFnIndex = index;
                }
              });

              // Replace user function intended to be passed to the Vkontakte API with a custom one
              // for being able to use promises.
              if (angular.isFunction(userFn) && angular.isNumber(userFnIndex)) {
                args.splice(userFnIndex, 1, function(response) {
                  $timeout(function() {
                    if (angular.isUndefined(response.error)) {
                      d.resolve(response);
                    } else {
                      d.reject(response);
                    }

                    if (angular.isFunction(userFn)) {
                      userFn(response);
                    }
                  });
                });
              }

              $timeout(function() {
                // Call when loadDeferred be resolved, meaning Service is ready to be used
                loadDeferred.promise.then(
                  function() {
                    $window.VK.Observer.unsubscribe.apply(VK, args);
                  },
                  function() {
                    throw 'Vkontakte API could not be initialized properly';
                  }
                );
              });

              return d.promise;
            };

            return new NgVkontakte(); // Singleton
          }
        ];

      }
    ]).

    /**
     * Module initialization
     */
    run([
      '$rootScope',
      '$q',
      '$window',
      '$timeout',
      function($rootScope, $q, $window, $timeout) {
        // Define global loadDeffered to notify when Service callbacks are safe to use
        loadDeferred = $q.defer();

        var loadSDK = settings.loadSDK;
        delete(settings['loadSDK']); // Remove loadSDK from settings since this isn't part from Vkontakte API.

        /**
         * Define VKAsyncInit required by Vkontakte API
         */
        $window.vkAsyncInit = function() {
          // Initialize our Vkontakte app
          $timeout(function() {
            if (!settings.apiId) {
              throw 'Missing apiId setting.';
            }

            VK.init(settings);

            // Set ready global flag
            flags.ready = true;


            /**
             * Subscribe to Vkontakte API events and broadcast through app.
             */
            angular.forEach({
              'auth.login': 'login',
              'auth.logout': 'logout',
              'auth.sessionChange': 'sessionChange',
              'auth.statusChange': 'statusChange'
            }, function(mapped, name) {
              VK.Observer.subscribe(name, function(response) {
                $timeout(function() {
                  $rootScope.$broadcast('Vkontakte:' + mapped, response);
                });
              });
            });

            // Broadcast Vkontakte:load event
            $rootScope.$broadcast('Vkontakte:load');

            loadDeferred.resolve(VK);

          });
        };

        /**
         * Inject Vkontakte root element in DOM
         */
        (function addVKRoot() {
          var vkroot = document.getElementById('vk_api_transport');

          if (!vkroot) {
            vkroot = document.createElement('div');
            vkroot.id = 'vk_api_transport';
            document.body.insertBefore(vkroot, document.body.childNodes[0]);
          }

          return vkroot;
        })();

        /**
         * SDK script injecting
         */
        loadSDK && (function injectScript() {
          var src           = '//vk.com/js/api/openapi.js',
              script        = document.createElement('script');
              script.id     = 'vk-jssdk';
              script.async  = true;

          // Prefix protocol
          if ($window.location.protocol === 'file') {
            src = 'https:' + src;
          }

          script.src = src;
          script.onload = function() {
            flags.sdk = true; // Set sdk global flag
          };

          //document.getElementsByTagName('head')[0].appendChild(script); // // Fix for IE < 9, and yet supported by lattest browsers
          document.getElementById('vk_api_transport').appendChild(script);
        })();

      }
    ]);

})(window, angular);