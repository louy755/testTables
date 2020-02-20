class AddFullPaymentToPeople < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :full_payment, :boolean, :default => false
  end
end
