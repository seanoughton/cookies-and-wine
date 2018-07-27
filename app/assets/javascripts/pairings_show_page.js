$( document ).ready(function() {

  getNumberOfPairings(); // GETS THE NUMBER OF PAIRINGS FOR THE NEXT CLICK FUNCTION


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
    showPairingsComments();
  });//end click function

  $("#add-comment").click(function(){
    CommentForm();
  });//end click function



});//end document.ready

//this function adds pairing data to the pairing show page
function addPairing(pairing){
  let pairingsDiv = $("#pairing-info");
  pairingsDiv.empty();
  $("#rating-info").empty();
  $("#comment-count").empty();
  $("#comments-link").empty();
  $("#edit-delete-buttons").empty();
  $("#show-comments-div").empty();
  $("#add-comments-div").empty();

  pairingShowHtml = HandlebarsTemplates['pairing_show'](
    pairing
  );
  pairingsDiv.html(pairingShowHtml);
};// end addPairing
