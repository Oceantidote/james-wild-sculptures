class HomepagesController < ApplicationController

  def edit
    @homepage = Homepage.find(params[:id])
  end


  def update
    @homepage = Homepage.find(params[:id])
    if @homepage.update(homepage_params)
      redirect_to root_path, notice: 'homepage was successfully updated.'
    else
      render :edit
    end
  end

  private

  def homepage_params
    params.require(:homepage).permit(:project_one_id, :project_two_id, :project_three_id, :project_four_id, :bronze_title, :bronze_content, :scrap_title, :scrap_content, :work_title, :homepage_content)
  end
end
