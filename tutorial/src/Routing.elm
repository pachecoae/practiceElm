module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (RespondentId, Route(..))
import UrlParser exposing (..)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map RespondentsRoute top
        , map RespondentRoute (s "respondents" </> int)
        , map RespondentsRoute (s "respondents")
        , map GraphRoute (s "graph")
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
    "#respondents/" ++ (toString id)


graphPath : String
graphPath =
    "#graph"
