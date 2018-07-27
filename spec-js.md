# Specifications for the Rails with jQuery Assessment

Specs:
- [x] Use jQuery for implementing new requirements - (Used jQuery and AJAX to update the app, for manipulating items in the DOM and making AJAX requests to the database)
- [x] Include a show resource rendered using jQuery and an Active Model Serialization JSON backend. (Created Previous and Next buttons for the Wine/Cookie pairings so User can click through them)
- [x] Include an index resource rendered using jQuery and an Active Model Serialization JSON backend. (Created index of users pairings,wines,cookies, and comments that can be accessed by the users show page)
- [x] Include at least one has_many relationship in information rendered via JSON and appended to the DOM. (Added a Show Comments button for each pairing that loads the comments for that pairing without a page refresh)
- [x] Use your Rails API and a form to create a resource and render the response without a page refresh.(Added an Add Comment button to the Pairings Show page, to add a comment for that pairing without a page refresh or navigating to a ne page)
- [x] Translate JSON responses into js model objects. (Created class constructors for Pairing,Comment,Wine,Cookie. Every time an AJAX request is made, the data returned is turned into a js model object for the individual class.  That js model is used to add elements to the page)
- [x] At least one of the js model objects must have at least one method added by your code to the prototype. (The Comment class has a method that formats the User's name)

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
