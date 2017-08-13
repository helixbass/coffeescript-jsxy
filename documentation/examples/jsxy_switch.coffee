Home = ({loggedIn, forbidden}) ->
  %div
    = switch
      when loggedIn  then %Welcome
      when forbidden then %GoAway
      else                %Login
