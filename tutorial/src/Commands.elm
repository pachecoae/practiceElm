module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Json.Encode as Encode
import Msgs exposing (Msg)
import Models exposing (RespondentId, Respondent)
import RemoteData

fetchRespondents : Cmd Msg
fetchRespondents =
  Http.get fetchRespondentsUrl respondentsDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.OnFetchRespondents

fetchRespondentsUrl : String
fetchRespondentsUrl =
  "http://localhost:4000/respondents"

respondentsDecoder : Decode.Decoder (List Respondent)
respondentsDecoder =
  Decode.list respondentDecoder

respondentDecoder : Decode.Decoder Respondent
respondentDecoder =
  decode Respondent
    |> required "id" Decode.string
    |> required "name" Decode.string
    |> required "level" Decode.int

saveRespondentUrl : RespondentId -> String
saveRespondentUrl respondentId =
  "http://localhost:4000/respondents/" ++ respondentId

saveRespondentCmd : Respondent -> Cmd Msg
saveRespondentCmd respondent =
  saveRespondentRequest respondent
    |> Http.send Msgs.OnRespondentSave

saveRespondentRequest : Respondent -> Http.Request Respondent
saveRespondentRequest respondent =
  Http.request
    { body = respondentEncoder respondent |> Http.jsonBody
    , expect = Http.expectJson respondentDecoder
    , headers = []
    , method = "PATCH"
    , timeout = Nothing
    , url = saveRespondentUrl respondent.id
    , withCredentials = False
    }

respondentEncoder : Respondent -> Encode.Value
respondentEncoder respondent =
  let
      attributes =
      [ ( "id", Encode.string respondent.id )
      , ( "name", Encode.string respondent.name )
      , ( "level", Encode.int respondent.level )
      ]
  in
      Encode.object attributes