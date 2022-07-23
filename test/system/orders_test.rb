require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "should create order" do
    visit orders_url
    click_on "New order"

    fill_in "Address", with: @order.address
    fill_in "Email", with: @order.email
    fill_in "Name", with: @order.name
    fill_in "Pay type", with: @order.pay_type
    click_on "Create Order"

    assert_text "Order was successfully created"
    click_on "Back"
  end

  test "should update Order" do
    visit order_url(@order)
    click_on "Edit this order", match: :first

    fill_in "Address", with: @order.address
    fill_in "Email", with: @order.email
    fill_in "Name", with: @order.name
    fill_in "Pay type", with: @order.pay_type
    click_on "Update Order"

    assert_text "Order was successfully updated"
    click_on "Back"
  end

  test "should destroy Order" do
    visit order_url(@order)
    click_on "Destroy this order", match: :first

    assert_text "Order was successfully destroyed"
  end

  # This test will not work for now because of webpack issue of not rendering component first time
  test "check routing number" do
    visit store_index_url

    click_on 'Add to Cart', match: :first
    
    click_on 'Checkout'

    fill_in 'order_name', with: 'Dave Thomas'
    fill_in 'order_address', with: '123 Main'
    fill_in 'order_email', with: 'dave@example.com'
    
    ## Checking if element with if #order_routing_number is not on screen before 'Check' type clicked
    assert_no_selector "#order_routing_number"

    select 'Check', from: 'Pay type'

    ## Checking if element with if #order_routing_number is on screen
    assert_selector "#order_routing_number"
  end
end
