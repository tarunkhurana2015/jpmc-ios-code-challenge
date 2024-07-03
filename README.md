# JPMC Coding challenge

## Weather App (iOS)

#### platform - iOS (iPhone/ iPad)

#### Requirements

These requirements are rather high-level and vague. If there are details I have omitted, it is because I will be happy with any of a wide variety of solutions. Don't worry about finding "the" solution.

Create a browser or native-app-based application to serve as a basic weather app.
Search Screen
Allow customers to enter a US city
Call the openweathermap.org API and display the information you think a user would be interested in seeing. Be sure to has the app download and display a weather icon.
Have image cache if needed
Auto-load the last city searched upon app launch.
Ask the User for location access, If the User gives permission to access the location, then retrieve weather data by default
In order to prevent you from running down rabbit holes that are less important to us, try to prioritize the following:

#### What is Important

Proper function – requirements met.
Well-constructed, easy-to-follow, commented code (especially comment hacks or workarounds made in the interest of expediency (i.e. // given more time I would prefer to wrap this in a blah blah blah pattern blah blah )).
Proper separation of concerns and best-practice coding patterns.
Defensive code that graciously handles unexpected edge cases.

#### What is Less Important

UI design – generally, design is handled by a dedicated team in our group.
Demonstrating technologies or techniques you are not already familiar with (for example, if you aren't comfortable building a single-page app, please don't feel you need to learn how for this).

#### iOS:

1. For applications that include CocoaPods with their project code, having the Pods included in the code commits as the source is recommended. (Even though it goes against the CocoaPod's general rules). 
2. Be sure to use safe area insets 
3. Using Sizeclass wisely for landscape and portrait  
4. Make sure to use UIKit, we would love to see a combination of both UIKit and SwiftUI if you desire.

### Developer Notes
#### Tech Stack

- Swift - 5.5
- iOS - 17.0 and above
- View - SwiftUI 
- Data - Swift Codable
- Design Pattern - MVVM, Protocols, Factory, Observable
- Networking - URLSession
- Image Cache - NSCache
- Data Cache - UserDefauls
- Unit Tests - XCTestCase
- Concurrency - Structured concurrency (async/ await)

#### Requirements Validation

- [X] Create a browser or native-app-based application to serve as a basic weather app.   
    1. The native is created for `iOS (iPhone and iPad)` in both the device orientation.
    2. The layouts could be further improved.
    3. The app icon is missing and can be added. 
- [X] Search Screen
    1. The search is globally accessible from the main Weather View screen.
    2. The search term is used to make the `GeoCode` api call to fetch the `lat`, `lon` and then the `weather` api is used to fetch the weather details.
- [x] Allow customers to enter a US city
    1. The customer can enter any text in the search box with this release.
    2. I was not sure if i had to check the list of the US cities to validate this or integrate with a seprate api that can do the city validation, before making the weather api call.
    3. Alternatively, we could check for the weather api response  `sys->country` to promnt the user with an error, mentionig that entered city is not a valid search, but that will be after the fact that the weather response has been fetched.
- [X] Call the openweathermap.org API and display the information you think a user would be interested in seeing. Be sure to has the app download and display a weather icon.
    1. Currently, i am displating the following weather informations
        
        - City Name. `name`
        - Current local time, calculated from the `timezone` offset.
        - temperature `main.temp`
        - description `weather[0].description`
        - high and low temperatures `main.temp_max` `main.temp_min`
        - Weather icon fetched from the https://openweathermap.org/img/wn , by appeding the `weather[0].icon@2x`
        - Wind `wind.speed`
        - Humidity `wind.humidity` 
- [X] Have image cache if needed
    1. CurrentlyCached in the `NSCache`
- [X] Auto-load the last city searched upon app launch.
    1. If the location authorization was `denied` then the it loads the last stored city, if found in the storage.
    2. If the location was `authorized`, if displays the current user's location weather.
    3. If the location was `authorized` `once only` on the first launch and then `denied` on the subsequent launch, it will show the last stored location weather details.
- [X] Ask the User for location access, If the User gives permission to access the location, then retrieve weather data by default
    1. On launch, the location manager promts the user to allow the location tracking and based the user permission, the coordidates are fetched to get the weather detaails.

#### Platform Requirements Validation (iOS)
- [X] For applications that include CocoaPods with their project code, having the Pods included in the code commits as the source is recommended. (Even though it goes against the CocoaPod's general rules). 
    1. Not used any 3rd party frameworks. Took some code inspiration for writing the `Log.swift` and `ImageCache.swift`
- [X] Be sure to use safe area insets 
- [X] Using Sizeclass wisely for landscape and portrait  
- [] Make sure to use UIKit, we would love to see a combination of both UIKit and SwiftUI if you desire.
    1. Did not get the chance to mix and match this time.

#### Code validation (XCTestCase) (iOS)
1. Written the basic and important tests to validate the business logic written in the service and view model layers.
2. Mostly, have covered all the succes cases.
3. There is room to write more valid tests using the mocks.
4. The following are the list of the tests.
    
    - `WeatherServiceTests`
    - `WeatherURLFactoryTests`
    - `WeatherViewModelTests`
    - `LocationStorageTests`

#### App Screenhots
[iPhone startup](https://gitlab.com/personal9035708/WeatherApp/-/blob/main/screenshots/1.png)

[iPhone Landing](https://gitlab.com/personal9035708/WeatherApp/-/blob/main/screenshots/2.png)

[iPhone Search](https://gitlab.com/personal9035708/WeatherApp/-/blob/main/screenshots/3.png)

[iPhone landscape](https://gitlab.com/personal9035708/WeatherApp/-/blob/main/screenshots/4.png)

[iPad landscape](https://gitlab.com/personal9035708/WeatherApp/-/blob/main/screenshots/5.png)


