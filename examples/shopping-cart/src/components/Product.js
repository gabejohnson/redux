import React from 'react'
import PropTypes from 'prop-types'
import { format , logPrice } from '../purs/Product'
import { main } from '../purs/Format'
import { Nothing, Just } from '../purs/Data.Maybe'

class PureScript extends React.Component {
  initialize(props) {
    return (node) => {
      if (node != null) {
        props.main(node)(props.state)((query) => {
          this.query = query;
        }, _ => {
          // Actuallly handle errors
        });
      }
    };
  }

  componentWillReceiveProps(props) {
    if (this.query) {
      // Handle the cases here as well.
      this.query(props.state)(_ => null, _ => null);
    }
  }

  shouldComponentUpdate(nextProps, nextState) {
    return false;
  }

  render() {
    return (
      <div ref={this.initialize(this.props)}></div>
    );
  }
}

const Product = ({price, quantity, title}) => {
   const state = {
    price,
    quantity: quantity ? Just.create(quantity) : Nothing.value,
    title
  };

  return (<PureScript main={main} state={state} />);
};


Product.propTypes = {
  price: PropTypes.number,
  quantity: PropTypes.number,
  title: PropTypes.string
}

export default Product
