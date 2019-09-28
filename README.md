# landmarksnotes

## Architecture
I used MVVM-C with Repository pattern

**Coordinator**  
Coordinators are the entry point for any logical flow.
Usually the coordinator would have: 
* `UINavigationController`: that allows it to push view controllers to a navigation stack
* `start func`: that starts the flow

In this project there was the UserLoginCoordinator that needed a parent `UIViewController` instead of a `UINavigationController` as it appears modally

**Repository**  
Repository pattern is used here to handle the data layer. In this challenge it was simply saving in a local variable.
Having this pattern allows us to add any additional logic to handle the data; whether locally on the device, or through apis.

## Dependency Injection
I used dependency injection to ensure the code is testable, and that each module has a single responsibility. 
All the needed dependencies were injected in the initializer. This includes handlers that are used for binding the data between the view and view model layers, and also the corresponding coordinators.

## Testing
For this challenge, I provided tests for the view models.
Using DI (Dependency Injection) allowed to create mock dependencies to test our expected behaviours

*Note:*
*There are 3 warnings for not providing all the app icon versions.*