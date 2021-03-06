
let cookiesArray = [];
  //// Class Constructors
class Cookie {
  constructor(id,cookieName,description,link,userId){
    this.id = id;
    this.cookieName = cookieName;
    this.description = description;
    this.link = link;
    this.userId = userId;
    cookiesArray.push(this)
  }//end constructor
}//end class definition

//get all of this users cookies when the page loads and store them in an array
const createCookies = (id) => {
  $.getJSON( `/users/${id}/cookies`, function( data ) {
  }).done(function( data ) {
    $.each( data, function( key, value ) {
       const cookie = new Cookie(value.id,value.cookie_name,value.description,value.link,value.user_id);
    });//end .each
  });// end getJSON
}//end createCookies





////////////////////////////////////////////////////////////////
