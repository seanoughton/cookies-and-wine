
let commentsArray = [];
  //// Class Constructors
class Comment {
  constructor(id,body,userId,pairingId){
    this.id = id;
    this.body = body;
    this.userId = userId;
    this.pairingId = pairingId;
    commentsArray.push(this)
  }//end constructor
}//end class definition

//get all of this users comments when the page loads and store them in an array
function createComments(id){
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
    createComments(id);
  }


  $("#comments").click(function() {
    let commentsDiv = $("#allComments ul");
    $.each( commentsArray, function(key, value){
      commentsDiv.append(`<li>` + value.body + `.</li><br>`);
    })//end .each
    //make these links to the comments themselves
    // add the pairings names that these are comments for with link
  });// end click function

});//end document.ready

////////////////////////////////////////////////////////////////
