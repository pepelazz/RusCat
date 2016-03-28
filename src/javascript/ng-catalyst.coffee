module.exports = (ngModule = angular.module 'catalyst', []).name

catalystData = require './catalyst-data'
extendDeep = require './extend-deep'

ngModule.controller 'catalyst',
  ['$scope','$http', '$location', '$timeout'
   (($scope, $http, $location, $timeout) ->

    urlStr = location.href
    console.log 'carrier:', carrierName = $.url(urlStr).param 'cr'
    console.log 'size:', size = $.url(urlStr).param 'sz'
    console.log 'metalName:', metalName = $.url(urlStr).param 'm'
    console.log 'metalNumber:', metalNumber = $.url(urlStr).param 'mn'
    console.log 'cellIndex:', cellIndex = $.url(urlStr).param 'cl'

    if 0<= ['gm', 'zr', 'cb', 'tz'].indexOf carrierName
      product = $scope.product = catalystData['vpyk']

      $scope.product.title = product.titleParams.name['vpyk'] + "/" +  product.titleParams.metal[carrierName] + "/" + metalNumberTitle(metalName, +metalNumber) + "/10-30ppi"
      if(metalNumber<=1)
        $scope.product.subtitle = 'катализатор селективного гидрирования'
        $scope.product.processes = catalystData['vpyk'].processes[carrierName][0]
      else
        $scope.product.processes = catalystData['vpyk'].processes[carrierName][1]



      $scope.product.params.carrier = product.params.carrierArray[carrierName]
      $scope.product.techParams.activeSubstrate = product.params.carrierArray[carrierName]

      if +cellIndex in [0..2]
        $scope.product.params.cell = product.params.cellArray[cellIndex]

      $scope.product.params.metal = product.params.metalArray[metalName]
      $scope.product.params.metalMass = metalNumber + ' мас %'

      if size?
        size = size.split ','
        if size.length == 2
          sizeStr = "Диаметр #{size[0]}мм, высота #{size[1]}мм"
        if size.length == 3
          sizeStr = "Длина #{size[0]}мм, ширина #{size[1]}мм, высота #{size[2]}мм"

        $scope.product.params.size = sizeStr


      $scope.catalystOrder =->
        $scope.modaIsShown = !$scope.modaIsShown

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
                html: '<h2>Заявка с сайта rus-cat.com</h2><ul><li>' + $scope.product.title + '</li></li><li>' + $scope.request.name + '</li><li>' + $scope.request.phone + '</li><li>' + $scope.request.email + '</li><li>' + $scope.request.message + '</li></ul><h3>Параметры</h3><ul><li>размеры:' + size + '</li><li>Содержание активного металла:' + metalNumber + '</li></ul>'
                text: $scope.product.title + ', Имя: ' + $scope.request.name + ', тел.: ' + $scope.request.phone + ', email.: ' + $scope.request.email + ', сообщение: ' + $scope.message
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

      return)]

metalNumberTitle =((mlName, mlNum)->

  if(mlName == 'Pd')
    switch true
      when mlNum <= 1 then return '0,2-1Pd'
      else return '1,5-5Pd'

  return)
