%div
  = %Header{ headerText } if headerText?
  = %Footer unless dontIncludeFooter
