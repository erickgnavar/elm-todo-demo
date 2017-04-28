module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initModel
        , view = view
        , update = update
        }


type alias Todo =
    { id : Int
    , name : String
    }


type alias Model =
    { newTodoName : String
    , todos : List Todo
    , counter : Int
    }


type Msg
    = Add
    | ChangeInput String
    | Delete Todo


sampleTodos : List Todo
sampleTodos =
    [ { id = 1, name = "task 1" }
    , { id = 2, name = "task 2" }
    ]


initModel : Model
initModel =
    { newTodoName = ""
    , todos = sampleTodos
    , counter = 3
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Add ->
            { model
                | todos =
                    { id = model.counter
                    , name = model.newTodoName
                    }
                        :: model.todos
                , counter = model.counter + 1
                , newTodoName = ""
            }

        ChangeInput text ->
            { model | newTodoName = text }

        Delete todo ->
            { model | todos = List.filter (\t -> t.id /= todo.id) model.todos }


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ input
                [ type_ "text"
                , autofocus True
                , placeholder "Enter todo name"
                , onInput ChangeInput
                , value model.newTodoName
                ]
                []
            , button [ onClick Add ] [ text "+" ]
            ]
        , (todoListView model.todos)
        ]


todoListView : List Todo -> Html Msg
todoListView todos =
    todos
        |> List.map todoView
        |> ul []


todoView : Todo -> Html Msg
todoView todo =
    li []
        [ text todo.name
        , button [ onClick (Delete todo) ] [ text "X" ]
        ]
