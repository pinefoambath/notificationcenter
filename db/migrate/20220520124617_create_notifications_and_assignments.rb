class CreateNotificationsAndAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :description
      t.datetime :date
      t.timestamps
    end

    create_table :assignments do |t|
      t.belongs_to :notification
      t.belongs_to :user
      t.boolean :read, default: false
      t.timestamps
    end
  end
end
