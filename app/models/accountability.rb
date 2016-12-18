class Accountability < ActiveRecord::Base
  belongs_to :parent, polymorphic: true
  belongs_to :child, polymorphic: true
  validates :parent, :child, presence: true
  validates :parent_id, uniqueness: {scope: %i[parent_type child_id child_type]}
  scope :active, -> { where(is_active: true) }
end
