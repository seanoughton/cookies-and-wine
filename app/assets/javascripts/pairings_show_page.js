$( document ).ready(function() {

  getNumberOfPairings(); // GETS THE NUMBER OF PAIRINGS FOR THE NEXT CLICK FUNCTION
  getNumberOfComments();


  /////  ADD HANDLEBARS TEMPLATES
  prevNextBtnsHtml = HandlebarsTemplates['previous_next_btns'](
    {pairingId: $("#pairing-id").attr('data-id')}
  );
  $("#prev-next-buttons").html(prevNextBtnsHtml);
  /////// END HANDLEBARS TEMPLATES


  /// CLICK FUNCTIONS
  $("#next").click(function(){
    let id = $("#pairing-id").attr('data-id')
    //account for the last pairing
    if (id < pairingsLength){
      let nextPairingId = parseInt(id, 10) + 1;
      getPairingForShow(nextPairingId);
      $("#comments ul").empty();
    }; // end if

  });//end click function

  $("#previous").click(function(){
    let id = $("#pairing-id").attr('data-id')
    //account for first pairing
    if (id>1){
      let previousPairingId = parseInt(id, 10) - 1;
      getPairingForShow(previousPairingId);
      $("#comments ul").empty();
    };// end if
  });//end click function

  $("#show-comments").click(function(){

    if ( (commentsCount > 0) &&  ( $("#show-comments").text() === "Show Comments") ) {
      $("#show-comments").text("Hide Comments")
      showPairingsComments();
    } else if ( $("#show-comments").text() === "Hide Comments" ) {
      $("#show-comments").text("Show Comments")
      $("#comments ul").empty()
    }// end if

  });//end click function

  $("#add-comment").click(function(){
    CommentForm();
  });//end click function



});//end document.ready

//update the comments count on the page when you add a comment

//this function adds pairing data to the pairing show page
function addPairing(pairing){
  let pairingsDiv = $("#pairing-info");
  let editDeleteBtnsDiv = $("#edit-delete-buttons")
  pairingsDiv.empty();
  $("#rating-info").empty();
  $("#comment-count").empty();
  $("#comments-link").empty();
  $("#edit-delete-buttons").empty();
  //$("#show-comments-div").empty();
  //$("#add-comments-div").empty();

  pairingShowHtml = HandlebarsTemplates['pairing_show'](
    pairing
  );
  pairingsDiv.html(pairingShowHtml);

  editDeleteBtnsHtml = HandlebarsTemplates['edit_delete_btns'](
    pairing
  );
  editDeleteBtnsDiv.html(editDeleteBtnsHtml);


};// end addPairing
