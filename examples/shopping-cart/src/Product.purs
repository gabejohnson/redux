module Product where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.Maybe (Maybe(..))
import Data.Function.Uncurried (Fn3, mkFn3)

format :: Number -> (Maybe Int) -> String -> String
format = \price quantity title ->
  title <> " - $" <> show price <> formatQuantity quantity

formatQuantity :: Maybe Int -> String
formatQuantity = case _ of
  Nothing -> ""
  Just quantity -> " x " <> show quantity

logPrice :: forall e. Number -> Eff (console :: CONSOLE | e) Unit
logPrice price =
  log ("This price is: " <> show price)

foo :: forall r. { bar :: Int | r} -> Int
foo obj = obj.bar

data OurMaybe a
  = None
  | Some a
type First = String
type Last = String

fullName :: First -> Last -> String
fullName first last = first <> last

bill :: String
bill = fullName billLast billFirst
billFirst :: First
billFirst = "Bill"
billLast :: Last
billLast = "Llib"

data FirstName = FirstName String
data LastName = LastName String

fullNameSafe :: FirstName -> LastName -> String
fullNameSafe (FirstName first) (LastName last) = first <> last

billFirstSafe :: FirstName
billFirstSafe = FirstName "Bill"

billLastSafe :: LastName
billLastSafe = LastName "Llib"

billSafe :: String
billSafe = fullNameSafe billFirstSafe billLastSafe

newtype FirstNameNewtype = FirstNameNewtype String

getFirst :: FirstNameNewtype -> String
getFirst (FirstNameNewtype str) = "The first name is: " <> str

bar :: String
bar = getFirst (FirstNameNewtype "bar")

data Query a
  = Toggle a
  | IsOn (Boolean -> a)
