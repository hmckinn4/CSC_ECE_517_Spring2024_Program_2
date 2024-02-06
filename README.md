Based on the provided attendee capabilities, here's how you could edit your README.md to include a section for the attendee, similar to the admin section you provided:

---

## CSC/ECE 517 - Object Oriented Design and Development
# Program 2 - Ruby on Rails

## WolfEvents Event Management System

## Admin

Admin is preconfigured with the following attributes:
* Email: testadmin@test.com
* Name: Tuffy
* Password: 123456

Admin capabilities:

- [x] Log in with an email and password
- [ ] Edit profile (should not be able to update ID, email, and password).
- [ ] Admin account cannot be deleted.
- [ ] List events by a specific category, date, price (~ price range to be precise), and event name.
- [ ] List reviews written by a specific attendee (with name)
- [ ] List reviews written for a specific event (with Event ID)
- [ ] View all the attendees signed up on the event management system.
- [ ] View all the events that are available on the system.
- [ ] Create/view/edit/delete attendees.
- [ ] Create/view/edit/delete events.
- [ ] Create/view/edit/delete tickets.
- [ ] Create/view/edit/delete reviews.
- [ ] Create/view/edit/delete rooms.
- [ ] Admin should be able to search only available rooms in a particular time slot.
  (If a room is already booked, that should not be visible for the admin as part of his/her event creation during the time slot when the room is booked)
  Admin should also be able to book events like an attendee and attend them.

## Attendee

Attendee capabilities:

- [x] Sign up for a new account with an email, name, and password
- [x] Log in with an email and password.
- [ ] Edit their own profile (should not be able to update their ID).
- [ ] Delete their own account. All dependencies, such as tickets booked or reviews written, should be deleted.
- [ ] View all available events in the system. Conditions apply:
    - Only upcoming events are visible.
    - Only events which are not sold out are visible.
    - Filter events by category, date, and price (~ price range).
    - Search events by Event Name.
- [ ] Book an event ticket.
- [ ] Check their own event booking history, displaying at least the Event Name and Date.
- [ ] Write reviews for events they attended, limited to Concerts, Sports, and Arts & Theatre categories. Reviews can be posted only after the event ends.
- [ ] Edit their own reviews.
- [ ] List reviews written by a specific user (with the Email of the user).
- [ ] List reviews written for a specific event (with Event Name).
- [ ] Cancel a ticket, which implies that the event's available seats will be updated accordingly.

(Attendees have the privilege to manage their own data and interact with event listings and reviews within specified boundaries to ensure a user-friendly and efficient experience within the WolfEvents Event Management System.)

--- 

