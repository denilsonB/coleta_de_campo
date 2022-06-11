class Visit < ApplicationRecord
  belongs_to :user
  acts_as_paranoid

  enum status: {PENDENTE: 0, REALIZANDO: 1, REALIZADA: 2}
  validates :user, presence: true
  validates :date, date: { after_or_equal_to: Proc.new { Date.current}}
  validates :checkin_at, date: {before_or_equal_to: Proc.new {Date.current}}
  validates :checkin_at, date: {before: Proc.new {|obj| obj.checkout_at}}
  validates :checkout_at, date: {after: Proc.new {|obj| obj.checkin_at}}

  def checkin
    update_attribute(:checkin_at,DateTime.current)
  end
  
  def checkout
    update_attribute(:checkout_at,DateTime.current)
  end
end
