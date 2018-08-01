//// CLASS CONSTRUCTORS
class Wine {
  constructor(id,wineName,grapeVarietal,origin,description,userId){
    this.id = id;
    this.wineName = wineName;
    this.grapeVarietal = grapeVarietal;
    this.origin = origin;
    this.description = description;
    this.userId = userId;
    winesArray.push(this)
  }//end constructor
}//end class definition

// GLOBAL VARIABLES
let winesArray = [];

//GLOBAL FUNCTIONS

//get all of this users comments when the page loads and store them in an array
function createWines(id){
  $.getJSON( `/users/${id}/wines`, function( data ) {
  }).done(function( data ) {
    $.each( data, function( key, value ) {
       const wine = new Wine(value.id,value.wine_name,value.grape_varietal,value.origin,value.description,value.user_id);
    });//end .each
  });// end getJSON
}// end createWines



////////////////////////////////////////////////////////////////
