module Update exposing (..)

import Commands exposing (saveRespondentCmd)
import Msgs exposing (Msg)
import Models exposing (Model, Respondent)
import RemoteData
import Routing exposing (parseLocation)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchRespondents response ->
            ( { model | respondents = response }, Cmd.none )

        Msgs.OnFetchRespondentGraph response ->
            ( { model | respondents = response }, Cmd.none )

        Msgs.OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )

        Msgs.ChangeAge respondent howMuch ->
            let
                updatedRespondent =
                    { respondent | age = respondent.age + howMuch }
            in
                ( model, saveRespondentCmd updatedRespondent )

        Msgs.OnRespondentSave (Ok respondent) ->
            ( updateRespondent model respondent, Cmd.none )

        Msgs.OnRespondentSave (Err err) ->
            ( model, Cmd.none )


updateRespondent : Model -> Respondent -> Model
updateRespondent model updatedRespondent =
    let
        pick currentRespondent =
            if updatedRespondent.id == currentRespondent.id then
                updatedRespondent
            else
                currentRespondent

        updateRespondentList respondents =
            List.map pick respondents

        updatedRespondents =
            RemoteData.map updateRespondentList model.respondents
    in
        { model | respondents = updatedRespondents }
