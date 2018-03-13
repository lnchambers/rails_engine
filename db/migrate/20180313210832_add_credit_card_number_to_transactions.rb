class AddCreditCardNumberToTransactions < ActiveRecord::Migration[5.1]
  def change
    remove_column :transactions, :credit_card_number, :integer

    add_column :transactions, :credit_card_number, :decimal, :precision => 15
  end
end
