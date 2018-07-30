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
    clearDivs();
    $("#allPairings").prepend("<h2> Pairings: </h2> <ul></ul>");
    $.each( pairingsArray, function(key, value){
      pairingHtml = HandlebarsTemplates['users_pairing_template'](
        value
      );
      $("#allPairings ul").append(pairingHtml);
    })//end .each
  });// end click function

  $("#comments").click(function() {
    clearDivs();
    $("#allComments").prepend("<h2> Comments: </h2> <ul></ul>");
    $.each( commentsArray, function(key, value){
      commentHtml = HandlebarsTemplates['users_comment_template'](
        value
      );
      $("#allComments ul").append(commentHtml);
    })//end .each
  });// end click function

  $("#cookies").click(function() {
    clearDivs();
    $("#allCookies").prepend("<h2> Cookies: </h2> <ul></ul>");
    $.each( cookiesArray, function(key, value){
      cookieHtml = HandlebarsTemplates['users_cookie_template'](
        value
      );
      $("#allCookies ul").append(cookieHtml);
    })//end .each
  });// end click function

  $("#wines").click(function() {
    clearDivs();
    $("#allWines").prepend("<h2> Wines: </h2> <ul></ul>");
    $.each( winesArray, function(key, value){
      wineHtml = HandlebarsTemplates['users_wine_template'](
        value
      );
      $("#allWines ul").append(wineHtml);
    })//end .each
  });// end click function



});//end document.ready
