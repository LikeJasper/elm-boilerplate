module App.Steps.Then exposing (then')

import ElmTestBDDStyle
    exposing
        ( Assertion
        , Test
        , it
        , expect
        , toBe
        )
import App.Todos exposing (Msg(..))
import App.Steps.Context exposing (Context)
import App.Steps.Helpers
    exposing
        ( ThenStep
        , ThenStepDefinition
        , stepNotYetDefined
        , confirmIsJust
        )


then' : String -> ThenStep Context
then' description =
    let
        prefixedDescription =
            "Then " ++ description

        test =
            it prefixedDescription

        stepDefinition =
            case description of
                "the existing todo should still exist" ->
                    thenTheExistingTodoShouldStillExist

                "a todo should be created" ->
                    thenATodoShouldBeCreated

                "a todo should be created with the current text" ->
                    thenATodoShouldBeCreatedWithTheCurrentText

                "the current text should be reset" ->
                    thenTheCurrentTextShouldBeReset

                "the new text should be stored in the model" ->
                    thenTheNewTextShouldBeStoredInTheModel

                "nothing should happen" ->
                    thenNothingShouldHappen

                _ ->
                    stepNotYetDefined (prefixedDescription)
    in
        stepDefinition test


thenATodoShouldBeCreatedWithTheCurrentText : ThenStepDefinition Context
thenATodoShouldBeCreatedWithTheCurrentText test ctx =
    test
        <| expect True toBe
        <| List.member (confirmIsJust "currentText" ctx.currentText)
        <| .todos (confirmIsJust "model" ctx.model)


thenTheCurrentTextShouldBeReset : ThenStepDefinition Context
thenTheCurrentTextShouldBeReset test ctx =
    test
        <| expect "" toBe
        <| .currentText (confirmIsJust "model" ctx.model)


thenTheExistingTodoShouldStillExist : ThenStepDefinition Context
thenTheExistingTodoShouldStillExist test ctx =
    test
        <| expect True toBe
        <| List.member (confirmIsJust "existingTodo" ctx.existingTodo)
        <| .todos (confirmIsJust "model" ctx.model)


thenATodoShouldBeCreated : ThenStepDefinition Context
thenATodoShouldBeCreated test ctx =
    test
        <| expect CreateTodo toBe
        <| confirmIsJust "messageAfter" ctx.messageAfter


thenNothingShouldHappen : ThenStepDefinition Context
thenNothingShouldHappen test ctx =
    test
        <| expect NoOp toBe
        <| confirmIsJust "messageAfter" ctx.messageAfter


thenTheNewTextShouldBeStoredInTheModel : ThenStepDefinition Context
thenTheNewTextShouldBeStoredInTheModel test ctx =
    test
        <| expect (confirmIsJust "newText" ctx.newText) toBe
        <| .currentText (confirmIsJust "model" ctx.model)