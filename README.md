# Fuze App

## Environment

This app was built using UIKit and Swift, and for dependency manager SPM (Swift Package Manager) was used. You will need to run on Xcode 14 or above.

## Dependencies

- [Nuke](https://github.com/kean/Nuke) - Nuke provides an efficient way to download and display images in your app. It's easy to learn and use. Its architecture enables many powerful features while offering virtually unlimited possibilities for customization.

### Implementation

The app was implemented following the instructions given on the Notion file. It contains only two view controllers where the first shows a list of upcoming CS GO matches and upon clicking on any match, the details screen show the details for that match as well as the team players for each team. 

The weather informations displayed on the screen are coming from `GET https://api.pandascore.co/csgo/matches/upcoming` API call. And the team details is coming from `GET https://api.pandascore.co/csgo/teams` with a filter by teamID.

The architecture used was MVVM (Model-View-ViewModel) where we have the Match and Team models, the MatchesListViewController and MatchViewController and the MatchesViewModel and MatchDetailViewModel which takes care of fetching and preparing the data, so the view can take up them and use the proper data to populate itself.

CLEAN principles were used for designing the API layer and the way it's used in the view models, through Procotols. So it makes easy for us to mock the API service into the view models while creating unit tests for our code base.

#### Basic unit tests were added for:

- View Model;
- URLConstants;
- Constants;
- View Controller, to make sure UI was correctly configured via ViewCode;
- And also for the requests that are built for API calls;

### How to run

- Just open the `Fuze.xcodeproj` and run;
