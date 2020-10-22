# test-app-github
## Decription
This project is made to retrieve repositories from Github. 
There are two main opportunities included: 
  1. Viewing the whole list (starting from the first GitHub repo).
  2. Searching repositories by name or the keyword contained in the repo's name.
  
The repositories are displayed in the table view. Each line contains the name of the specific repository. Pressing the row opens the repository link in the web browser.

## How to Use?
The starting screen displays two main buttons:
  1. "View all Repos". Pressing it the user is taken to the new screen where the searchbar and the table are shown. The table represents 100 first repositories in GitHub sorted by their id (low -> high), which is displayed as well. Scrolling down to the end loads 100 more repositories etc. (pagination). 
  Typing a word in a searchbar filters displayed (loaded) repositories and makes the table show only ones whose names contain typed text.
  When the repository is selected, the checkmark is added and the repository link is opened.
  Opened repositories are saved, so after closing the app the data won't be deleted and it will be displayed the next time app is opened.
  
  2. "Search by name". Pressing it the user is taken to the new screen where the search field (textfield), search button and the table are shown. From the start the table is empty. User may type some text in the search field and press the search button. By doing this actions user makes the table show repositories, whose names contain this word(s).
  Table shows 30 results, sorted by stars (high -> low) and the actual amount of stars is shown too. Scrolling down to the end loads 30 more repositories etc. (pagination).
  When the repository is selected, the checkmark is added and the repository link is opened.
  Opened repositories are saved, so after the app is closed the data won't be deleted and it will be displayed the next time app is opened.

## Author
Elina Semenko
