class CreateCriteria < ActiveRecord::Migration[5.1]
  def change
    create_table :criteria do |t|
      t.string :title
      t.text :alternatives
      t.belongs_to :problem, foreign_key: true
      t.index([:criteria_id, :user_id], name: 'dissenters')
      t.timestamps
    end

    create_join_table :criteria, :users do |t|
      t.index [:criteria_id, :user_id]
      t.index [:user_id, :criteria_id]
    end
  end
end