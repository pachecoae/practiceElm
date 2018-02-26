module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (RespondentId, Route(..))
import UrlParser exposing (..)

matchers : Parser (Route -> a) a
matchers =
  oneOf
    [ map RespondentsRoute top 
    , map RespondentRoute (s "respondents" </> string)
    , map RespondentsRoute (s "respondents")
    ]

parseLocation : Location -> Route
parseLocation location =
  case (parseHash matchers location) of
    Just route ->
      route
    
    Nothing ->
      NotFoundRoute

respondentsPath : String
respondentsPath =
  "#respondents"

respondentPath : RespondentId -> String
respondentPath id =
  "#respondents/" ++ id