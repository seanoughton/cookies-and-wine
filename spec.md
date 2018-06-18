# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project (Used Ruby on Rails for Project)
- [x] Include at least one has_many relationship (A Cookie has many Pairings)
- [x] Include at least one belongs_to relationship (A comment belongs to a User)
- [x] Include at least one has_many through relationship (A Cookie has many Wines through Pairings)
- [x] The "through" part of the has_many through includes at least one user submittable attribute (A pairing has an attribute of user rating)
- [x] Include reasonable validations for simple model objects (Cookies,Wines and Comments cannot be added to the database unless all fields are filled out appropriately. Otherwise Error messages prompt the user to enter in the correct information.)
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
- [x] Include signup (Custom Signup with validatios)
- [x] Include login (Custom)
- [x] Include logout (Custom, delete the user_id from the session)
- [x] Include third party signup/login (OmniAuth through Facebook)
- [x] Include nested resource show or index (URL pairings/1/comments/show)
- [x] Include nested resource "new" form (URL pairings/1/comments/new)
- [x] Include form display of validation errors (all forms have validation errors)

Confirm:
- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate
