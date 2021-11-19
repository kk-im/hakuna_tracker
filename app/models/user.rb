class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :projects, dependent: :destroy

  def current_user_projects
    projects = self.projects
    project_name_with_id = []
    projects.each do |project|
      project_name_with_id << [project.name, project.id]
    end
    project_name_with_id
  end

end
