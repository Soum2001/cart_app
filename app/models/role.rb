class Role < ApplicationRecord
    has_many :map_role_users
    has_many :users, through: :map_role_users
end

