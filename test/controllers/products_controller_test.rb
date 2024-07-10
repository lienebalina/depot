# frozen_string_literal: true

require 'test_helper'

# products controller tests
class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:ruby)
    @title = "The Great Book #{rand(1000)}"
  end

  test 'should get index' do
    get products_url
    assert_response :success
    assert_select 'nav a', minimum: 4
    assert_select 'tbody td ul li', 9
    assert_select 'h1', 'Programming Ruby 1.9'
  end

  test 'should get new' do
    get new_product_url
    assert_response :success
  end

  test 'should create product' do
    assert_difference('Product.count') do
      post products_url,
           params: { product: { description: @product.description,
                                image_url: @product.image_url,
                                price: @product.price,
                                title: @title } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test 'should show product' do
    get product_url(@product)
    assert_response :success
  end

  test 'should get edit' do
    get edit_product_url(@product)
    assert_response :success
  end

  test 'should update product' do
    patch product_url(@product),
          params: { product: { description: @product.description,
                               image_url: @product.image_url,
                               price: @product.price,
                               title: @title } }
    assert_redirected_to product_url(@product)
  end

  test "can't delete product in cart" do
    assert_difference('Product.count', 0) do
      delete product_url(products(:two))
    rescue ActiveRecord::RecordNotDestroyed
      assert true
    end
  end

  test 'should destroy product' do
    assert_difference('Product.count', -1) do
      delete product_url(products(:one))
    end

    assert_redirected_to products_url
  end
end
