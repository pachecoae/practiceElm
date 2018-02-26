module Models exposing (..)

import RemoteData exposing (WebData)

type alias Model =
  { respondents : WebData (List Respondent)
  , route : Route
  }

initialModel: Route -> Model
initialModel route =
  { respondents = RemoteData.Loading
  , route = route
  }

type alias RespondentId =
  String

type alias Respondent =
  { id : RespondentId
  , name : String
  , level : Int
  }

type Route
  = RespondentsRoute
  | RespondentRoute RespondentId
  | NotFoundRoute