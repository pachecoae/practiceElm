module View exposing (..)

import Html exposing (Html, div, text)
import Models exposing (Model, RespondentId)
import Msgs exposing (Msg)
import Respondents.Edit
import Respondents.List
import RemoteData

view : Model -> Html Msg
view model =
    div []
        [ page model ]

page : Model -> Html Msg
page model =
  case model.route of
    Models.RespondentsRoute ->
      Respondents.List.view model.respondents

    Models.RespondentRoute id ->
      respondentEditPage model id

    Models.NotFoundRoute ->
      notFoundView

respondentEditPage : Model -> RespondentId -> Html Msg
respondentEditPage model respondentId =
  case model.respondents of
    RemoteData.NotAsked ->
      text ""

    RemoteData.Loading ->
      text "Loading ..."

    RemoteData.Success respondents ->
      let
          maybeRespondent =
            respondents
             |> List.filter (\respondent -> respondent.id == respondentId)
             |> List.head
      in
        case maybeRespondent of
          Just respondent ->
            Respondents.Edit.view respondent

          Nothing ->
            notFoundView

    RemoteData.Failure err ->
      text (toString err)

notFoundView : Html msg
notFoundView =
  div []
      [ text "Not found"
      ]