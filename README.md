# swe-proj


# Project description
## Problem Statement:
Develop a system to manage the usage of washing machines in a public washing machine setting typically a college hostel.


# Highlight innovation
- Assisted Booking:  Leave it to us to find you a best slot for washing your clothes. Ofcourse we will ask for your preferences
- Secure and Fault Tolerant : Reverse proxy and token based authentication is used for authorization and backend servers are load balanced to support minimum application downtime.

# How did you go about design
Initial design involved a couple of Microsoft Teams meetings throwing away half baked ideas and adding features that everyone agreed upon.

# Coding principles
The project uses best practices.
Some of them are:-
## Backend side:

## Client side:
- Client Side uses MVVM architecture
- The app uses the local database as the single source of truth. This means upon an app launch the user is immediately shown the locally cached data while the app refreshes in the background.
- The UI has got observers subscribed to local db changes.(Observer pattern)
- Complex object constructions use builder patterns(eg Assisted Event).
- The app follows single responsibility principles very seriously
- This means that every activity is only responsible for its UI elements where all its data is managed by the corresponding  viewmodel.
- Viewmodel is a kind of glue between View(UI) and Model(Data)
- The actual data is managed by repository classes, so even the viewmodel doesn’t know where the actual data comes from (local db or sharedprefs or backend APIs)
 
# Project management(planning, tracking, SCRUM, Backlogs)
We used github project board for planning and tracking the tasks and to keep track of backlogs. Link to project board
The project board is divided into 4 sections:-
To Do, High Priority, Low Priority and Closed(Done)

We also separated our project code base into two separate repos:-  
The main repo includes these two sub repos as git submodules.  
This way the members involved in working on the frontend code base didn’t need to  worry about pulling the latest changes from backend repo.

# The way you integrated and tested as remote teams
Integration testing was one the biggest challenges we faced.  
So initially we started by developing a mock server for the client side. The mock server just provides a source of data for the client side to integrate with. This way the client development could continue while the backend APIs were being developed. After the first cycle of development we began with the integration. Initially we thought of using docker containers to ship the backend code to the frontend developers local system, but this solution became more of a problem.
Issues: 
 1. Running a backend server on the same machine where the frontend dev is running Android Studio meant death of the PC.
 2. No possibility of live debugging for the backend developers.
	
ngrok to the rescue

“One command for an instant, secure URL to your localhost server through any NAT or firewall”-ngrok

Ngrok allowed the frontend app to hit the backend APIs hosted on backend devs' local pc.


# Summarize your learnings with improvement actions
Application can use computer vision to identify the remaining time from the washing machine control panel image to provide real time status.

IIIT-H CAS authentication can be used for user validation.

Once Students started using app for machine booking, data can be collected about machines usage and analysis can be done and details can be publish which might help in better maintenance of washing machine.

