class Test < ApplicationRecord
  validates :state, presence: true
  validates :test_id, presence: true
  serialize :results, JSON
end
