class ChangeColumnInChefs < ActiveRecord::Migration[5.1]
  def change
    rename_column :chefs, :name, :chefname
  end
end
