# RentalHub

RentalHub is a mobile app for iOS developed to help university students and first-time renters manage the rental inspection process.

The application provides features such as; ability to add rental properties, scheduling of inspections, documenting of findings while conducting an inspection, viewing past inspections, saving web links for rentals you have saved from Safari, and viewing your next scheduled inspection from an iOS widget.

## Domain Context

Searching for a rental property can involve keeping track of multiple listings, inspection times, property details, and observations across different apps or notes.

RentalHub brings this information together into one application so that a renter can move from discovering a property to inspecting and reviewing it without losing important information.

The main stakeholder is a university student or first-time renter who is independently searching for rental accommodation.

## Architecture

RentalHub uses MVVM with a Use Case oriented approach to its design architecture.

The main application flow is:

View  
↓  
RentalHubViewModel  
↓  
Use Case  
↓  
RentalPropertyRepository  
↓  
CoreDataRentalPropertyRepository  
↓  
Core Data

By separating these layers, you prevent your SwiftUI Views from being able to access your Core Data and keep all the business rules out of the User Interface.

### Domain Models

The main domain models are:

- `RentalProperty`
- `RentalInspection`
- `InspectionObservation`

These models represent the rental inspection domain independently from Core Data.

### Use Cases

Business operations are handled through dedicated Use Case structures including:

- `SaveRentalPropertyUseCase`
- `ScheduleInspectionUseCase`
- `RecordInspectionObservationUseCase`
- `DeleteRentalPropertyUseCase`

The Use Cases also validate business rules before information is stored.

Examples include:

- A rental property must have an address.
- Weekly rent must be greater than zero.
- An inspection must end after it starts.
- An inspection observation must contain notes.
- The same inspection criterion cannot be recorded twice for the same inspection.

## Database Choice

RentalHub uses **Core Data** as its primary persistent database.

Core Data was chosen because the rental property and inspection data needs to be stored locally and accessed quickly without requiring cloud synchronisation.

The Core Data model contains three related entities:

- RentalPropertyEntity

Stores information about a rental property.

- RentalInspectionEntity

Stores scheduled inspections and is related to a rental property.

- InspectionObservationEntity

Stores all of the observations that are made during an inspection; relates to a rental inspection.

The relationships within this entity enable RentalHub to connect rental property, rentals, inspections and observations.

Access to data in the database is done via the `RentalPropertyRepository` protocol and the `CoreDataRentalPropertyRepository`. In addition, RentalHub will use a predicate query to obtain the next most appropriate inspections based upon the end date of each inspection.

## System Extensions

RentalHub includes two iOS system extensions.

### WidgetKit Extension

The RentalHub widget shows users the date of their next scheduled rental inspection right on the Home Screen.

As for functionality it has:

- A small widget.
- A medium widget.

The main app stores that related rental inspection data inside an App Group shared container. The RentalHub app then requests a refresh of the widget when there are new or updated pieces of inspection data available.

Therefore, renters can easily see what time they have their next inspection at, all without having to open the app.

### Share Extension

With the Share Extension, users can now use Safari to view a rental property listing and select "Share" and then choose to send the link directly to RentalHub.

The URL is stored in the shared App Group container, and RentalHub reads the link and uses LinkPresentation to display a preview inside the Shared Properties screen. This allows users to save rental listings directly from Safari without manually copying and pasting links.

## App Group

The application, Widget Extension, and Share Extension communicate using the following App Group:

`group.com.ZahiOrg.RentalHub`

The App Group is used for lightweight data that needs to be shared between the main application and its extensions.

Core Data remains responsible for the application's main rental property and inspection data.

## Setup Instructions

1. Clone or download the repository.
2. Open `RentalHub.xcodeproj` in Xcode.
3. Select the `RentalHub` scheme.
4. Select an iPhone Simulator.
5. Build and run the application.
6. Ensure the App Group capability is enabled for the required targets using:

   `group.com.ZahiOrg.RentalHub`

7. To test the Share Extension, open Safari in the Simulator, open a rental listing, select Share and choose RentalHub.
8. To test the widget, add the RentalHub widget to the Simulator Home Screen after running the main application.
