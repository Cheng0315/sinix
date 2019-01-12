class Project < ActiveRecord::Base
  belongs_to :user
  belongs_to :project_type
end
