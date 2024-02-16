

---

## CSC/ECE 517 - Object Oriented Design and Development
# Program 2 - Ruby on Rails

## WolfEvents Event Management System
## Admin

Admin is preconfigured with the following attributes:
* Email: admin@email.com
* Name: Joe Doe
* Password: admin123

Admin capabilities:

- [x] Log in with an email and password
- [x] Edit profile (should not be able to update ID, email, and password).
- [x] Admin account cannot be deleted.

- [x] List reviews written by a specific attendee (with name)
- [x] List reviews written for a specific event (with Event ID)

- [x] View all the attendees signed up on the event management system.

- [x] View all the events that are available on the system.

- [x] Create/view/edit/delete attendees.

- [x] Create/view/edit/delete events.
* We met the criteria, only thing that would robustify the system, (not on the rubric)
* is to add an "are you sure, if you delete this event it and all associated
* reviews and tickets will be deleted as well" message before deleting

- [x] List events by a specific category, date, price (~ price range to be precise), and event name.
  (Event category (Concerts, Sports, Arts & Theatre, Miscellaneous/Family – Private))

* Tried this for a while, pretty difficult to implement, added some test cases
- [ ] Admin should be able to search only available rooms in a particular time slot.
  (If a room is already booked, that should not be visible for the admin as part of his/her event creation during the time slot when the room is booked)
- [x] Admin should also be able to book events like an attendee and attend them.

- [x] Create/view/edit/delete tickets.
  *Working on correlating a booked ticket to a user and an event as opposed to an arbitrary ticket

  When you click on Tickets, it should take you to event first, then corresponding view all
  tickets for that event

- [x] Create/view/edit/delete reviews.
- [x] Create/view/edit/delete rooms.


## Attendee

Attendee capabilities:

- [x] Sign up for a new account with an email, name, and password
- [x] Log in with an email and password.
- [x] Edit their own profile (should not be able to update their ID).
- [x] Delete their own account. All dependencies, such as tickets booked or reviews written, should be deleted.
- [x] View all available events in the system. Conditions apply:
  - Only upcoming events are visible.
  - Only events which are not sold out are visible.
  - Filter events by category, date, and price (~ price range).
  - Search events by Event Name.
- [x] Book an event ticket.
- [x] Check their own event booking history, displaying at least the Event Name and Date.
- [x] Write reviews for events they attended, limited to Concerts, Sports, and Arts & Theatre categories. Reviews can be posted only after the event ends.
- [x] Edit their own reviews.

- [x] List reviews written by a specific user (with the Email of the user).
* Filter done, works for admin, however, email not displayed. Instructions allude to admin having
* only name while attendee showing name and email.

- [x] List reviews written for a specific event (with Event Name).
- [x] Cancel a ticket, which implies that the event's available seats will be updated accordingly.
  ( This not refers to "book an event ticket: no credit card is utilized and no
  charge is made so it's kind of a loophole in reference to the rubric. Just
  something we should confirm.)


(Attendees have the privilege to manage their own data and interact with event listings and reviews within specified boundaries to ensure a user-friendly and efficient experience within the WolfEvents Event Management System.)

### Bonus (Extra Credit)
- [ ] Implement a search function for the admin to use. The input is the event name; the search result is a list of attendees who booked this event.
- [x] Implement a function to allow an attendee to buy a ticket for another attendee (the ticket can be viewed by both the user who pays for the ticket and the user who receives the ticket).
  Right now an admin can do this, but not attendee



--- 