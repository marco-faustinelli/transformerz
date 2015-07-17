
module TestNilsson_03 where 

  import Data.Maybe
  import qualified Data.Map as Map
  import Text.Show.Functions
  import Test.HUnit
  import Nilsson_01
  import Nilsson_02
  import Nilsson_03

  -- Expressions for exercises
  -- var xxxx, yyyy
  watIsXxxx = Var "xxxx"
  watIsYyyy = Var "yyyy"
  two_vars_env = Map.insert "xxxx" (IntVal 123) (Map.insert "yyyy" (IntVal 234) Map.empty)
  xPlusY = Plus (Var "xxxx") (Var "yyyy")
  -- \x -> x
  lambdina = Lambda "x" (Var "x")
  lambdona = Lambda "x" (Lambda "y" (Plus (Var "x") (Var "y")))
  -- 12 + (\x -> x)(4 + 2)
  sample = Plus (Lit 12) (App lambdina (Plus (Lit 4) (Lit 2))) -- IntVal 18
  samplone = App (App lambdona (Lit 4)) (Var "xxxx") -- IntVal (4 + xxxx)
----------------------------


  testEval5bLiteral :: Test
  testEval5bLiteral = 
      TestCase $ assertEqual "eval5b should evaluate a silly literal"
               (Just (IntVal 18)) (runEval5b Map.empty $ eval5b (Lit 18))

  testEval5bVarUndefined :: Test
  testEval5bVarUndefined = 
      TestCase $ assertEqual "eval5b should fail on non-existing vars and write about it"
        (Nothing)
        (runEval5b two_vars_env (eval5b (Var "zzzz")))

  testEval5bVarXxxx :: Test
  testEval5bVarXxxx = 
      TestCase $ assertEqual "eval5b should lookup a Var and write about it"
        (Just (IntVal 123)) 
        (runEval5b two_vars_env (eval5b watIsXxxx))

  testEval5bSimpleApp :: Test
  testEval5bSimpleApp = 
      TestCase $ assertEqual "eval5b should make a simple application"
                             (Just (IntVal 18)) (runEval5b Map.empty $ eval5b sample)

  testEval5bComplexApp :: Test
  testEval5bComplexApp = 
      TestCase $ assertEqual "eval5b should make a complex application"
                             (Just (IntVal 127)) (runEval5b two_vars_env $ eval5b samplone)

  testEval5bCurriedApp :: Test
  testEval5bCurriedApp = 
      TestCase $ assertEqual "eval5b should make a partial application"
                             (Just (FunVal "y" (Plus (Var "x") (Var "y")) (Map.fromList [("x",IntVal 4)]))) 
                             (runEval5b Map.empty $ eval5b (App lambdona (Lit 4)))

  testEval5bCurriedApp2 :: Test
  testEval5bCurriedApp2 = 
      TestCase $ assertEqual "eval5b should spit Nothing in case of errors"
                             (Nothing) 
                             (runEval5b Map.empty $ eval5b (App lambdona (Var "inesistente")))

  testEval5bWatIsXPlusY :: Test
  testEval5bWatIsXPlusY = 
      TestCase $ assertEqual "eval5b should sum two vars"
                             (Just (IntVal 357)) (runEval5b two_vars_env $ eval5b xPlusY)

  testEval5bWatIsXPlusCrash :: Test
  testEval5bWatIsXPlusCrash = 
      TestCase $ assertEqual "eval5b should fail summing stuff when one ain't IntVal"
                             (Nothing) (runEval5b Map.empty $ eval5b (Plus (Lit 123) lambdina))
{--}

  testEval5Literal :: Test
  testEval5Literal = 
      TestCase $ assertEqual "eval5 should evaluate a silly literal"
               (Just (IntVal 18)) (runEval5 Map.empty $ eval5 (Lit 18))

  testEval5VarUndefined :: Test
  testEval5VarUndefined = 
      TestCase $ assertEqual "eval5 should fail on non-existing vars and write about it"
        (Nothing)
        (runEval5 two_vars_env (eval5 (Var "zzzz")))

  testEval5VarXxxx :: Test
  testEval5VarXxxx = 
      TestCase $ assertEqual "eval5 should lookup a Var and write about it"
        (Just (IntVal 123)) 
        (runEval5 two_vars_env (eval5 watIsXxxx))

  testEval5SimpleApp :: Test
  testEval5SimpleApp = 
      TestCase $ assertEqual "eval5 should make a simple application"
                             (Just (IntVal 18)) (runEval5 Map.empty $ eval5 sample)

  testEval5ComplexApp :: Test
  testEval5ComplexApp = 
      TestCase $ assertEqual "eval5 should make a complex application"
                             (Just (IntVal 127)) (runEval5 two_vars_env $ eval5 samplone)

  testEval5CurriedApp :: Test
  testEval5CurriedApp = 
      TestCase $ assertEqual "eval5 should make a partial application"
                             (Just (FunVal "y" (Plus (Var "x") (Var "y")) (Map.fromList [("x",IntVal 4)]))) 
                             (runEval5 Map.empty $ eval5 (App lambdona (Lit 4)))

  testEval5CurriedApp2 :: Test
  testEval5CurriedApp2 = 
      TestCase $ assertEqual "eval5 should spit Nothing in case of errors"
                             (Nothing) 
                             (runEval5 Map.empty $ eval5 (App lambdona (Var "inesistente")))

  testEval5WatIsXPlusY :: Test
  testEval5WatIsXPlusY = 
      TestCase $ assertEqual "eval5 should sum two vars"
                             (Just (IntVal 357)) (runEval5 two_vars_env $ eval5 xPlusY)

  testEval5WatIsXPlusCrash :: Test
  testEval5WatIsXPlusCrash = 
      TestCase $ assertEqual "eval5 should fail summing stuff when one ain't IntVal"
                             (Nothing) (runEval5 Map.empty $ eval5 (Plus (Lit 123) lambdina))
{--}


        
  main :: IO Counts
  main = runTestTT $ TestList [
                                testEval5Literal,
                                testEval5VarUndefined,
                                testEval5VarXxxx,
                                testEval5SimpleApp,
                                testEval5ComplexApp,
                                testEval5CurriedApp,
                                testEval5CurriedApp2,
                                testEval5WatIsXPlusY,
                                testEval5WatIsXPlusCrash,
                                testEval5bLiteral,
                                testEval5bVarUndefined,
                                testEval5bVarXxxx,
                                testEval5bSimpleApp,
                                testEval5bComplexApp,
                                testEval5bCurriedApp,
                                testEval5bCurriedApp2,
                                testEval5bWatIsXPlusY,
                                testEval5bWatIsXPlusCrash
                              ]
