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
    $.each( pairingsArray, function(key, value){
      pairingHtml = HandlebarsTemplates['pairing_for_show_template'](
        value
      );
      $("#allPairings ul").append(pairingHtml);
    })//end .each
  });// end click function

  $("#comments").click(function() {
    clearDivs();
    $.each( commentsArray, function(key, value){
      commentHtml = HandlebarsTemplates['users_comment_template'](
        value
      );
      $("#allComments ul").append(commentHtml);
    })//end .each
  });// end click function

  $("#cookies").click(function() {
    clearDivs();
    $.each( cookiesArray, function(key, value){
      cookieHtml = HandlebarsTemplates['users_cookie_template'](
        value
      );
      $("#allCookies ul").append(cookieHtml);
    })//end .each
  });// end click function

  $("#wines").click(function() {
    clearDivs();
    $.each( winesArray, function(key, value){
      wineHtml = HandlebarsTemplates['users_wine_template'](
        value
      );
      $("#allWines ul").append(wineHtml);
    })//end .each
  });// end click function



});//end document.ready
