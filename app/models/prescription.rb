class Prescription < ActiveRecord::Base

validates :drug_uom, presence: true
validates :quantity, presence: true
validates :cost_not_in_dh, presence: true


belongs_to :drug

end
