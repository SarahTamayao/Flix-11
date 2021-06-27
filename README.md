# Project 2 - FLEX

FLEX is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: 14~ hours spent in total

## User Stories

The following **required** functionality is complete:

- [ ] User sees an app icon on the home screen and a styled launch screen.
- [ ] User can view a list of movies currently playing in theaters from The Movie Database.
- [ ] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [ ] User sees a loading state while waiting for the movies API.
- [ ] User can pull to refresh the movie list.
- [ ] User sees an error message when there's a networking error.
- [ ] User can tap a tab bar button to view a grid layout of Movie Posters using a CollectionView.

The following **optional** features are implemented:

- [ ] User can tap a poster in the collection view to see a detail screen of that movie
- [ ] User can search for a movie.
- [ ] User can view the large movie poster by tapping on a cell.
- [ ] Customize the selection effect of the cell.
- [ ] Customize the navigation bar.
- [ ] Customize the UI.
- [ ] Run your app on a real device.
- [ ] User can click on a poster in grid view and see a modal view of the trailer

The following features are implemented:
- [ ] An alternate details viewing screen with a different UI Layout
- [ ] The use of a gradient background with the combination of clear table view cells
- [ ] The manipulation of border radius to add rounded posters

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. How to extend my app even further with more modals
2. Ways to use another API or a database within the app

## Video Walkthrough

 ![J4ynC7N4 (1)](https://user-images.githubusercontent.com/65196174/123500280-96032800-d602-11eb-8536-9729bba252da.gif)
 
 With Trailer Modal:
 
![ezgif com-gif-maker (2)](https://user-images.githubusercontent.com/65196174/123555055-ec7a7e80-d748-11eb-8316-220010449077.gif)

## Notes

One of the main challenges of building this app was becoming comfortable using multiple ViewControllers. This was something entirely new for me, however doing this assignment along with the lab helped immensely. 

Working through the required tasks was fairly straightforward and I was done with them by the end of Thursday. On Friday, I spent the day completing the optional tasks, but a large portion of that was spent debugging the search bar functionality, implementing design choices, and working on the video view modal. 

- There wasn't an easy way to position components on the storyboard and rearrange them. I found this process to be quite finnicy and I ended up lines of code to manually change border radius and set background images
- I wanted to implement a purple gradient background for the entire app and I talked with my intern manager, John Garrison, to try and find a solution. I posted in the FBU ENG workplace to look for a solution, but the easiest solution ended up being to save a gradient as a photo and then set the background to be that photo. This worked brilliantly and I made the tableView cells clear, so that the gradient would shine through
- I had problems with search bar controller and spent two hours debugging the code. The issue ended up being that the @property that I made was using the weak, nonatomic type instead of the strong, non atomic type. This meant that the garbage collector would trash the memory for my filteredMovies array and then I would crash because I would reference a null variable. 
- Implementing the video modal proved to be a hurdle, but upon my 10pm I almost got it working. I had written all of the logic out, but had a bug somewhere and was unable to have the video play. To test if it was my modal controlller logic or my web api logic I substiuted the final url with an actual website url. When my app still crashed I knew then that the "key compliant" error meant that I may have disconnected an outlet or not properly set up the segue. If I had another hour or so, I think I would have been succesfully able to find this bug.
- Something simple that was giving me a positioning error was that my XCode was set to have an iPhone 11 as the controller size, but my simulator was an iPhone 12. This explained why everything I was implementing was slighlty positioned off and once I fixed this, then I was able to accurately place components on the storyboard where I wanted them to be.

NEW UPDATE -> I decided to spend an hour or so finishing the debugging process of the modal trailer view, so I could learn how to use those concepts. I learned a couple of things from this morning.
1) My original bug originated from saving the id of a particular video as an NSString, but in reality the compiler was saving this number as an NSNumber. I came to this realization by looking up the error statement I kept getting:  "[__NSCFNumber length]: unrecognized selector sent to instance." As a workaround, I used the stringValue function on the id number and then I was able to call the stringByAppendingString function on the base url and the id number. 
2) Using breakpoints is a MUST for debugging. For my main problem, I started off by segmenting my code into different sections— saving the id in the segue, the api request, and the loading of the webKit in the modal. I saw immediately through an NSLog that my id was being fetched correctly but was crashing once I tried to append that string. 
3) When you git commit and use an ! at the end, if you used double quotations then the terminal will return dequote instead of saving the commit. I looked this up and found that when ending a commit message with an exclamation you have to use single quotes ( ' ). 



## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

## License

    Copyright 2021 Dylan Fernandez de Lara

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
