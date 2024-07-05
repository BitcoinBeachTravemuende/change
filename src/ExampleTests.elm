module ExampleTests exposing (hello, hello2, testEqual, testEqual2)

import Expect
import Test exposing (Test, test)


hello : String -> String
hello =
    \s -> "hello " ++ s


hello2 : String -> String
hello2 =
    String.append <| "hello "


testEqual : Test
testEqual =
    test "hello" <|
        \() ->
            hello "world"
                |> Expect.equal "hello world"


testEqual2 : Test
testEqual2 =
    test "hello2" <|
        \() ->
            hello2 "world22"
                |> Expect.equal "hello world22"
