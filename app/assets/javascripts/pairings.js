
let pairingsArray = [];


//// Class Constructors
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
    /// add this pairing ot the pairingsArray
    pairingsArray.push(this)
  }//end constructor
}//end class definition

function createUserPairings(id){
  $.getJSON( `/users/${id}/pairings`, function( data ) {
  }).done(function( data ) {
    $.each( data, function( key, value ) {
       let pairing = new Pairing(value.id,value.wine_id,value.cookie_id,value.user_id,value.user_rating,value.comments_count,value.wine.wine_name,value.cookie.cookie_name,value.user.user_name);
    });//end .each
  });// end getJSON for pairing


};// end createPairings

$( document ).ready(function() {


  let id = $('#comments').attr('data')
  if(id){
    createUserPairings(id);
  };


  $("#pairings").click(function() {
    let pairingsDiv = $("#allPairings ul");
    clearDivs();
    $.each( pairingsArray, function(key, value){
      pairingsDiv.append(`<li><a href='/pairings/${value.id}'> ${value.wineName} is paired with ${value.cookieName} </a></li>`);
    })//end .each
  });// end click function

  $("#next").click(function(){
    let id = $(this).attr('data')
    let nextPairingId = parseInt(id, 10) + 1;
    // query the DB with the next pairing id and turn it into a jscript object
    $.getJSON( `/pairings/${nextPairingId}`, function( value ) {
    }).done(function( value ) {
      console.log(value);
      let pairing = new Pairing(value.id,value.wine_id,value.cookie_id,value.user_id,value.user_rating,value.comments_count,value.wine.wine_name,value.cookie.cookie_name,value.user.user_name);
      addPairing(pairing);
    });// end getJSON for pairing
    //get the pairing from the pairings array and add that pairings data to the page


  });//end click function

  $("#previous").click(function(){

  });//end click function





});//end document.ready

////////////////////////////////////////////////////////////////


function addPairing(pairing){
  console.log(pairing)
  var pairingShowTemplate = Handlebars.compile(document.getElementById("pairing-template").innerHTML);
  var result = pairingShowTemplate(pairing)
  let pairingsDiv = $("#pairing-info");
  pairingsDiv.empty();
  $("#rating-info").empty();
  $("#comment-count").empty();
  $("#comments-link").empty();
  $("#edit-delete-buttons").empty();
  pairingsDiv.append(result);
};// end addPairing


/////
