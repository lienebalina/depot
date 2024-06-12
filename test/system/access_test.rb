# frozen_string_literal: true

require 'application_system_test_case'

class AccessTest < ApplicationSystemTestCase
    def setup
      @skip_login = true
      super
    end

    test ' require login to access protected resources' do
      visit login_url
      fill_in 'Name', with: users(:one).name
      fill_in 'Password', with: 'secret'
      click_on 'Login'

      visit orders_url
      assert_selector 'h1', text: 'Orders'

      logout

      visit orders_url
      assert_selector 'h1', text: 'Login'
    end
end
