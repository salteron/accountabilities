class Party < ActiveRecord::Base
  self.abstract_class = true

  has_many :child_accountabilities, class_name: Accountability, as: :parent,
    dependent: :destroy
  has_many :parent_accountabilities, class_name: Accountability, as: :child,
    dependent: :destroy
end
