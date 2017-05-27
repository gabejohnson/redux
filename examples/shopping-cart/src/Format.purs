module Format where

import Prelude
import Control.Monad.Aff (Aff)
import DOM.HTML.Types (HTMLElement)
import Data.Maybe (Maybe(..))
import Halogen as H
import Halogen.Aff as HA
import Halogen.HTML as HH
import Halogen.VDom.Driver (runUI)
import Product (format)

data Query a
  = HandleState State a

type State
  = { price :: Number
    , quantity :: Maybe Int
    , title :: String
    }

product :: forall a. H.Component HH.HTML Query State Void a
product =
  H.component
    { initialState: id
    , receiver: const Nothing
    , render: render
    , eval: eval
    }
  where
  render :: State -> H.ComponentHTML Query
  render { price, quantity, title} =
    HH.div
      []
      [ HH.text (format price quantity title)
      ]
  eval :: forall m. Query ~> H.ComponentDSL State Query Void m
  eval = case _ of
    HandleState state next -> do
      H.put state
      pure next

main
  :: HTMLElement
  -> State
  -> Aff (HA.HalogenEffects ()) (State -> Aff (HA.HalogenEffects ()) Unit)
main node state = do
  io <- runUI product state node
  pure \newState -> io.query $ H.action $ HandleState newState
