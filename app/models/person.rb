class Person < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy
  accepts_nested_attributes_for :items, allow_destroy: true, reject_if: proc { |attr| attr['description'].blank? }
  after_create :inv_itms, :inv_tax, :aft_discount, :inv_total, :inv_cost, :inv_profit, :inv_per

  private
    def inv_itms
      inv_itms = 0
      self.items.each do |item|
        inv_itms += item.qunt * item.price
      end
      inv_itms
      self.update(sub_total: inv_itms)
    end
    def inv_tax
       inv_tax = self.sub_total * 10.25 / 100
      self.update(tax: inv_tax)
    end
    def aft_discount
      aft_discount = self.sub_total - self.discount
    end
    def inv_total
      inv_total = aft_discount + self.tax + self.deliver + self.fee
      self.update(total: inv_total )
    end
    def inv_cost
      inv_cost = 0
      self.items.each do |item|
        inv_cost += item.org_price * item.qunt
      end
      inv_cost
      self.update(cost: inv_cost)
    end
    def inv_profit
      inv_profit = (self.sub_total - self.discount) - self.cost
      self.update(profit: inv_profit)
    end
    def inv_per
      inv_per = (self.profit/ (self.sub_total - self.discount) * 100).round(2)
      self.update(margin: inv_per)
    end
end
