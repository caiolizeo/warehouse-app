class CategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def new

  end
  
end