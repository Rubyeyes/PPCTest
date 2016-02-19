class CreateIdeaCategories < ActiveRecord::Migration
  def change
    create_table :idea_categories do |t|
      t.string :category

      t.timestamps null: false
    end
  end
end
