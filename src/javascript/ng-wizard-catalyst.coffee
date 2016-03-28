module.exports = (ngModule = angular.module 'wizard-catalyst', []).name

ngModule.controller 'catalyst-choice',
  ['$scope','$http', '$window', '$location', '$timeout'
   (($scope, $http, $window, $location, $timeout) ->

     $scope.wizard =
       step: 'catalyst'
       params:
         catalyst: null
         carrier: null
         size: null
         dispersion: null
         metal: null
       gotoSize: ((name)->
         @params.carrier = name
         if(@params.catalyst == 'vpyk') then @step = 'size' else @step = 'dispersion'
         return)
       gotoBackFromCell: (->
         if(@params.size.length == 3) then @step = 'size-3x' else @step = 'size-2x'
         @params.size = null
         return)
       gotoBackFromMetal: (->
         if(@params.catalyst == 'vpyk') then @step = 'cell' else @step = 'dispersion'
         @params.cell = null
         @params.dispersion = null
         return)
       goBackFromFinal: (->
         if(@params.catalyst == 'vpyk')
           @step = 'metalNumbers'
           @params.metal.number = null
         else
           @step = 'package'
           @params.package = null
         return)

     $scope.$watch 'wizard.step', ((newVal)->
       if(newVal == 'final')
         params = []
         params.push "cr=#{$scope.wizard.params.carrier}"
         params.push "sz=#{$scope.wizard.params.size}"
         if $scope.wizard.params.dispersion? then params.push "dsp=#{$scope.wizard.params.dispersion}"
         if $scope.wizard.params.cell? then params.push "cl=#{$scope.wizard.params.cell}"
         params.push "m=#{$scope.wizard.params.metal.name}"
         params.push "mn=#{$scope.wizard.params.metal.number}"
         if $scope.wizard.params.package? then params.push "pg=#{$scope.wizard.params.package}"


         $window.location.assign "http://rus-cat.com/production/vpyk.html?" + params.join('&')
       return)

     return)]

