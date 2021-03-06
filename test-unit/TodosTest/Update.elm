module TodosTest.Update exposing (testSuite)

import ElmTest exposing (Test, suite)
import GivenWhenThen.Helpers exposing (constructGWTSuite)
import TodosTest.Context exposing (initialContext)
import TodosTest.Steps.Given exposing (given)
import TodosTest.Steps.When exposing (when)
import TodosTest.Steps.Then exposing (then')


createTodoSuite : List Test
createTodoSuite =
    constructGWTSuite
        [ given "an initial count"
            [ given "a current text"
                [ when "a todo is created"
                    [ then' "a todo should be created with the current text"
                    , then' "the current text should be reset"
                    , then' "the counter should be incremented"
                    ]
                , given "an existing todo"
                    [ when "a todo is created"
                        [ then' "a todo should be created with the current text"
                        , then' "the existing todo should still exist"
                        ]
                    ]
                ]
            ]
        ]
        initialContext


updateTextSuite : List Test
updateTextSuite =
    constructGWTSuite
        [ given "a current text"
            [ when "the text is updated"
                [ then' "the new text should be stored in the model" ]
            ]
        ]
        initialContext


markAsCompletedSuite : List Test
markAsCompletedSuite =
    constructGWTSuite
        [ given "an existing todo"
            [ when "the todo is marked as completed"
                [ then' "the todo should be completed" ]
            , given "another existing todo"
                [ when "the todo is marked as completed"
                    [ then' "the other todo should not be completed" ]
                ]
            ]
        ]
        initialContext


markAsIncompleteSuite : List Test
markAsIncompleteSuite =
    constructGWTSuite
        [ given "an existing todo"
            [ given "the todo has been marked as completed"
                [ when "the todo is marked as incomplete"
                    [ then' "the todo should not be completed" ]
                , given "another existing todo"
                    [ given "the other todo has been marked as completed"
                        [ when "the todo is marked as incomplete"
                            [ then' "the other todo should be completed" ]
                        ]
                    ]
                ]
            ]
        ]
        initialContext


deleteSuite : List Test
deleteSuite =
    constructGWTSuite
        [ given "an existing todo"
            [ when "the todo is deleted"
                [ then' "the todo should be gone" ]
            , given "another existing todo"
                [ when "the todo is deleted"
                    [ then' "the other todo should remain" ]
                ]
            ]
        ]
        initialContext


editSuite : List Test
editSuite =
    constructGWTSuite
        [ given "an existing todo"
            [ when "editing the todo is started"
                [ then' "the todo should be the currently edited todo"
                , when "the todo is updated"
                    [ then' "the todo text should change" ]
                , when "editing the todo is finished"
                    [ then' "there should be no currently edited todo" ]
                ]
            ]
        ]
        initialContext


filterSuite : List Test
filterSuite =
    constructGWTSuite
        [ when "the todos are filtered by completed"
            [ then' "the filter should be set to completed" ]
        , when "the todos are filtered by incomplete"
            [ then' "the filter should be set to incomplete" ]
        , when "the todos are filtered by all"
            [ then' "the filter should be set to all" ]
        ]
        initialContext


testSuite : Test
testSuite =
    suite "TodosTest.TodosTest"
        [ suite "createTodo" createTodoSuite
        , suite "updateText" updateTextSuite
        , suite "markAsCompleted" markAsCompletedSuite
        , suite "markAsIncomplete" markAsIncompleteSuite
        , suite "delete" deleteSuite
        , suite "edit" editSuite
        , suite "filter" filterSuite
        ]
