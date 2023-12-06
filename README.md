# SquareRepositoriesListApp

## Build Details

Using Swift 5 for development\
Using XCode 15.0.1\
Using SwiftUI, URLsession, Combine.

## Architecture

This is using the MVVM repository pattern.

## Code Structure

 **View** 
 
    There are two view classes: RepositoryListView & RepositoryCardView

    RepositoryListView is the main view that displays the list of cards representing a repository.
    RepositoryCardView is the sub-view that is reused to create each card in a desired layout.
    
 **ViewModel**
 
    ViewModel conforms to ObservableObject and it pulls the data from the Repository and displays it in the UI.
    ViewModel communicates to view and binds the data using Combine. 
    
    
 **Model**
 
    These are structs that satisfy codable protocol to decode data from JSON.
    
Networking layer

This contains a Generic Network layer that supports GET and POST requests. Returns completion block with data or error.

Repository Layer

This is the abstraction between ViewModel and the networking layer. This will get data from the network layer and decode it as needed to a single object or array of objects This is Mocked in the testing layer to stub local JSON data.

Unit Tests

Unit tests are done using the XCTest framework
Unit test cases are written for the business logic present in ViewModel.
A mock Repository layer is created to test REST API calls and data is stubbed from locally stored JSON file.
