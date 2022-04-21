# fitnessapp

A Flutter project that aims to provide users the ability to record and view workouts in an organized fashion while having user experience specifically tailored to them with secure accounts.

## Dependencies

* Firebase Auth: provides authentication for users and allows logins with email and password system.
* SQFLite: the main dependency for creating a database for storing fitness-related information as well as the options to query and modify it.
* Google Sign-In: provides additional method of logging in without using built in Firebase Auth system.

## Functions
* Landing Page: the main page for the app. Offers account registration through email and password system and a login portal for returning users. Also features signing in with an existing Google account.
* Registration Page: main page for setting up an account for new users. Both fields cannot be empty and passwords must have a minimum length of six characters.
* Login Page: main page for logging into the app for returning users with a preexisting account.
* Home Page: main functionality of the app where users can input workout information such as exercise type, date, and duration. Users are notified every time a change is made. 
* Database Display Page: maintains database of all entries users inputted from the Home Page, which can also be deleted via swiping.
* Query Page: allows for querying of specific workouts and ordering via the exercise and date fields. 
