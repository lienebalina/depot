# frozen_string_literal: true

require 'application_system_test_case'

# carts class tests
class CartsTest < ApplicationSystemTestCase
  setup do
    @cart = carts(:one)
  end

  test 'visiting the index' do
    visit carts_url
    assert_selector 'h1', text: 'Carts'
  end

  test 'should create cart' do
    visit store_index_url
    click_on 'Add to Cart', match: :first
  end

  test 'should update Cart' do
    visit cart_url(@cart)
    click_on 'Edit this cart', match: :first

    click_on 'Update Cart'

    assert_text 'Cart was successfully updated'
    click_on 'Back'
  end

  test 'should empty Cart' do
    visit store_index_url
    click_on 'Add to Cart', match: :first
    click_on 'Empty Cart', match: :first
  end

  test 'should show cart' do
    visit store_index_url
    click_on 'Add to Cart', match: :first

    assert has_text? 'Your Cart', wait: 10
  end

  test 'should hide cart' do
    visit store_index_url
    click_on 'Add to Cart', match: :first
    click_on 'Empty Cart', match: :first

    assert has_no_text? 'Your Cart', wait: 10
  end

  test 'should highlight changed items' do
    visit store_index_url
    click_on 'Add to Cart', match: :first

    assert_selector '.line-item-highlight', count:1
  end
end
