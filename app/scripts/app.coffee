module = angular.module 'rus-cat-app', []


module.controller 'main',
  ['$scope','$http', '$location', '$timeout'
   (($scope, $http, $location, $timeout) ->


     return)]


module.directive 'yandexMap', [
  (() ->
    restrict: 'A'
    link: ($scope, element, attrs) ->

      fixContentHeight =->
        width = $(window).width()
        $(element).css('height', 500).css('width', width)
        return

      fixContentHeight()

      $(window).resize -> fixContentHeight(); return

      coord = $scope.$eval attrs.yandexMap

      console.log coord

      init =(->
        myMap = new ymaps.Map("map",
          center: [coord.lat, coord.lon]
          zoom: 15
        )
        myMap.controls.add('zoomControl', { left: 5, top: 15 })
        myMap.balloon.open([coord.lat, coord.lon], coord.adr, {
          closeButton: false
        })


        return)

      ymaps.ready(init)

      return
  )]



