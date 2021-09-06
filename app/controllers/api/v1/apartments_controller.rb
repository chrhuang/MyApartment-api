class Api::V1::ApartmentsController < Api::V1::BaseController
  def index
    @apartments = policy_scope(Apartment)
  end
end
