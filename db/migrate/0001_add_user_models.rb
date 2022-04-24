class AddUserModels < ActiveRecord::Migration[7.0]
  class << self
    def up
      create_table :user_models do |t|
        t.column :name, :string, :null => true
        t.column :lastname, :string, :null => true
        t.column :email, :string, :null => true
        t.column :actions, :string, :null => true
        t.column :gender, :string, :null => true
        t.column :age, :integer, :null => true
        t.column :token, :integer, :null => true
      end
    end

    def down
      drop_table :user_models
    end
  end
end