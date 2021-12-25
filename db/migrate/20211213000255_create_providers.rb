class CreateProviders < ActiveRecord::Migration[6.1]
  def change
    create_table :providers do |t|
      t.string :trading_name
      t.string :company_name
      t.string :cnpj
      t.string :address
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
