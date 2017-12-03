class AddNewFieldtoCertificates < ActiveRecord::Migration[5.0]
  def change
    add_column :certificates, :editable, :boolean, default: :true
    add_column :certificates, :published, :boolean, default: :true
    add_column :certificates, :amount, :decimal, precision: 5, scale: 2
    add_column :certificates, :role_id, :integer
    add_timestamps :certificates, null: true
    add_foreign_key :certificates, :roles
  end
end
