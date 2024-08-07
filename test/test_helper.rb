# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

# test helper module
module ActiveSupport
  # test case helper class
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors, with: :threads)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end

  class ActionDispatch::IntegrationTest
    parallelize(workers: 1)

    def login_as(user)
      if respond_to? :visit
        visit login_url
        fill_in :name, with: user.name
        fill_in :password, with: 'secret'
        click_on 'Login'
      else
        post login_url, params: { name: user.name, password: 'secret' }
      end
    end

    def logout
      delete logout_url
    end

    def setup
      login_as users(:one) if defined?(users) && !@skip_login
    end
  end
end
