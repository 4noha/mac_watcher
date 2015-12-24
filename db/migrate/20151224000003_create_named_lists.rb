# -*- coding: utf-8 -*-
class CreateNamedLists < ActiveRecord::Migration

  def change
    create_table :named_lists do |t|
      t.string :ip_address
      t.string :mac_address
      t.string :name
      t.timestamps
    end
    add_index :named_lists, :mac_address
    add_index :named_lists, :ip_address
  end
end
