$( document ).ready(function() {
  let currentUserId = $("#current-user-id").attr('data-id')
});//end document.ready


const clearDivs = () => {
  $("#allPairings").empty();
  $("#allComments").empty();
  $("#allWines").empty();
  $("#allCookies").empty();
  $("#pairing-info").empty();
  $("#rating-info").empty();
  $("#comment-count").empty();
  $("#comments-link").empty();
  //$("#edit-delete-buttons").empty();
};
