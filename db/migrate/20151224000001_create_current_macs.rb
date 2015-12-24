# -*- coding: utf-8 -*-
class CreateCurrentMacs < ActiveRecord::Migration

  def change
    create_table :current_macs do |t|
      t.string :mac_address
      t.string :ip_address
      t.string :name
      t.timestamps
    end
    add_index :current_macs, :mac_address
    add_index :current_macs, :ip_address
  end
end
