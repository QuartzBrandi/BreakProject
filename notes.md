# Notes & Brainstorming

- Filter out DLC (and possibly games with 0 players).
- Search for specific game.
- Filter by multiplayer games?
- Create a session when the user searches for a specific player, giving an option similar to "not PLAYER_NAME?" to "logout"/clear the session, so they don't need to search for the user every time. OR even better, offer a checkbox to remember (to start a session) if checked when searching / accessing a player's game library.
- Error/flash messages for:
  - private users
  - when the API fails
  - something went wrong
- Maybe try and make a unique 404 page? That'd be cool...
- Delete records from the database if created over 60 days ago?
  - (Routine cleaning?)
  - ALSO, expire cookies after 60 days?
  - OR, check session, if player_id does not exist anymore, set session to nil.

Name Brainstorm for Site:
How Many Steam Players?
Player Count
Steam Player Count
Steam Library Player Count
How Active is My Steam Library?
My Steam Pop
Steam Pop(ulation) in Perspective

... All of these are pretty lame.
- Should probably have 'Steam' in the name.

REMINDERS:
- [✓] Need to mention "Powered by Steam" if using Steam API.
  - [✓] Read all the Terms of Use for the Steam API (make sure there isn't anything else I'm missing).

# MORE NOTES
save game stats
  update when a user visits the site
  update every 5 - 10 minutes?

save player's game libraries? -- save player's game libraries in their cookies?
  if a session[library] exists, create a "not USERNAME?" button
  make an occasional check that user is not private?
    if the site was last viewed (session[last_viewed]?) over 30 minutes ago (or an hour), check to see if that user is private
    "not USERNAME?"
    "not looking at USERNAME?"
    "find a new player"
    "find another player <small>currently looking at USERNAME</small>"

Steam Requirements:
- Each page that uses the Steam Web API must contain a link to http://steampowered.com with the text "Powered by Steam". We suggest that you put this link in your footer so it is out of the way but still visible to interested users.
- You will post a privacy policy regarding the use of nonpublic end user data (including such Steam Data), and you will treat the Steam Data consistent with that policy. You will only retrieve Steam Data about a Steam end user as requested by the end user. You will inform the end user about any Steam Data you will store, and you will store the Steam Data in a country (or countries) identified in your privacy policy.
- You are limited to one hundred thousand (100,000) calls to the Steam Web API per day. Valve may approve higher daily call limits if you adhere to these API Terms of Use.

create a log database?
  logs how many calls each day to the API?
  checks to make sure is less than 100,000 for the day?

popup when loading -- if querying API


controllers:
[✓] home
[✓] sessions
  player_id

models:
[✓] games
[✓] users? / players
  player id
  player name
  player library
  player private: false
    if player private: true then remove all player library
