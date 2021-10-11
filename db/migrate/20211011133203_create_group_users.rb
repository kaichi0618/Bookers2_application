class CreateGroupUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :group_users do |t|
      t.references :group, foreign: true
      t.references :user, foreign: true
      t.timestamps
    end
  end
end
