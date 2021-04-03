class AddCommentsTable < ActiveRecord::Migration[6.0]
  def change
      create_table :comments do |t|
      	   t.text :comment
	   	   t.integer  :article_id   
    end
  end
end
