angular.module('App').factory 'share', ['Facebook', 'Vkontakte', '$q', 'socket', 'cfg', (Fb, Vk, $q, socket, cfg)->
  (provider, data)->
    dfd = $q.defer()
    share_image = cfg.SHARE_IMAGES['root'][provider]
    if provider is 'vkontakte'
      share_image = share_image + ','
      Vk.Api 'wall.post', 
        message: data.message
        attachments: share_image + data.url || window.location.origin
        ,
        dfd.resolve
    if provider is 'facebook'
      Fb.ui 
        method: 'feed'
        link: data.url || window.location.origin
        caption: data.message
        picture: share_image
        ,
        dfd.resolve
    dfd.promise.then (r)->         
      if (r.response? and r.response.post_id?) or r.post_id?
        resp = {}
        resp.provider = provider          
        resp.type = data.type
        socket.emit 'social.share', resp
      r    
]