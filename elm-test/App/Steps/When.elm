module App.Steps.When exposing (when)

import ElmTestBDDStyle
    exposing
        ( Assertion
        , Test
        , describe
        )
import App.Todos
    exposing
        ( handleKeyUp
        , updateText
        , createTodo
        )
import App.Steps.Helpers
    exposing
        ( WhenStep
        , WhenStepDefinition
        , stepNotYetDefined
        , runTestsWithCtx
        )
import App.Steps.Context
    exposing
        ( Context
        , getModel
        )


when : String -> WhenStep Context
when description =
    let
        prefixedDescription =
            "When " ++ description

        suite =
            describe prefixedDescription

        stepDefinition =
            case description of
                "a todo is created" ->
                    whenATodoIsCreated

                "the ENTER key is pressed" ->
                    whenTheEnterKeyIsPressed

                "the T key is pressed" ->
                    whenTheTKeyIsPressed

                "the text is updated" ->
                    whenTheTextIsUpdated

                _ ->
                    stepNotYetDefined (prefixedDescription)
    in
        stepDefinition suite


whenATodoIsCreated : WhenStepDefinition Context
whenATodoIsCreated suite tests oldCtx =
    suite
        <| let
            oldModel =
                getModel oldCtx

            ctx =
                { oldCtx
                    | model = Just (createTodo oldModel)
                }
           in
            runTestsWithCtx ctx tests


whenTheEnterKeyIsPressed : WhenStepDefinition Context
whenTheEnterKeyIsPressed suite tests oldCtx =
    suite
        <| let
            ctx =
                { oldCtx
                    | messageAfter = Just <| handleKeyUp 13
                }
           in
            runTestsWithCtx ctx tests


whenTheTKeyIsPressed : WhenStepDefinition Context
whenTheTKeyIsPressed suite tests oldCtx =
    suite
        <| let
            ctx =
                { oldCtx
                    | messageAfter = Just <| handleKeyUp 84
                }
           in
            runTestsWithCtx ctx tests


whenTheTextIsUpdated : WhenStepDefinition Context
whenTheTextIsUpdated suite tests oldCtx =
    suite
        <| let
            newText =
                "Update text"

            oldModel =
                getModel oldCtx

            ctx =
                { oldCtx
                    | model = Just (updateText newText oldModel)
                    , newText = Just newText
                }
           in
            runTestsWithCtx ctx tests