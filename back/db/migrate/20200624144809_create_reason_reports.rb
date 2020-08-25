class CreateReasonReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reason_reports do |t|
      t.text :reason

      t.timestamps
    end
  end
end
