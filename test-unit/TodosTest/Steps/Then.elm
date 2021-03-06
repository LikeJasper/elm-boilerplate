module TodosTest.Steps.Then exposing (then')

import ElmTestBDDStyle exposing (expect, toBe)
import Todos.Types exposing (Msg(..), FilterOption(..))
import TodosTest.Context exposing (Context)
import GivenWhenThen.Types
    exposing
        ( ThenStep
        , ThenStepMap
        , ThenFunction
        )
import GivenWhenThen.Helpers
    exposing
        ( constructThenFunction
        , confirmIsJust
        )


then' : ThenFunction Context
then' =
    constructThenFunction stepMap


stepMap : ThenStepMap Context
stepMap =
    [ ( "the existing todo should still exist"
      , thenTheExistingTodoShouldStillExist
      )
    , ( "a todo should be created"
      , thenATodoShouldBeCreated
      )
    , ( "a todo should be created with the current text"
      , thenATodoShouldBeCreatedWithTheCurrentText
      )
    , ( "the current text should be reset"
      , thenTheCurrentTextShouldBeReset
      )
    , ( "the counter should be incremented"
      , thenTheCounterShouldBeIncremented
      )
    , ( "the new text should be stored in the model"
      , thenTheNewTextShouldBeStoredInTheModel
      )
    , ( "nothing should happen"
      , thenNothingShouldHappen
      )
    , ( "the todo should be completed"
      , thenTheTodoShouldBeCompleted
      )
    , ( "the todo should not be completed"
      , thenTheTodoShouldNotBeCompleted
      )
    , ( "the other todo should be completed"
      , thenTheOtherTodoShouldBeCompleted
      )
    , ( "the other todo should not be completed"
      , thenTheOtherTodoShouldNotBeCompleted
      )
    , ( "the todo should be gone"
      , thenTheTodoShouldBeGone
      )
    , ( "the other todo should remain"
      , thenTheOtherTodoShouldRemain
      )
    , ( "the todo should be the currently edited todo"
      , thenTheTodoShouldBeTheCurrentlyEditedTodo
      )
    , ( "the todo text should change"
      , thenTheTodoTextShouldChange
      )
    , ( "there should be no currently edited todo"
      , thenThereShouldBeNoCurrentlyEditedTodo
      )
    , ( "the filter should be set to completed"
      , thenTheFilterShouldBeSetToCompleted
      )
    , ( "the filter should be set to incomplete"
      , thenTheFilterShouldBeSetToIncomplete
      )
    , ( "the filter should be set to all"
      , thenTheFilterShouldBeSetToAll
      )
    ]


thenATodoShouldBeCreatedWithTheCurrentText : ThenStep Context
thenATodoShouldBeCreatedWithTheCurrentText ctx =
    expect True toBe
        <| List.member (confirmIsJust "currentText" ctx.currentText)
        <| List.map (\todo -> todo.text)
        <| .todos (confirmIsJust "model" ctx.model)


thenTheCurrentTextShouldBeReset : ThenStep Context
thenTheCurrentTextShouldBeReset ctx =
    expect "" toBe
        <| .currentText (confirmIsJust "model" ctx.model)


thenTheCounterShouldBeIncremented : ThenStep Context
thenTheCounterShouldBeIncremented ctx =
    expect
        ((confirmIsJust "initialCount" ctx.initialCount)
            + 1
        )
        toBe
        <| .counter (confirmIsJust "model" ctx.model)


thenTheExistingTodoShouldStillExist : ThenStep Context
thenTheExistingTodoShouldStillExist ctx =
    expect True toBe
        <| List.member (confirmIsJust "existingTodo" ctx.existingTodo)
        <| .todos (confirmIsJust "model" ctx.model)


thenATodoShouldBeCreated : ThenStep Context
thenATodoShouldBeCreated ctx =
    expect CreateTodo toBe
        <| confirmIsJust "messageAfter" ctx.messageAfter


thenNothingShouldHappen : ThenStep Context
thenNothingShouldHappen ctx =
    expect NoOp toBe
        <| confirmIsJust "messageAfter" ctx.messageAfter


thenTheNewTextShouldBeStoredInTheModel : ThenStep Context
thenTheNewTextShouldBeStoredInTheModel ctx =
    expect (confirmIsJust "newText" ctx.newText) toBe
        <| .currentText (confirmIsJust "model" ctx.model)


thenTheTodoShouldBeCompleted : ThenStep Context
thenTheTodoShouldBeCompleted ctx =
    expect False toBe
        <| List.isEmpty
        <| List.filter .completed
        <| List.filter (\todo -> todo.id == .id (confirmIsJust "existingTodo" ctx.existingTodo))
        <| .todos (confirmIsJust "model" ctx.model)


thenTheTodoShouldNotBeCompleted : ThenStep Context
thenTheTodoShouldNotBeCompleted ctx =
    expect True toBe
        <| List.isEmpty
        <| List.filter .completed
        <| List.filter (\todo -> todo.id == .id (confirmIsJust "existingTodo" ctx.existingTodo))
        <| .todos (confirmIsJust "model" ctx.model)


thenTheOtherTodoShouldBeCompleted : ThenStep Context
thenTheOtherTodoShouldBeCompleted ctx =
    expect False toBe
        <| List.isEmpty
        <| List.filter .completed
        <| List.filter (\todo -> todo.id == .id (confirmIsJust "secondTodo" ctx.secondTodo))
        <| .todos (confirmIsJust "model" ctx.model)


thenTheOtherTodoShouldNotBeCompleted : ThenStep Context
thenTheOtherTodoShouldNotBeCompleted ctx =
    expect True toBe
        <| List.isEmpty
        <| List.filter .completed
        <| List.filter (\todo -> todo.id == .id (confirmIsJust "secondTodo" ctx.secondTodo))
        <| .todos (confirmIsJust "model" ctx.model)


thenTheTodoShouldBeGone : ThenStep Context
thenTheTodoShouldBeGone ctx =
    expect True toBe
        <| List.isEmpty
        <| List.filter (\todo -> todo.id == .id (confirmIsJust "existingTodo" ctx.existingTodo))
        <| .todos (confirmIsJust "model" ctx.model)


thenTheOtherTodoShouldRemain : ThenStep Context
thenTheOtherTodoShouldRemain ctx =
    expect False toBe
        <| List.isEmpty
        <| List.filter (\todo -> todo.id == .id (confirmIsJust "secondTodo" ctx.secondTodo))
        <| .todos (confirmIsJust "model" ctx.model)


thenTheTodoShouldBeTheCurrentlyEditedTodo : ThenStep Context
thenTheTodoShouldBeTheCurrentlyEditedTodo ctx =
    expect ctx.existingTodo toBe
        <| .currentlyEditing (confirmIsJust "model" ctx.model)


thenTheTodoTextShouldChange : ThenStep Context
thenTheTodoTextShouldChange ctx =
    expect True toBe
        <| List.isEmpty
        <| List.filter (\todo -> todo.text == .text (confirmIsJust "existingTodo" ctx.existingTodo))
        <| .todos (confirmIsJust "model" ctx.model)


thenThereShouldBeNoCurrentlyEditedTodo : ThenStep Context
thenThereShouldBeNoCurrentlyEditedTodo ctx =
    expect Nothing toBe
        <| .currentlyEditing (confirmIsJust "model" ctx.model)


thenTheFilterShouldBeSetToCompleted : ThenStep Context
thenTheFilterShouldBeSetToCompleted ctx =
    expect Completed toBe
        <| .filterOption (confirmIsJust "model" ctx.model)


thenTheFilterShouldBeSetToIncomplete : ThenStep Context
thenTheFilterShouldBeSetToIncomplete ctx =
    expect Incomplete toBe
        <| .filterOption (confirmIsJust "model" ctx.model)


thenTheFilterShouldBeSetToAll : ThenStep Context
thenTheFilterShouldBeSetToAll ctx =
    expect All toBe
        <| .filterOption (confirmIsJust "model" ctx.model)
