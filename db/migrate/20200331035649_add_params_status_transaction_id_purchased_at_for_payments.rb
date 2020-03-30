class AddParamsStatusTransactionIdPurchasedAtForPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :status, :string
    add_column :payments, :transaction_id, :string
    add_column :payments, :purchased_at, :datetime
  end
end
