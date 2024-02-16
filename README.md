
---

## CSC/ECE 517 - Object Oriented Design and Development
# Program 2 - Ruby on Rails

## WolfEvents Event Management System
## Admin

Admin is preconfigured with the following attributes:
* Email: admin@email.com
* Name: Joe Doe
* Password: admin123

## User Guide
* CAUTION when deleting/destroying, there is no warning so if the button is clicked it will delete the instance.
Admin capabilities:

* Log in with an email and password
  - Click "Login as an Admin" and enter email and password above.

* Edit profile
  - Click Edit profile on the right of the screen. (Admin cannot update ID, email, and password or delete account).
  -  Edit desired field and click "Update Admin"

* List reviews written by a specific attendee (with name)
  - From the home page click manage reviews. In the dropdown that says "Attendee" click "Select an Attendee"
  - Choose desired attendee then click "Filter Reviews"
  - If no reviews meet the criteria none will populate. (Also if there aren't any reviews, it wont populate) 

* List reviews written for a specific event (with Event ID)
  - From the home page click manage reviews. In the dropdown that says "Event" click "Select an Event"
  - Choose desired event then click "Filter Reviews"
  - If no reviews meet the criteria none will populate. (Also if there aren't any reviews, it wont populate)

* View all the attendees signed up on the event management system.
  - From the homepage click manage attendees.
  - All the attendees signed up on the event management system will be shown.
  
* View all the events that are available on the system.
  - From the homepage click manage events.
  - All the events available on the event management system will be shown.

* Create/view/edit/delete attendees.
  * Create
    - Homepage under Attendees click "add new attendee". Follow navigation -> click create.
  * View / Edit / Delete 
    - Homepage under Attendees click "manage attendees". 
    - Under the desired attendee to view/edit/delete click "show this attendee" Follow navigation for desired action.
  
  

* Create/view/edit/delete events.
  * Create
  
    - Note: * At least one room must exist or you can't book an event *

    - Homepage under Attendees click "add new event".
    - Fill in all the fields. You are asked for date and time before selecting a room so that rooms aren't double-booked.
    - Click "Check available rooms"
    - Then, under "select available room", choose the desired room.
    - Confirm all required fields -> click "create event"
    
  * View / Edit / Delete
    - Homepage under Events click "manage events".
    - Under the desired event to view/edit/delete click "show this event" Follow navigation for desired action.


* List events by a specific category, date, price (~ price range to be precise), and event name.
    - From main page under "Events" click "manage events"
    - A filter will appear. Utilize it and once you have selected all criteria you desire, click "Apply Filters".
    - Everytime you click "Apply filters" all the criteria in the filters will be applied.


* Admin should be able to search only available rooms in a particular time slot.
  (If a room is already booked, that should not be visible for the admin as part of his/her event creation during the time slot when the room is booked)
  - Built into the event creation process as described above.
  
* Admin should also be able to book events like an attendee and attend them.
  - Follow steps to see all events. Click "show this event", click book for self."

* Create/view/edit/delete tickets.
  * Create
    - Create ticket for self: Homepage under "Events" -> "manage events" -> "view this event" -> "Book ticket for self".
    - Create ticket for attendee: Homepage under "Tickets" -> "book new ticket for attendee" -> follow navigation.
      - or Homepage under "Tickets" -> "manage tickets" -> click ""New ticket for attendee" -> follow navigation.
      
  * View / Edit / Delete
    - Homepage under Tickets click "manage tickets".
    - Under the desired ticket to view/edit/delete click "show this event ticket" Follow navigation for desired action.

  * Create
    - N/A
    
  * View/ Edit/ Delete reviews.
    - Homepage under Reviews click "manage reviews" -> "show this review" under desired review -> view, edit, or destroy.
  
* Create/view/edit/delete rooms.
  * Create
    - Homepage under Rooms click "add new rooms" -> fill in details and click "Create room"
     or 
    - Homepage under Rooms click "manage rooms" -> "New room" -> fill in details and click "Create room"
    
  * View/ Edit/ Delete reviews.
    - Homepage under Rooms click "manage rooms" -> "show this room" under desired room -> view, edit, or destroy.


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