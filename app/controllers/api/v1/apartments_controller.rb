class Api::V1::ApartmentsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: %i[]
  before_action :set_apartment, only: %i[show destroy]

  def index
    @apartments = policy_scope(current_user.apartments) if signed_in?
  end

  def show; end

  def update
    if @apartment.update(apartment_params)
      render :show
    else
      render_error
    end
  end

  def destroy
    @apartment.destroy
    head :no_content
    # No need to create a `destroy.json.jbuilder` view
  end

  def create
    @apartment = Apartment.new(apartment_params)
    @apartment.user = current_user
    authorize @apartment
    if @apartment.save
      render :show, status: :created
    else
      render_error
    end
  end

  private

  def set_apartment
    @apartment = Apartment.find(params[:id])
    if @apartment.user == current_user
      authorize @apartment  # For Pundit
    else
      render json: { errors: "You can't access to this apartment" },
             status: :unprocessable_entity
    end
  end

  def apartment_params
    params.require(:apartment).permit(:name, :address)
  end

  def render_error
    render json: { errors: @apartment.errors.full_messages },
           status: :unprocessable_entity
  end
end
