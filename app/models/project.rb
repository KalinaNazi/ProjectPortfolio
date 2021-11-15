class Project < ApplicationRecord
    # Requires a title and description
    validates_presence_of :title, :description
end
