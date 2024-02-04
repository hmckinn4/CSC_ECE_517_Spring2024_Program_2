
---

# CSC/ECE 517 - Object Oriented Design and Development
# Program 2 - Ruby on Rails: Event Management System

## Overview

**Course:** CSC/ECE 517 - Object Oriented Design and Development  
**Program:** 2 - Ruby on Rails   
**Submission Due Date:** February 16, 2024 (Friday) 11:59 PM  
**Resubmission Due Date:** February 22, 2024 (Thursday) 11:59 PM  
**Early Submission Points:** 5 points for submitting a repo by 11:59 PM on Feb. 6 (even if empty).

## Project Description

- [ ] Develop an Event Management System named "WolfEvents" for NCSU. This system allows attendees to explore events, purchase tickets, and provide reviews for attended events. Admins can create events and manage Attendees, Tickets, and Reviews.



- [X] TO INDICATE A TASK IS COMPLETE
### System Components

1. **Admin**
2. **Attendee**
3. **Room**
4. **Event**
5. **Event Ticket**
6. **Review**

### Admin

- **Attributes:** Email, Password, Name, Phone number, Address, Credit card information (Fake).
- **Capabilities:**
  - [ ] Log in, edit own profile (excluding ID, email, password which should be pre-configured).
  - [ ] View, create, edit, delete:

        Attendees, Events, Tickets, Reviews, Rooms.
  - [ ] List events by a specific category, date, price (~ price range to be precise), and event name.
  - [ ] List reviews written by a specific attendee (with name)
  - [ ] List reviews written for a specific event (with Event ID)

  - [ ] Search available rooms for specific time slots (booked rooms in certain time slot can not be booked again by admin).
  - [ ] Book events like an attendee.

### Event

- **Initialization:** Preconfigured by Admin.
- **Attributes:** ID, Name, Room ID, Category, Date, Start & End Time, Ticket Price, Seats Left.
- **Note:** Manage seat capacity consistency between Room and Event.

### Event Ticket

- **Attributes:** ID, Attendee ID, Event ID, Room ID, Confirmation Number.
- **Note:** Decisions on ticket-buying process and transaction model are at discretion.

### Room

- **Exclusive to Admin:** Booking events in specific Rooms for time slots.
- **Attributes:** ID, Location/Address, Capacity.

### Attendee

- **Attributes:** ID, Email, Password, Name, Phone number, Address, Credit card (Fake).
- **Capabilities:**
  - [ ] Sign up, log in, edit (excluding ID), delete account.
  - [ ] View available events (upcoming, not sold out).
  - [ ] Filter and search events, book tickets, view booking history.
  - [ ] Write, edit reviews (post-event, for attended events only).
  - [ ] Cancel tickets.

### Review

- **Attributes:** Attendee ID, Event ID, Rating (1-5), Feedback.

## General Requirements

- [ ] **User Interface:** Links for profile editing, booking history, event listing, review management.
- [ ] **Transaction Management:** Automatic price calculation, seat availability updates.
- [ ] **Data Integrity:** Deletion of associated data (reviews, tickets) on user/event/room deletion.
- [ ] **Security & Validation:** Protect against unauthorized access and invalid data entries.
- [ ] **Database Seeding:** Preconfigured admin account.
- **Extra Credit Opportunities:**
  - [ ] Admin search function for attendees by event.
  - [ ] Attendee purchasing tickets for others.

## FAQs

- [ ] **Starting the Project:** Use scaffolding for initial structure.
- [ ] **Additional Classes:** Allowed as needed.
- [ ] **Third-party Gems:** Permissible except for full app generators.
- [ ] **Admin Login:** Predefined and seeded in the database.
- [ ] **UI Requirements:** Functional over aesthetic.
- [ ] **Admin Capabilities:** Can edit user information.
- [ ] **Extra Credit Inclusion:** Possible to score above 100 with extra credit tasks.

## Miscellaneous

- [ ] **Ruby Version:** 2.6.X or above.
- [ ] **Repository:** Private on github.ncsu.edu, add TAs as collaborators.
- [ ] **Testing:** One model and one controller, preferably with RSpec.
- [ ] **Deployment:** Choose among PaaS with free plans, Amazon AWS, or NCSU VCL. Keep the deployment active for at least two weeks post-deadline.

## Submission

- [ ] **Expertiza Submission:** Link to deployed application and repository.
- [ ] **README.md:** Include pre configured admin credentials and any other information that reviewers would find useful.


## Grading Rubric

- **Round 1:** Functionality, Workflow, Extra Credit Implementation.
- **Round 2:** Class and Database Design, Software Engineering and Testing, Design and Workflow.

### Note

- [ ] Ensure continuous accessibility of your deployed application and maintain regular checks.

---