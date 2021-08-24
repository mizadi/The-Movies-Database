# The Movie Data Base

## Installation
Please run `pod install` and then run the project.

## Work assessment questions
### Architecture
* I have used MVP (Model View Presenter) in my app.
* My View controllers represent the views, I used presenter to move data between the business logic (Local database or NetworkEngine) to the views.

### Libraries
* The only library I used is R.swift, for the purpose of just making the code simpler and avoid typos in controller/storyboard/reusable identifier etc.
* I could have used SDWebImage, Nuke or KingFisher for loading remote image and managing local cache, I decided to write it myself to demonstrate my skills. I am 100% sure all the libraries I mentioned are better maintained than what I wrote, and I would use any of them in any other case.

### Bugs
* I QA'ed the app and did not run into any bugs, I did find some edge cases and fixed them, but could not detect any more issues.
* It is not a bug but there is a deep security issue here, holding the API key locally is not best practice of course.

### If I had more time
* Improving my unit testing.
* Improve memory management for local images cahcing.

### Challenges
The local database and working with Core Data took a bit of time to remind myself how it works, been a while since I worked with Core Data.

### External links:
* I've used the following to create tableview in an alert dialog: https://stackoverflow.com/questions/38864905/how-to-show-uitableview-in-uialertcontroller-in-swift-ios
* I've used the following link to create a loading cell for the table view when pulling more item:
https://johncodeos.com/how-to-add-load-more-infinite-scrolling-in-ios-using-swift/
* I've used the following to create my network calls: https://aryamansharda.medium.com/ios-interview-assessment-part-2-7933653749dc
* I've used  the following to create my local image caching and downloading: https://www.donnywals.com/efficiently-loading-images-in-table-views-and-collection-views/
