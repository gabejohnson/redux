import {
  ADD_TO_CART,
  CHECKOUT_REQUEST,
  CLEAR_CART,
  CHECKOUT_FAILURE,
  BUY_ALL
} from '../constants/ActionTypes'

const initialState = {
  addedIds: [],
  quantityById: {}
}

const addedIds = (state = initialState.addedIds, action) => {
  switch (action.type) {
    case ADD_TO_CART:
    case BUY_ALL:
      if (state.indexOf(action.productId) !== -1) {
        return state
      }
      return [ ...state, action.productId ]
    default:
      return state
  }
}

const quantityById = (state = initialState.quantityById, action) => {
  const { productId } = action
  switch (action.type) {
  case ADD_TO_CART:
    return { ...state,
             [productId]: (state[productId] || 0) + 1
           }
    case BUY_ALL:
      return { ...state,
        [productId]: (state[productId] || 0) + action.inventory
      }
    default:
      return state
  }
}

export const getQuantity = (state, productId) =>
  state.quantityById[productId] || 0

export const getAddedIds = state => state.addedIds

const cart = (state = initialState, action) => {
  switch (action.type) {
    case CHECKOUT_REQUEST:
      return initialState
    case CHECKOUT_FAILURE:
      return action.cart
    case CLEAR_CART:
      return initialState
    default:
      return {
        addedIds: addedIds(state.addedIds, action),
        quantityById: quantityById(state.quantityById, action)
      }
  }
}

export default cart
