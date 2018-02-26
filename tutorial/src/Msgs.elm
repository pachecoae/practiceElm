module Msgs exposing (..)

import Http
import Models exposing (Respondent)
import Navigation exposing (Location)
import RemoteData exposing (WebData)

type Msg
  = OnFetchRespondents (WebData (List Respondent))
  | OnLocationChange Location
  | ChangeAge Respondent Int
  | OnRespondentSave (Result Http.Error Respondent)