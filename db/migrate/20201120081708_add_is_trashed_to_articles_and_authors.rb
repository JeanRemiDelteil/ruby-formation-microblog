class AddIsTrashedToArticlesAndAuthors < ActiveRecord::Migration[6.0]
  def change

    add_column :articles, :is_trashed, :boolean, default: false
    add_column :authors, :is_trashed, :boolean, default: false

  end
end
