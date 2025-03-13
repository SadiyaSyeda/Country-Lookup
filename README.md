# Country Data Fetching and Filtering

## Overview
This project provides a Swift-based implementation for fetching country data from an API, processing the results, and filtering them based on user input.
It is designed using a modular and testable architecture, following the **Model-View-ViewModel (MVVM)** pattern to ensure a clear separation of concerns. The UI is built using **UIKit**, 
providing a responsive and intuitive experience.
Additionally, the project leverages **Swift Concurrency (async/await)** for efficient asynchronous operations and follows a **protocol-oriented programming** approach to enhance flexibility and testability.

## Key Features
- Fetch country data from a remote JSON source.
- Process and decode the received JSON response into a Swift model.
- Filter the list of countries based on user input.
- Modular architecture with clear separation of concerns.
- Dynamic Type support for improved accessibility, ensuring text scales based on user preferences.
- Universal app with support for both iPhone and iPad.
- Multi-orientation support, allowing the app to work seamlessly in both portrait and landscape modes.
- Unit tests for networking, ViewModel and ViewController logic.

## App Demo

#### iPhone with orientations

![iPhone](https://github.com/user-attachments/assets/109c3d6f-e8f8-4909-9bc5-db3411cd2109)

#### iPad with orientations
![iPad](https://github.com/user-attachments/assets/b3a642ae-7f4b-44a6-b6c5-bceabc78522e)


## Project Structure
### 1. **Networking**
#### `BaseDomain`
Defines the base domain for API requests.
```swift
enum BaseDomain {
    case countries
}
```

#### `HttpMethodType`
Defines HTTP request methods (GET, POST).
```swift
enum HttpMethodType {
    case get
    case post
}
```

#### `RequestType`
Protocol that defines a generic API request.
```swift
protocol RequestType {
    var baseDomain: BaseDomain { get }
    var endpoint: String { get }
    var httpMethod: HttpMethodType { get }
}
```

#### `DataRequestType`
An enumeration that implements `RequestType` for specific data requests.
```swift
enum DataRequestType: RequestType {
    case countries
}
```

#### `RequestBuilder`
Builds `URLRequest` objects from a given `RequestType`.
```swift
struct RequestBuilder {
    func buildRequest(for requestType: RequestType) throws -> URLRequest
}
```

#### `NetworkClient`
Handles executing network requests and returning raw data.
```swift
struct NetworkClient: NetworkClientProtocol {
    func performRequest(for requestType: DataRequestType) async throws -> Data
}
```

### 2. **ViewModel**
#### `CountriesViewModel`
Manages country data, performs network calls, and filters results.
```swift
class CountriesViewModel {
    var countries: [Country]
    var filteredCountries: [Country]
    func fetchCountries() async
    func filterCountries(searchText: String)
}
```

### 3. **Unit Testing**
#### `NetworkClientTests`
Tests the networking layer, including successful and failed responses.
#### `CountriesViewModelTests`
Tests the ViewModel for correct data handling and filtering.
#### `CountriesViewControllerTests`
Tests the ViewController to ensure proper UI updates and user interactions.

#### How to run the App
1. Clone the repository and open it in Xcode.
2. Run the project using the iOS simulator or a physical device.

#### How to run the Tests
1. Open the project in Xcode.
2. Select  Product -> Test or use the  ⌘ + U shortcut.
3. All tests, including network-related ones with mock clients, will run, and the results will be displayed.
