class PetsController < ApplicationController
  # skip_before_action :authenticate_user!, only: :home

  def index
    @user = current_user
    @pets = Pet.all
  end

  def new
    @pet = Pet.new
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def create
    @user = current_user
    @pet = Pet.new(pet_params)
    @pet.user = @user
    if @pet.save
      redirect_to pet_path(@pet)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @pet = Pet.find(params[:id])
    @user = current_user
    @play_date = PlayDate.new
    @reviews = Review.all
  end

  def update
    @pet.update(pet_params)
    redirect_to pet_path(@pet)
  end

  private

  def pet_params
    params.require(:pet).permit(:pet_type, :name, :breed, :bio, :photo)
  end
end
