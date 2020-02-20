class AddDetailsToPeople < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :payment_method, :string
    add_column :people, :amount, :decimal, default: "0.0"
    add_column :people, :payment_two_methos, :string
    add_column :people, :amount_two, :decimal, default: "0.0"
    add_column :people, :finance, :string
  end
end
