class Admin < ActiveRecord::Base
  ROLES = %w[Admin Employee Recipient]
  validates :role, inclusion: { in: ROLES }
end
