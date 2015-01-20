class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :user, index: true
			t.string   :name
			t.datetime :due_date
			t.boolean  :complete, default: false

      t.timestamps
    end
  end
end
