
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

//get all of this users comments when the page loads and store them in an array
function createCookies(id){
  $.getJSON( `/users/${id}/cookies`, function( data ) {
  }).done(function( data ) {
    $.each( data, function( key, value ) {
       let cookie = new Cookie(value.id,value.cookie_name,value.description,value.link,value.user_id);
    });//end .each
  });// end getJSON
}// end createCookies

$( document ).ready(function() {


  $("#cookies").click(function() {
    let cookiesDiv = $("#allCookies ul");
    clearDivs();
    $.each( cookiesArray, function(key, value){
      cookiesDiv.append(`<li><a href='/cookies/${value.id}'> ${value.cookieName}</a></li>`);
    })//end .each
  });// end click function


});//end document.ready

////////////////////////////////////////////////////////////////
