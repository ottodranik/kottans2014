#= require active_admin/base
#= require ckeditor/init
#= require ckeditor/config.js
#= require_self
$ ->
  $('.hq_question .button.has_many_remove').parent().remove()
  $('.hq_question .button.has_many_remove').parent().remove()
  
  bg_id = $('#hq_question_bg_id option:selected').first().val()
  $('#hq_question_bg_id').change (event) ->
    img = $('#hq_question_bg_id_input > img').first()
    img.attr('src', '/hq_bkg/' + $(event.target).val() + '.jpg')
  if bg_id
    img = $('<img />')
    img.attr('src', '/hq_bkg/' + bg_id + '.jpg')
    $('#hq_question_bg_id').after(img)

  img_id = $('#hq_question_answer option:selected').first().val()
  if img_id > 3
    $('#hq_question_answer').change (event) ->
      img = $('#hq_question_answer_input > img').first()
      img.attr('src', '/uploads/hq_image/photo/' + $(event.target).val() + '.jpg')
    img = $('<img />')
    img.attr('src', '/uploads/hq_image/photo/' + img_id + '.jpg')
    $('#hq_question_answer').after(img)

  for hq_image in $(".hq_images > input[type='hidden']")
    img = $('<img />')
    img.attr('src', '/uploads/hq_image/photo/' + hq_image.value + '.jpg')
    $(hq_image).after(img)