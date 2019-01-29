class CreateSolutions < ActiveRecord::Migration[5.1]
  def change
    create_table :solutions do |t|
      t.string :title
      t.text :description
      t.belongs_to :problem, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
		add_index :solutions, [:problem_id, :created_at]
  end
end
