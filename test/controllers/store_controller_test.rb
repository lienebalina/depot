# frozen_string_literal: true

require 'test_helper'

# store controller tests
class StoreControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get store_index_url(locale: :en)
    assert_response :success
    assert_select 'nav a', minimum: 4
    assert_select 'turbo-frame', 3
    assert_select 'h2', 'Programming Ruby 1.9'
    assert_select 'div', /\$[,\d]+\.\d\d/
  end
end
