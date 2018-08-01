
// GLOBAL VARIABLES
let commentsArray = [];


//// CLASS CONSTRUCTORS
class Comment {
  constructor(id,body,userId,pairingId,userName){
    this.id = id;
    this.body = body;
    this.userId = userId;
    this.pairingId = pairingId;
    this.userName = userName;
    commentsArray.push(this)
  }//end constructor

  // comment methods
  formatAuthorName(){
    const nameArray = this.userName.split(" ");
    const upperCase = nameArray.map( word => {return word.replace( word[0],word[0].toUpperCase() )} )
    return upperCase.join(" ");
  }// end formatAuthorName
}//end class definition



//GLOBAL FUNCTIONS

const createComment = (value) => {
  return new Comment(value.id,value.body,value.user_id,value.pairing_id,value.user.user_name);
};// end createComment



//get all of this users comments when the page loads and store them in an array
const createUserComments = (id) =>{
  $.getJSON( `/users/${id}/comments`, function( data ) {
  }).done(function( data ) {
    $.each( data, function( key, value ) {
       const comment = createComment(value)
    });//end .each
  });// end getJSON
}//end createComments






////////////////////////////////////////////////////////////////
