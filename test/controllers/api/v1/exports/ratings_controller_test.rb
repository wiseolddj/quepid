# frozen_string_literal: true

require 'test_helper'

module Api
  module V1
    module Export
      class RatingsControllerTest < ActionController::TestCase
        let(:doug) { users(:doug) }

        before do
          @controller = Api::V1::Export::RatingsController.new

          login_user doug
        end

        describe 'Exporting a case in json' do
          let(:the_case)  { cases(:one) }
          let(:matt_case) { cases(:matt_case) }

          test "returns a not found error if the case is not in the signed in user's case list" do
            get :show, case_id: matt_case.id
            assert_response :not_found
          end

          test 'returns case info' do
            get :show, case_id: the_case.id
            assert_response :ok

            body = JSON.parse(response.body)

            assert_equal body['queries'].size,         the_case.queries.size
            assert_equal body['queries'][0]['query'],  the_case.queries[0].query_text
          end
        end
      end
    end
  end
end
