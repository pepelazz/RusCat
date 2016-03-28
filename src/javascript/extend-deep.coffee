extendDeep = ((dst) ->
  angular.forEach arguments, (obj) ->
    if obj != dst
      angular.forEach obj, (value, key) ->
        if dst[key] and dst[key].constructor and dst[key].constructor == Object
          extendDeep dst[key], value
        else
          dst[key] = value
        return
    return
  return dst)

module.exports = extendDeep