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
let commentsCount = 0;
//

//GLOBAL FUNCTIONS


function setCurrentPairing(pairing){
  currentPairing = pairing;
};// end setCurrentPairing

/// GET THE NUMBER OF PAIRINGS TO TEST THE LENGTH FOR THE PREVIOUS/NEXT BUTTONS
function numberOfPairings(length){
  return pairingsLength = length;
};

function numberOfComments(commentsNum){
  return commentsCount = commentsNum;
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

function getNumberOfComments() {
  let id = $("#pairing-id").attr('data-id');
  $.getJSON( `/pairings/${id}`, function( data ) {
  }).done(function( data ) {
    let pairing = createPairing(data)
    numberOfComments(pairing.commentsCount)
  });// end getJSON for pairing
}//end getNumberOfPairings




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

function getPairing(id){
  $.getJSON( `/pairings/${id}`, function( data ) {
  }).done(function( data ) {
      let pairing = createPairing(data);
      setCurrentPairing(pairing);
  });// end getJSON for pairing
};// end createUserPairings



//this function gets an individual pairing based on the pairing id
// only called when the user clicks prev or next
  function getPairingForShow(id){
    $.getJSON( `/pairings/${id}`, function( value ) {
    }).done(function( value ) {
      let pairing = createPairing(value)
      addPairing(pairing);// this is adding the pairing to the pairing show page
    });// end getJSON for pairing
  };// end getPairings


//GETS THE COMMENTS FOR A SPECIFIC PAIRING AND ADDS THEM TO THE DOM
  function showPairingsComments(){
    let id = $("#pairing-id").attr('data-id');
    if ($("#comments ul li").length < 1) {
      $.getJSON( `/pairings/${id}/comments`, function( value ) {
      }).done(function( values ) {
        $.each( values, function( key, value ) {
          let comment = createComment(value)
          commentHtml = HandlebarsTemplates['pairing_comments_template'](
            comment
          );
          $("#comments ul").append(commentHtml);
        });//end .each
      });// end getJSON for pairing

    };// end if
  };//end showPairingsComments


//ALL THE FUNCTIONALITY FOR THE COMMENT FORM
  function CommentForm(){

    // create pairing for this page as javascript object
    // then create the form
    // then handle form submission
    let id = $("#pairing-id").attr("data-id")
    $.getJSON( `/pairings/${id}`, function( value ) {
    }).done(function( value ) {
      let pairing = createPairing(value)
      pairing.currentUser = $("#user-id").attr('data-id')
      createCommentForm(pairing)
      handleFormSubmission()
    });// end getJSON for pairing

    function createCommentForm(pairing){
      createCommentForm = HandlebarsTemplates['create_comment_form'](
        pairing
      );
      $("#comment-form-container").html(createCommentForm)
    };//end createCommentForm

    function addFormDataToDOM(comment){
      let returnHtml = `<h2>Here is your new comment ${comment.formatAuthorName()}:<br> ${comment.body}</h2><br><br>`
       $("#comment-form-container").html(returnHtml);
       if ($("#comments ul li").length > 0) {
         $("#comments ul ").empty();
         showPairingsComments();
       };// end if
    }// end addFormDataToDOM

    function handleFormSubmission(){
      /// HANDLE FORM SUBMISSION
      $('form').submit(function(event) {
       event.preventDefault();
       // client side validation
       let commentBody = $( "#comment_body" ).val();
       if ( (commentBody.length < 2) || (commentBody.length > 50)){
         alert("The comment has to be at least 2 characters and no more than 50 characters");
         CommentForm();//RECURSIVELY CALLS ITSELF IF VALIDATION FAILS
       } else {
         let values = $(this).serialize();
         let posting = $.post('/comments', values);
         posting.done(function(value) {
           let comment = createComment(value);
           addFormDataToDOM(comment)
          });//end posting.done
       };// end if/else
      });//end form submit
    }// end handleFormSubmission

  };//end CommentForm





//END GLOBAL FUNCTIONS
