App.factory 'Questions', ['ipCookie', 'auth', 'socket', (ipCookie, auth, socket)->
  questions =
    shtab:
      title: 'Когда команда IRBR  завоевала свой первый дубль в истории?'
      options: [
        'Гран-при Китая 2009'
        'Гран-при Великобритании 2009'
        'Гран-при Германии 2009'
      ]
      correct: 0
    tribune:
      title: 'В каком городе назвали трибуну в честь Себастьяна Феттеля?'
      options:[
        'Спа'
        'Мельбурн'
        'Будапешт'
      ]
      correct: 1
    track:
      title: 'На какой трассе Себастьян Феттель завоевал свою первую победу для IRBR?'
      options:[
        'Сильверстоун'
        'Судзука'
        'Шанхай'
      ]
      correct: 2
    garage:
      title: 'Сколько банок Red Bull (0,25 л) потребуется, чтобы заполнить рабочий объем турбомотора болида Формулы-1 образца 2014 года?'
      options:[
        '9,6'
        '6,4'
        '7,2'
      ]
      correct: 1
    pitstop:
      title: 'Где прошел самый оригинальный пит-стоп Марка Уэббера?'
      options:[
        'На побережье Тихого океана'
        'Под Парламентом в Лондоне'
        'На крыше небоскреба в Дубаи'
      ]
      correct: 1 

  syncResults =()->
    auth.authReady().then (user)->
      if !!user and ipCookie('mobile_results')?
        socket.emit 'mobile.activations', ipCookie('mobile_results')
        console.log 'results synced'

  
  syncResults()
      

  return {
    getQuestions: (activationName)->    
      questions[activationName]
    
    setResult: (activationName, isCorrect)->
      currentResults = ipCookie('mobile_results') || {}      
      if currentResults[activationName]?
        return false
      else
        currentResults[activationName] = isCorrect
        ipCookie('mobile_results', currentResults, { expires: 999 })
        syncResults()
        return true


    isDone: (activationName)->
      currentResults = ipCookie 'mobile_results'
      if currentResults? and currentResults[activationName]?
        return true
      else
        return false

  }

]