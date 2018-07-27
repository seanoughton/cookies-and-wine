// hijack the  sort form
// get the sort type and use it to get json data back from the sort route
// clear the page and add the sorted pairings back on the page

$( document ).ready(function() {

  $("#sort-form").submit(function(event) {
    event.preventDefault();
    let pairingsArray = [];
    $("#pairings-list").empty();
    let values = $(this).serialize();
    let get = $.getJSON('/sort', values);
    get.done(function(values) {
      console.log(values)
      $.each( values, function( key, value ) {
        let pairing = createPairing(value);
        //use handlebars here?
        $("#pairings-list").append(`<li>
          <a href="/pairings/${pairing.id}"> ${pairing.wineName} is paired with  ${pairing.cookieName}</a>
        <p>Rating: ${pairing.userRating} Comments: ${pairing.commentsCount} Pairing Creator: <a href="../users/${pairing.userId}">${pairing.userName} </a></p>
          </li>`)
      });//end .each
    });//end get.done
    //clear out sort form
    $(this).unbind('submit').submit()
  });// end submit

});//end document.ready
