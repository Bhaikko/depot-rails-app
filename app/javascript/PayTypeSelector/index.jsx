// File containing React component that will render PayTypeSelector component
import React from 'react';

class PayTypeSelector extends React.Component {
  render() {
    return (
      <div className='field'>
        <label htmlFor='order_pay_type'>Pay Type</label>
        {/* Choosing name as order[pay_type] as it is dependent on form values */}
        <select id="order_pay_item" name="order[pay_type]">
          <option value="">Select a payment method</option>
          <option value="Check">Check</option>
          <option value="Credit card">Credit card</option>
          <option value="Purchase order">Purchase order</option>
        </select>
      </div>
    );
  }
}
export default PayTypeSelector;