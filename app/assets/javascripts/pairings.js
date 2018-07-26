//// CLASS CONSTRUCTORS
class Pairing {
  constructor(id,wineId,cookieId,userId,userRating,commentsCount,wineName,cookieName,userName,comments){
    this.id = id;
    this.wineId = wineId;
    this.cookieId = cookieId;
    this.userId = userId;
    this.userRating = userRating;
    this.commentsCount = commentsCount;
    this.wineName = wineName;
    this.cookieName = cookieName;
    this.userName = userName;
    this.comments = comments;
    /// add this pairing to the pairingsArray
    pairingsArray.push(this)
  }//end constructor
}//end class definition

// GLOBAL VARIABLES
let pairingsArray = [];
let pairingsLength = 0;
let currentPairing = {};
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

function createPairing(value){
  let pairing = new Pairing(value.id,value.wine_id,value.cookie_id,value.user_id,value.user_rating,value.comments_count,value.wine.wine_name,value.cookie.cookie_name,value.user.user_name,value.comments);
  return pairing
};//end createPairing

///this function is called when a users show page is loaded
/// gets all of the users pairings
function createUserPairings(id){
  $.getJSON( `/users/${id}/pairings`, function( data ) {
  }).done(function( data ) {
    $.each( data, function( key, value ) {
      createPairing(value);
    });//end .each
  });// end getJSON for pairing
};// end createUserPairings

//this function adds pairing data to the pairing show page
function addPairing(pairing){
  let pairingsDiv = $("#pairing-info");
  pairingsDiv.empty();
  $("#rating-info").empty();
  $("#comment-count").empty();
  $("#comments-link").empty();
  //$("#edit-delete-buttons").empty();
  pairingShowHtml = HandlebarsTemplates['pairing_show'](
    pairing
  );
  pairingsDiv.html(pairingShowHtml);
};// end addPairing




//this function gets an individual pairing based on the pairing id
// only called when the user clicks prev or next
  function getPairingForShow(id){
    $.getJSON( `/pairings/${id}`, function( value ) {
    }).done(function( value ) {
      let pairing = createPairing(value)
      addPairing(pairing);// this is adding the pairing to the pairing show page
    });// end getJSON for pairing
  };// end getPairings

  function showPairingsComments(){
    let id = $("#pairing-id").attr('data-id');
    if ($("#comments ul li").length < 1) {
      $.getJSON( `/pairings/${id}`, function( value ) {
      }).done(function( value ) {
        $.each( value.comments, function( key, value ) {
          $("#comments ul").append(`<li> ${value.body} </li>`)
          // create a HANDLEBARS template for this?
        });//end .each
      });// end getJSON for pairing
    };// end if
  };//end showPairingsComments

  function addCommentForm(){
    let id = $("#pairing-id").attr("data-id")

    $.getJSON( `/pairings/${id}`, function( value ) {
    }).done(function( value ) {
      let pairing = createPairing(value)
      pairing.currentUser = $("#user-id").attr('data-id')
      createCommentForm = HandlebarsTemplates['create_comment_form'](
        pairing
      );
      $("#comment-form-container").html(createCommentForm)
    });// end getJSON for pairing

  };//end addCommentForm


  // on pairings show page, create a button that loads a form
  // create listner for button that fires a function that loads the form on the page
  // form is HANDLEBARS template
  // the form is for a comment
  // comment gets created through AJAX
  // new comment is appended to the DOM


//END GLOBAL FUNCTIONS



$( document ).ready(function() {

  ///CALL GLOBAL FUNCTIONS NEEDED FOR PAGE FUNCTION

  getNumberOfPairings(); // GETS THE NUMBER OF PAIRINGS FOR THE NEXT CLICK FUNCTION


  /// when the page loads, need to get current pairing as a javascript object

  //PRELOADS THE USERS PAIRINGS
  let id = $('#comments').attr('data')
  if(id){
    createUserPairings(id);
  };
  ////

  /////  ADD HANDLEBARS TEMPLATES
  prevNextBtnsHtml = HandlebarsTemplates['previous_next_btns'](
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
    addCommentForm();
  });//end click function

  /// END CLICK FUNCTIONS

});//end document.ready
