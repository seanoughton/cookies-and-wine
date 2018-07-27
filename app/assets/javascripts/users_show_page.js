$( document ).ready(function() {
  let id = $('#comments').attr('data')// this is getting the userid
  //PRELOADS THE USERS PAIRINGS,COMMENTS,WINES,COOKIES
  if(id){
    createUserComments(id);
    createUserPairings(id);
    createWines(id);
    createCookies(id);
  }


  /// CLICK FUNCTIONS

  $("#pairings").click(function() {
    let pairingsDiv = $("#allPairings ul");
    clearDivs();
    $.each( pairingsArray, function(key, value){
      pairingsDiv.append(`<li><a href='/pairings/${value.id}'> ${value.wineName} is paired with ${value.cookieName} </a></li>`);
    })//end .each
  });// end click function

  $("#comments").click(function() {
    let commentsDiv = $("#allComments ul");
    clearDivs();
    $.each( commentsArray, function(key, value){
      commentsDiv.append(`<li><a href='/comments/${value.id}'> ${value.body}</a></li>`);
    })//end .each
  });// end click function

  $("#cookies").click(function() {
    let cookiesDiv = $("#allCookies ul");
    clearDivs();
    $.each( cookiesArray, function(key, value){
      cookiesDiv.append(`<li><a href='/cookies/${value.id}'> ${value.cookieName}</a></li>`);
    })//end .each
  });// end click function

  $("#wines").click(function() {
    let winesDiv = $("#allWines ul");
    clearDivs();
    $.each( winesArray, function(key, value){
      winesDiv.append(`<li><a href='/wines/${value.id}'> ${value.wineName}</a></li>`);
    })//end .each
  });// end click function



});//end document.ready
