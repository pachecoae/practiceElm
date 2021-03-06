module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { respondents : WebData (List Respondent)
    , route : Route
    }


initialModel : Route -> Model
initialModel route =
    { respondents = RemoteData.Loading
    , route = route
    }


type alias RespondentId =
    Int


type alias Respondent =
    { id : RespondentId
    , name : String
    , age : Int
    }


type alias DataPoint =
    { x : Float
    , y : Float
    }


type Route
    = RespondentsRoute
    | RespondentRoute RespondentId
    | GraphRoute
    | NotFoundRoute
