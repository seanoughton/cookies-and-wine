$( document ).ready(function() {

  $("#sort-form").submit(function(event) {
    event.preventDefault();
    $("#pairings-list").empty();
    let values = $(this).serialize();
    getSortedPairings(values)
    $(this).unbind('submit').submit() // re enable the sort button
  });// end submit

});//end document.ready

// adds sorted pairings to the DOM with handlebars template
const addSortedPairings = pairing => {
  pairingHtml = HandlebarsTemplates['pairing_list_template'](
    pairing
  );
  $("#pairings-list").append(pairingHtml);
};// end addSortedPairings


// gets the sorted pairings and adds them to the DOM
const getSortedPairings = values => {
  let pairingsArray = [];
  let get = $.getJSON('/sort', values);
  get.done(function(values) {
    $.each( values, function( key, value ) {
      let pairing = createPairing(value);
      addSortedPairings(pairing)
    });//end .each
  });//end get.done
};//end getSortedPairings
