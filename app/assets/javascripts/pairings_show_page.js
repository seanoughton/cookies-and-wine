$( document ).ready(function() {

  if( $("#pairing-id").attr('data-id') ){ // ONLY LOADS THESE THINGS ON THE PAIRINGS SHOW PAGE
    getNumberOfPairings(); // GETS THE NUMBER OF PAIRINGS FOR THE NEXT CLICK FUNCTION

    // GETS THE CURRENT PAIRING WHEN THE PAGE FIRST LOADS
    let id = $("#pairing-id").attr('data-id')
    getPairingForShow ( parseInt(id, 10) )

    /////  ADD HANDLEBARS TEMPLATES
    prevNextBtnsHtml = HandlebarsTemplates['previous_next_btns'](
      {pairingId: $("#pairing-id").attr('data-id')}
    );
    $("#prev-next-buttons").html(prevNextBtnsHtml);
    /////// END HANDLEBARS TEMPLATES

    /// CLICK FUNCTIONS
    $("#next").click(function(){
      //account for the last pairing
      if ( currentPairing.id < pairingsLength ){
        let nextPairingId = currentPairing.id + 1;
        getPairingForShow(nextPairingId);
        $("#comments ul").empty();
      }; // end if
    });//end next click function

    $("#previous").click(function(){
      //account for first pairing
      if (currentPairing.id > 1){
        let previousPairingId = currentPairing.id - 1;
        getPairingForShow(previousPairingId);
        $("#comments ul").empty();
      };// end if
    });//end previous click function

    $("#show-comments").click(function(){
      //console.log(currentPairing.commentsCount)
      if ( (currentPairing.commentsCount > 0) &&  ( $("#show-comments").text() === "Show Comments") ) {
        $("#show-comments").text("Hide Comments")
        showPairingsComments();
      } else if ( $("#show-comments").text() === "Hide Comments" ) {
        $("#show-comments").text("Show Comments")
        $("#comments ul").empty()
      }// end if
    });//end show-comments click function

    $("#add-comment").click(function(){
      commentForm();
    });//end add-comment click function

  }// if statement

});//end document.ready

//this function adds pairing data to the pairing show page
const addPairing = pairing => {
  clearDivs()

  pairingShowHtml = HandlebarsTemplates['pairing_show'](
    pairing
  );
  $("#pairing-info").html(pairingShowHtml);

  editDeleteBtnsHtml = HandlebarsTemplates['edit_delete_btns'](
    pairing
  );
  $("#edit-delete-buttons").html(editDeleteBtnsHtml);

};// end addPairing
