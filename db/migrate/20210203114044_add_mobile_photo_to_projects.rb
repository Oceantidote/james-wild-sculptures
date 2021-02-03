class AddMobilePhotoToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :mobile_photo, :string
  end
end
