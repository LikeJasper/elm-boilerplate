module Todos.Types
    exposing
        ( Model
        , Todo
        , User
        , Msg(..)
        , Tab(..)
        , FilterOption(..)
        , ProcessedLocation
        , Style
        , QueryUserResponse
        , UserGraph
        )

import OAuth.Types
import Http


type alias Model =
    { counter : Int
    , todos : List Todo
    , filterOption : FilterOption
    , currentText : String
    , currentlyEditing : Maybe Todo
    , oauth : OAuth.Types.Model
    , tab : Tab
    }


type alias Todo =
    { id : Int
    , text : String
    , completed : Bool
    }


type alias User =
    { id : Int
    , todos : List Todo
    }


type FilterOption
    = All
    | Completed
    | Incomplete


type Tab
    = Todos
    | Info


type alias ProcessedLocation =
    { path : String
    , accessToken : Result String String
    }


type alias UserGraph =
    { user : User }


type alias QueryUserResponse =
    { data : UserGraph
    }


type Msg
    = CreateTodo
    | UpdateText String
    | MarkAsCompleted Todo
    | MarkAsIncomplete Todo
    | Delete Todo
    | StartEditing Todo
    | UpdateTodo Todo String
    | StopEditing
    | Filter FilterOption
    | Save
    | SaveFail Http.Error
    | SaveSuccess Int
    | Load
    | LoadFail Http.Error
    | LoadSuccess QueryUserResponse
    | GetOAuthDetailsSucceeded ( String, String )
    | GetOAuthDetailsFailed Http.Error
    | UpdateOAuthAccessToken (Maybe String)
    | SwitchTab Tab
    | NoOp


type alias Style =
    List ( String, String )
