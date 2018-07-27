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
  $("#comments").click(function() {
    let commentsDiv = $("#allComments ul");
    clearDivs();
    $.each( commentsArray, function(key, value){
      commentsDiv.append(`<li><a href='/comments/${value.id}'> ${value.body}</a></li>`);
    })//end .each
  });// end click function

});//end document.ready
