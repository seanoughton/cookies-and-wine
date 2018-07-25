let pairingsArray = [];

//// Class Constructors
class Pairing {
  constructor(id,wineId,cookieId,userId,userRating,commentsCount){
    this.id = id;
    this.wineId = wineId;
    this.cookieId = cookieId;
    this.userId = userId;
    this.userRating = userRating;
    this.commentsCount = commentsCount;
    this.wineName = "default";
    this.cookieName = "default";

    pairingsArray.push(this)
  }//end constructor
}//end class definition

function createPairings(id){
  $.getJSON( `/users/${id}/pairings`, function( data ) {
  }).done(function( data ) {
    $.each( data, function( key, value ) {
       let pairing = new Pairing(value.id,value.wine_id,value.cookie_id,value.user_id,value.user_rating,value.comments_count);

       // Assign the associated wine name
       $.getJSON( `/wines/${pairing.wineId}`, function( data ) {
       }).done(function( data ) {
         pairing.wineName = data.wine_name
       });// end getJSON for wineName

       // Assign the associated cookie name
       $.getJSON( `/cookies/${pairing.cookieId}`, function( data ) {
       }).done(function( data ) {
         pairing.cookieName = data.cookie_name
       });// end getJSON for cookieName


    });//end .each
  });// end getJSON for pairing


};// end createPairings

$( document ).ready(function() {
  let id = $('#comments').attr('data')
  if(id){
    createPairings(id);
  };



  $("#pairings").click(function() {
    let pairingsDiv = $("#allPairings ul");
    clearDivs();
    $.each( pairingsArray, function(key, value){
      pairingsDiv.append(`<li>` + value.wineName + ` is paired with ` + value.cookieName + `.</li><br>`);
    })//end .each
  });// end click function


});//end document.ready

////////////////////////////////////////////////////////////////

/////////////////////// end listeners



/////
