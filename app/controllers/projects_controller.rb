class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :scrap, :bronze]
  before_action :find_project, only: [:show, :edit, :update, :destroy]

  def bronze
    @projects = Project.where(bronze: true).reverse
    @homepage = Homepage.first
  end

  def scrap
    @projects = Project.where(bronze: false).reverse
    @homepage = Homepage.first
  end

  def show
    @photos = @project.photos.select{ |photo| photo.url.url != nil }
    @photos.reverse!
    @message = Message.new
  end

  def new
    @project = Project.new
    @photo = @project.photos.build
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    params[:project][:bronze] == "BRONZE" ? @project.bronze = true : @project.bronze = false
    if @project.save && params[:photos]
      params[:photos]['url'].each do |uri|
        @photo = @project.photos.create!(url: uri)
      end
      redirect_to project_path(@project)
    elsif @project.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @project.update(project_params)
    if @project.save
      if params[:photos]
        params[:photos]['url'].each do |uri|
          @project.photos.create!(url: uri)
        end
      end
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to :root
  end

  private

  def find_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:sub, :photo, :mobile_photo, :name, :description, :featured, :edition, :year, :dimensions, :finish, :price, photos_attributes: [:url, :id, :project_id])
  end
end
