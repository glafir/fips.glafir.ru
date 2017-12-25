class Org < ApplicationRecord
include ActiveModel::Validations
paginates_per 25
has_many :org_addresses
has_many :org_telefphones
end
