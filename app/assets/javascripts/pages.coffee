# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

showQuestion = (catNum, qNum) ->
  qDiv = $(".question-body")
  qDiv.data("category-id", catNum)
  qDiv.data("question-id", qNum)
  question = window.board_data[catNum].questions[qNum]
  $("#questionModal .question-body").html(question.q)
  $("#questionModal").modal("toggle")

answerQuestion = (catNum, qNum) ->
  qDiv = $(".question-body")
  qDiv.removeClass("answer-body")
  tileDiv = $('.question[data-category-id="' + catNum + '"][data-question-id="' + qNum + '"]')
  tileDiv.toggleClass("answered")
  $.ajax("/answer/" + catNum + "/" + qNum)

handleModalClick = (ev) ->
  qDiv = $(".question-body")
  catNum = parseInt(qDiv.data("category-id"))
  qNum = parseInt(qDiv.data("question-id"))
  if qDiv.hasClass("answer-body")
    answerQuestion(catNum, qNum)
    $("#questionModal").modal("hide")
  else
    question = window.board_data[catNum].questions[qNum]
    qDiv.html(question.a)
    qDiv.addClass("answer-body")

handleDelCatClick = (ev) ->
  ev.preventDefault()
  r = confirm("Delete this category?")
  if r
    window.location.href = $(this).attr('href');


$ ->
  $("#content .question").click ->
    catNum = parseInt($(this).data("category-id"))
    qNum = parseInt($(this).data("question-id"))
    if $(this).hasClass("answered")
      answerQuestion(catNum, qNum)
    else
      showQuestion(catNum, qNum)

  $("#questionModal").click handleModalClick
  
  $(".del-cat-btn").click handleDelCatClick
