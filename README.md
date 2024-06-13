## Fetch Coding Challenge
![Demo](https://github.com/jtabraham123/FetchCodingChallenge/blob/master/RPReplay_Final1716498481.gif)

## Summary
In this coding challenge, I chose to write code in MVVM architecture with SwiftUI. Following feedback given on May 28, force unwrapping and nil checks were removed in place of swift language tooling "if let ...", result types cleaned up state management, and I followed the separation of concerns principle more closely: logic abstracted from view and network calls abstracted from view models. I used Swinject for dependency injection and Combine for asynchronous sections. Swinject instantiates a few objects as .container scope (singletons): all the services, the DessertListCoordinator, and the Image Repostiory. The only object with a reference to the Swinject resolver is the DessertListCoordinator: this is so the coordinator can inject the viewModels. For the most part, I followed this project's example: https://github.com/jasonjrr/MVVM.Demo.SwiftUI where the coordinator serves the purpose of injecting view models and navigation logic with the NavigationPath type path variable. The views solely present data from the view models. The view models handle presentation data. The services handle networking, and the in-memory image repository cache stores the images collected from the ImageLoadService. Overall, I really enjoyed tackling the coding challenge and working with MVVM architecture in Swift. Thank you for the opportunity—it was a rewarding experience!


## App Architecture
Note: arrows point in the direction of dependencies, the data flows the opposite direction for the most part
<a href="https://www.figma.com/file/N7S0U9JGKEXbFLYUqsjmWW/DessertChallengeArchitecture?node-id=0-1&t=om8l8utkUD7ZHipl-1">
  <img src="FigmaDessertChallengeArch.png" alt="System Architecture" style="width:10000px;height:auto;">
</a>
