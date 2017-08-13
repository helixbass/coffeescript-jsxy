%div
  = if loggedIn
    %Welcome
   else if forbidden
    %GoAway
   else
    %Login
