module.exports = (ngModule = angular.module 'app', [

  require './ng-catalyst'
  require './ng-wizard-catalyst'
  require './ng-filter'

]).name


ngModule.controller 'main',
  ['$scope','$http', '$location', '$timeout'
   (($scope, $http, $location, $timeout) ->



     return)]


ngModule.directive 'yandexMap', [
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

ngModule.directive 'descriptionToggleDirective', [
  (() ->
    restrict: 'C'
    scope: true
    link: ($scope, element, attrs) ->
      $scope.descriptIsShown = false
      $scope.iconClass = 'icon-angle-down'
      btnEl = $('.wizard-btn')
      $scope.toggelDescription =(->
        $scope.descriptIsShown  = !$scope.descriptIsShown
        if($scope.descriptIsShown )
          $scope.iconClass = 'icon-angle-up'
          btnEl.addClass('open')
        else
          $scope.iconClass = 'icon-angle-down'
          btnEl.removeClass('open')
        return)

      return
  )]

$ ->
  $('#hideAll .loader').css(marginTop: window.innerHeight*0.4)
  $(window).load ()-> $('#hideAll').css(display:'none')

  $(window).load ()-> $('#portfolio_item .loader').css(display: 'none')





