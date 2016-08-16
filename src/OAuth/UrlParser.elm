module OAuth.UrlParser exposing (urlParser)

import String
import Navigation
import OAuth.Types exposing (Error(..))
import OAuth.Copy exposing (getErrorText)


urlParser : Navigation.Parser (Result String String)
urlParser =
    Navigation.makeParser (getFbAccessTokenFromUrl << .hash)


getFbAccessTokenFromUrl : String -> Result String String
getFbAccessTokenFromUrl url =
    case trimLeftOfAccessToken url of
        Ok trimmedUrl ->
            Ok <| trimRightOfAccessToken trimmedUrl

        err ->
            err


trimLeftOfAccessToken : String -> Result String String
trimLeftOfAccessToken url =
    let
        accessTokenString =
            "access_token="

        accessTokenIndex =
            String.indices accessTokenString url
    in
        case accessTokenIndex of
            i :: is ->
                Ok <| String.dropLeft (i + String.length accessTokenString) url

            _ ->
                Err <| getErrorText FbAccessTokenNotFound


trimRightOfAccessToken : String -> String
trimRightOfAccessToken url =
    case String.uncons url of
        Nothing ->
            ""

        Just ( '&', remainder ) ->
            ""

        Just ( tokenPart, remainder ) ->
            String.cons tokenPart <| trimRightOfAccessToken remainder