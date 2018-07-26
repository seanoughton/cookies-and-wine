
// GLOBAL VARIABLES
let commentsArray = [];


//// CLASS CONSTRUCTORS
class Comment {
  constructor(id,body,userId,pairingId){
    this.id = id;
    this.body = body;
    this.userId = userId;
    this.pairingId = pairingId;
    commentsArray.push(this)
  }//end constructor
}//end class definition



//GLOBAL FUNCTIONS

//get all of this users comments when the page loads and store them in an array
function createUserComments(id){
  $.getJSON( `/users/${id}/comments`, function( data ) {
  }).done(function( data ) {
    $.each( data, function( key, value ) {
       let comment = new Comment(value.id,value.body,value.user_id,value.pairing_id);
    });//end .each
  });// end getJSON
}// end createComments

$( document ).ready(function() {
  let id = $('#comments').attr('data')// this is getting the userid
  if(id){
    createUserComments(id);
  }

  /// CLICK FUNCTIONS
  $("#comments").click(function() {
    console.log(commentsArray)
    let commentsDiv = $("#allComments ul");
    clearDivs();
    $.each( commentsArray, function(key, value){
      commentsDiv.append(`<li><a href='/comments/${value.id}'> ${value.body}</a></li>`);
    })//end .each
  });// end click function

});//end document.ready

////////////////////////////////////////////////////////////////
