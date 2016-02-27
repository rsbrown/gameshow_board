# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

showQuestion = (catNum, qNum) ->
  $(".question-body").data("category-id", catNum)
  $(".question-body").data("question-id", qNum)
  question = window.board_data[catNum].questions[qNum]
  $("#questionModal .question-body").html(question.q)
  $("#questionModal").modal("toggle")

handleModalClick = (ev) ->
  qDiv = $(".question-body")
  catNum = parseInt($(".question-body").data("category-id"))
  qNum = parseInt($(".question-body").data("question-id"))
  if qDiv.hasClass("answer-body")
    qDiv.removeClass("answer-body")
    tileDiv = $('.question[data-category-id="' + catNum + '"][data-question-id="' + qNum + '"]')
    tileDiv.toggleClass("answered")
    $.ajax("/answer/" + catNum + "/" + qNum)
    $("#questionModal").modal("hide")
  else
    question = window.board_data[catNum].questions[qNum]
    qDiv.html(question.a)
    qDiv.addClass("answer-body")

$ ->
  $("#content .question").click ->
    catNum = parseInt($(this).data("category-id"))
    qNum = parseInt($(this).data("question-id"))
    showQuestion(catNum, qNum)

  $("#questionModal").click handleModalClick
