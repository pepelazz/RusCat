data =
  vpyk:
    titleParams:
      name:
        vpyk  : 'ВПЯК'
      metal:
        gm: 'Гамма'
        zr: 'Циркон'
        cb: 'Карбон'

    subtitle: 'катализатор гидрирования'
#    industries: ['Спецхимия', 'Лакокраски', 'Органический синтез', 'Нефтехимия', 'Синтетические волокна', 'Каучуки', 'Лесохимия/Зеленая химия/Green chemestry']
    processes:
      cb:[
        ['Селективное восстановление аминов', 'Селективное восстановление моно- нитросоединений', 'Селективное восстановление оксимов']
      ,
        ['Гидрирование моно- нитросоединений', 'Тонкий органический синтез']
      ]
      zr:[
        ['Селективное гидрообессеривание', 'Селективное восстановление ароматических нитросоединений']
      ,
        ['Диспропорционирование', 'Гидрообессеривание']
      ]
      gm:[
        ['гидрообессеривание', 'восстановление мононитросоединениий', 'селективное гидрирование ацетилена', 'селективное гидрирование этилена']
      ,
        ['гидрирование ароматических углеводородов','гидрирование альдегидов','гидрирование органических кислот', 'гидрирование динитро-, тринитросоединений ']
      ]
    params:
      catalyst: 'блочный, стационарный'
      carrierArray:
        gm: 'гамма'
        zr: 'диоксид циркония'
        cb: 'углерод'
      cellArray: ['10ppi / 3-5мм', '20ppi - 1-2,5мм', '30ppi - 0,5-1мм']
      process: 'жидкофазный'
      metalArray:
        Pd: 'Pd/палладий'
        Pt: 'Pt/платина'
        Ni: 'Ni/никель'
      metalMass: '0,2 мас %'
    techParams:
      matrix: 'корунд/альфа оксид алюминия'
      activeSurface: '150-200 м2/г'
      compressiveStrength: '1,5 -2,5 МПа'
#      activeSubstrate: 'диоскид циркония'
      acidAlkaliResistance: '99,9%'
      regenerations: 'от 50 циклов'
    addParams:
      microporosity: 'канальная/полусферическая'
    equipment: ['shaker', 'noatube', 'noatube duos', 'noatube microlab']


module.exports = data

