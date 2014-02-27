class CreateJobApplications < ActiveRecord::Migration
  def change
    create_table :job_applications do |t|
      t.references :user
      t.string :job_title
      t.string :company
      t.string :url
      t.string :status, :default => 'PENDING'

      t.datetime :application_date
      t.datetime :reply_date
    end

    add_index :job_applications, :user_id
    add_index :job_applications, :application_date
    add_index :job_applications, :status
  end
end
