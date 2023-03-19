# Karma App
This project has been developed for the "Design adn Implementation of Mobile Applications" course, attended at Politecnico di Milano.
## Description

This project is a mobile application for iOS written in Swift that enables users to create a profile and raise money for fundraising campaigns they create.
The application provides users with a user-friendly interface to create a fundraising campaign by entering the campaign details, such as the title, description, and fundraising goal. 
The application allows users to track their progress towards the fundraising goal, including the total amount of donations received and the percentage of the goal achieved. Additionally, users can also view the list of donors.

## Services
For the realization of the application, several libraries and services have been used:

### Firebase
Firebase was used as the backend service providing:
- authentication, to manage login and logout phases
- firestore, to store data about users, campaigns and payments
- storage, to save images about profiles and campaigns
- messaging, combined with Apple Push Notification service to send weekly reminders

### Apple Pay
Apple Pay service has been integrated to allow users to perform donations.

### Apple Push Notifications
Apple Push Notifications service has been integrated to create weekly reminders and perform a simple notification system.

### Libraries
- SwiftUI
- Firebase
- Kingfisher
- View Inspector

## Testing
Tests were performred to ensure the application's correctness, including unit testing, integration testing, UI testing and acceptance testing, achieving a coverage higher than 80%

## Group
This project has been developed in pairs with: Giovanni Demasi

## Documentation
A complete documentation with all the features and functionalities is availabile in the [design document](https://github.com/Tommaso23/DIMA-Project/blob/master/design_document.pdf)
