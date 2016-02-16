class CreatePatents < ActiveRecord::Migration
  def change
    create_table :patents do |t|
      t.string :name
      t.string :type
      t.string :docket_number
      t.string :certificate
      t.string :status
      t.string :patent_number
      t.datetime :issue_date
      t.datetime :filling_date

      t.timestamps null: false
    end
  end
end
