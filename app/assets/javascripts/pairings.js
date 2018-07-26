//// CLASS CONSTRUCTORS
class Pairing {
  constructor(id,wineId,cookieId,userId,userRating,commentsCount,wineName,cookieName,userName){
    this.id = id;
    this.wineId = wineId;
    this.cookieId = cookieId;
    this.userId = userId;
    this.userRating = userRating;
    this.commentsCount = commentsCount;
    this.wineName = wineName;
    this.cookieName = cookieName;
    this.userName = userName;
    /// add this pairing to the pairingsArray
    pairingsArray.push(this)
  }//end constructor
}//end class definition

// GLOBAL VARIABLES
let pairingsArray = [];
let pairingsLength = 0;
//

//GLOBAL FUNCTIONS
function numberOfPairings(length){
  return pairingsLength = length;
};

function getNumberOfPairings() {
  $.getJSON( `/pairings`, function( data ) {
  }).done(function( data ) {
    numberOfPairings(data.length);
  });// end getJSON for pairing
}//end getNumberOfPairings

function createUserPairings(id){
  $.getJSON( `/users/${id}/pairings`, function( data ) {
  }).done(function( data ) {
    $.each( data, function( key, value ) {
       let pairing = new Pairing(value.id,value.wine_id,value.cookie_id,value.user_id,value.user_rating,value.comments_count,value.wine.wine_name,value.cookie.cookie_name,value.user.user_name);
    });//end .each
  });// end getJSON for pairing
};// end createUserPairings

function addPairing(pairing){
  let pairingsDiv = $("#pairing-info");
  pairingsDiv.empty();
  $("#rating-info").empty();
  $("#comment-count").empty();
  $("#comments-link").empty();
  $("#edit-delete-buttons").empty();
  pairingShowHtml = HandlebarsTemplates['pairing_show'](
    pairing
  );
  pairingsDiv.html(pairingShowHtml);
};// end addPairing

  function getPairings(id){
    $.getJSON( `/pairings/${id}`, function( value ) {
    }).done(function( value ) {
      let pairing = new Pairing(value.id,value.wine_id,value.cookie_id,value.user_id,value.user_rating,value.comments_count,value.wine.wine_name,value.cookie.cookie_name,value.user.user_name);
      addPairing(pairing);
    });// end getJSON for pairing
  };// end getPairings

//END GLOBAL FUNCTIONS



$( document ).ready(function() {

  ///CALL GLOBAL FUNCTIONS NEEDED FOR PAGE FUNCTION

  // GETS THE NUMBER OF PAIRINGS FOR THE NEXT CLICK FUNCTION
  getNumberOfPairings();

  ///GETS THE USER'S PAIRINGS FROM THE DB AND PUTS THEM ON THE PAGE
  //PRELOADS THE PAIRINGS BEFOR THE USER CLICKS ON SHOW PAIRINGS
  let id = $('#comments').attr('data')
  if(id){
    createUserPairings(id);
  };

  /////  ADD HANDLEBARS TEMPLATES
  prevNextBtnsHtml = HandlebarsTemplates['previous_next_btns'](
    //pairing need to pass in the pairing so I can get the pairing id
    {pairingId: $("#pairing-id").attr('data-id')}
  );
  $("#prev-next-buttons").html(prevNextBtnsHtml);
  /////// END HANDLEBARS TEMPLATES


  /// CLICK FUNCTIONS

  $("#pairings").click(function() {
    let pairingsDiv = $("#allPairings ul");
    clearDivs();
    $.each( pairingsArray, function(key, value){
      pairingsDiv.append(`<li><a href='/pairings/${value.id}'> ${value.wineName} is paired with ${value.cookieName} </a></li>`);
    })//end .each
  });// end click function

  $("#next").click(function(){
    let id = $("#pairing-id").attr('data-id')
    //account for the last pairing
    if (id < pairingsLength){
      let nextPairingId = parseInt(id, 10) + 1;
      // query the DB with the next pairing id and turn it into a jscript object
      getPairings(nextPairingId);
    }; // end if

  });//end click function

  $("#previous").click(function(){
    let id = $("#pairing-id").attr('data-id')
    //account for first pairing
    if (id>1){
      let previousPairingId = parseInt(id, 10) - 1;
      // query the DB with the next pairing id and turn it into a jscript object
      getPairings(previousPairingId);
    };// end if
  });//end click function

  /// END CLICK FUNCTIONS

});//end document.ready





/////
