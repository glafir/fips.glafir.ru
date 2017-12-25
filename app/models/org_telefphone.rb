class OrgTelefphone < ApplicationRecord
include ActiveModel::Validations
paginates_per 25
belongs_to :org
end
