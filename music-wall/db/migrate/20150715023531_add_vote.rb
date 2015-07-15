class AddVote < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.timestamps
    end

    add_reference :votes, :song
    add_reference :votes, :user 
  end
end
