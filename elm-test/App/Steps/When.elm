module App.Steps.When exposing (when)

import App.Todos
    exposing
        ( handleKeyUp
        , updateText
        , createTodo
        )
import App.Steps.Helpers
    exposing
        ( WhenStepDefinition
        , WhenStepMap
        , WhenFunction
        , constructWhenFunction
        )
import App.Steps.Context
    exposing
        ( Context
        , getModel
        )


when : WhenFunction Context
when =
    constructWhenFunction whenStepMap


whenStepMap : WhenStepMap Context
whenStepMap =
    [ ( "a todo is created"
      , whenATodoIsCreated
      )
    , ( "the ENTER key is pressed"
      , whenTheEnterKeyIsPressed
      )
    , ( "the T key is pressed"
      , whenTheTKeyIsPressed
      )
    , ( "the text is updated"
      , whenTheTextIsUpdated
      )
    ]


whenATodoIsCreated : WhenStepDefinition Context
whenATodoIsCreated oldCtx =
    let
        oldModel =
            getModel oldCtx
    in
        { oldCtx
            | model = Just (createTodo oldModel)
        }


whenTheEnterKeyIsPressed : WhenStepDefinition Context
whenTheEnterKeyIsPressed oldCtx =
    { oldCtx
        | messageAfter = Just <| handleKeyUp 13
    }


whenTheTKeyIsPressed : WhenStepDefinition Context
whenTheTKeyIsPressed oldCtx =
    { oldCtx
        | messageAfter = Just <| handleKeyUp 84
    }


whenTheTextIsUpdated : WhenStepDefinition Context
whenTheTextIsUpdated oldCtx =
    let
        newText =
            "Update text"

        oldModel =
            getModel oldCtx
    in
        { oldCtx
            | model = Just (updateText newText oldModel)
            , newText = Just newText
        }
