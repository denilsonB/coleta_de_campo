class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.string :content
      t.references :formulary, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :visit, null: false, foreign_key: true
      t.datetime :answered_at
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :answers, :deleted_at
  end
end
