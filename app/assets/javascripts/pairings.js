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

// SETS THE CURRENT PAIRING
const setCurrentPairing = pairing => {
  currentPairing = pairing;
}// end setCurrentPairing


/// ASSIGNS AND RETURNS THE TOTAL NUMBER OF PAIRINGS
// TO TEST THE LENGTH FOR THE PREVIOUS/NEXT BUTTONS
const numberOfPairings = length => {
  return pairingsLength = length
}// end numberOfPairings


// GETS THE TOTAL NUMBER OF PAIRINGS FROM THE DB
// CALLED WHEN THE PAIRINGS SHOW PAGE LOADS
// USED FOR THE PREV/NEXT BUTTONS TO PREVENT AN AJAX CALL
// WHEN THE PAGE IS SHOWING THE FIRST OR THE LAST PAIRING
const getNumberOfPairings = () => {
  $.getJSON( `/pairings`, function( data ) {
  }).done(function( data ) {
    numberOfPairings(data.length);
  });// end getJSON for pairing
}//end getNumberOfPairings


// CREATES A PAIRING IN OBJECT IN MEMORY BASED ON THE PAIRING PROTOTYPE CLASS
const createPairing = value => {
  let pairing = new Pairing(value.id,value.wine_id,value.cookie_id,value.user_id,value.user_rating,value.comments_count,value.wine.wine_name,value.cookie.cookie_name,value.user.user_name,value.comments);
  return pairing
}// end createPairing



///CALLED WHEN THE USER'S SHOW PAGE LOADS
/// GETS ALL OF THE USER'S PAIRINGS AND INSTANTIATED JSCRIPT OBJECTS
const createUserPairings = id => {
  $.getJSON( `/users/${id}/pairings`, function( data ) {
  }).done(function( data ) {
    $.each( data, function( key, value ) {
      createPairing(value);
    });//end .each
  });// end getJSON for pairing
}//end createUserPairings

// GETS THE CURRENT PAIRING FOR THE PAIRING SHOW PAGE
// CREATES JAVASCRIPT OBJECT AND STORES IT IN MEMORY

/**
function getPairing(id){
  $.getJSON( `/pairings/${id}`, function( data ) {
  }).done(function( data ) {
      let pairing = createPairing(data);
      setCurrentPairing(pairing);
  });// end getJSON for pairing
};// end createUserPairings
**/


//this function gets an individual pairing based on the pairing id
// only called when the user clicks prev or next
  const getPairingForShow = id => {
    $.getJSON( `/pairings/${id}`, function( value ) {
    }).done(function( value ) {
      let pairing = createPairing(value)
      addPairing(pairing);// this is adding the pairing to the pairing show page
      setCurrentPairing(pairing);
    });// end getJSON for pairing
  }// end getPairingsForShow


//GETS THE COMMENTS FOR A SPECIFIC PAIRING AND ADDS THEM TO THE DOM
  const showPairingsComments = () => {
    id = $("#pairing-id").attr('data-id'); //RESET PAIRING ID TO CURRENT
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
  const commentForm = () => {
    // create pairing for this page as javascript object
    // then create the form
    // then handle form submission
    let id = $("#pairing-id").attr("data-id")
    $.getJSON( `/pairings/${id}`, function( value ) {
    }).done(function( value ) {
      let pairing = createPairing(value)
      pairing.currentUser = $("#user-id").attr('data-id')
      createCommentForm(pairing)
      handleFormSubmission(pairing)
    });// end getJSON for pairing

    //ADDS THE COMMENT FORM TO THE PAGE WHEN ADD COMMENT BUTTON IS CLICKED
    const createCommentForm = pairing => {
      createCommentFormHtml = HandlebarsTemplates['create_comment_form'](
        pairing
      );
      $("#comment-form-container").html(createCommentFormHtml)
    };//end createCommentForm

    // ADDS THE SUBMITTED COMMENT DATA TO THE DOM AFTER SUBMIT
    const addFormDataToDOM = comment => {
      let returnHtml = `<h2>Here is your new comment ${comment.formatAuthorName()}:<br> ${comment.body}</h2><br><br>`
       $("#comment-form-container").html(returnHtml);
       if ($("#comments ul li").length > 0) {
         $("#comments ul ").empty();
         showPairingsComments();
       };// end if
    }// end addFormDataToDOM

    const addPairingInfo = (pairing) => {
      pairingShowHtml = HandlebarsTemplates['pairing_show'](
        pairing
      );
      $("#pairing-info").html(pairingShowHtml);

    }// end addPairingInfo

    //SUBMITS FORM DATA WITH AJAX
    //PERFORMS SOME VALIDATIONS
    //UPDATES COMMENT COUNT
    //UPDATES PAGE WITH PAIRING INFO
    const handleFormSubmission = pairing => {
      $('form').submit(function(event) {
       event.preventDefault();
       // client side validation
       let commentBody = $( "#comment_body" ).val();
       if ( (commentBody.length < 2) || (commentBody.length > 50)){
         alert("The comment has to be at least 2 characters and no more than 50 characters");
         commentForm();//RECURSIVELY CALLS ITSELF IF VALIDATION FAILS
       } else {
          let values = $(this).serialize();
          let posting = $.post('/comments', values);
          posting.done(function(value) {
          let comment = createComment(value);
          currentPairing.commentsCount += 1
          //pairing.commentsCount += 1
          addFormDataToDOM(comment)
          clearDivs()
          addPairingInfo(currentPairing)
          });//end posting.done
       };// end if/else
      });//end form submit
    }// end handleFormSubmission

  };//end CommentForm





//END GLOBAL FUNCTIONS
