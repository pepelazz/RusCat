module.exports = (ngModule = angular.module 'filter', []).name

ngModule.controller 'filter',
  ['$scope','$http', '$location', '$timeout'
   (($scope, $http, $location, $timeout) ->

      $scope.filterOrder =->
        $scope.modaIsShown = !$scope.modaIsShown

      filterName = $('article.production_details h4').html()

      # ---- Send request
      $scope.request=
       name: null
       phone: null
       email: null
       message: null
       send: (->
         $scope.modaIsShown = false
         $.ajax(
           method: 'POST'
           url:  "https://mandrillapp.com/api/1.0/messages/send.json"
           data:
             key: 'XrhYSIo5ZAQ6Dcbp5ItPDA'
             message:
               subject: 'Заявка с сайта rus-cat.com'
               html: '<h2>Заявка с сайта rus-cat.com</h2><ul><li>' + filterName + '</li></li><li>' + $scope.request.name + '</li><li>' + $scope.request.phone + '</li><li>' + $scope.request.email + '</li><li>' + $scope.request.message + '</li></ul>'
               text: filterName + ', Имя: ' + $scope.request.name + ', тел.: ' + $scope.request.phone + ', email.: ' + $scope.request.email + ', сообщение: ' + $scope.message
               from_email: 'info@rus-cat.com'
               to: [
                 email : 'noateq@gmail.com'
                 name: 'Иван'
                 type: 'to'
               ,
                 email : 'pepelazz00@gmail.com'
                 name: 'admin'
                 type: 'to'
               ]
         )
         .done ((data)->
           console.info data
           return)
         .fail (->
           console.error 'server not respond'
           return)
         $scope.request.name = null
         $scope.request.phone = null
         $scope.request.email = null
         $scope.request.message = null

         return false)

#      $scope.getContent =(->
#       $.ajax(
#         method: 'POST'
#         url:  "https://mandrillapp.com/api/1.0/messages/content.json"
#         data:
#           key: 'XrhYSIo5ZAQ6Dcbp5ItPDA'
#           id: 'a5747fc40c334736933c17ac8c9dffc6'
#       )
#       .done ((data)->
#         $log.info data
#         return)
#       .fail (->
#         $log.error 'server not respond'
#         return)
#       return)

      return)]
