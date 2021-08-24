# RickAndMortyWorld
SwiftUI app that lists "Rick and Morty"'s all apisodes. User can check out each episode and its characters and character page with its episodes.
Each page gives user ability to search and filter items with name.

## How it works
- On main page user can check out paginated list of "Rick and Morty's" every episode.
- If app user enters episode name in search field, episodes' list is filtered with the entered word. 
Search is executed every time user changes text.
- From list page, user can navigate to episode details page, were is also displayed list of every character in the episode.
- If user enters character name in search field of episode page, characters' list will be filtered with the entered word. 
Search is executed every time user changes text.
- From episode page user can navigate eather back to home page or to the selected character's detail page.
- On character's detail page user can see characters details and the list of every episode of the character.
- If user enters episode name in search field of episode page, episodes' list will be filtered with the entered word. 
Search is executed every time user changes text.
- From character's details page user can navigate eather back to previos episode page, to the selected epiosde's detail page or to home page.

## Development
- App architecture is MVVM
- App UI is implemented using SwiftUI.
- Networking and ViewModels are implemented using Combine framework.
- Data is fetched using [The Rick and Morty API](https://rickandmortyapi.com/)
