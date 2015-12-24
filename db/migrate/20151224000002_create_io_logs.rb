# -*- coding: utf-8 -*-
class CreateIoLogs < ActiveRecord::Migration

  def change
    create_table :io_logs do |t|
      t.string :ip_address
      t.string :mac_address
      t.string :io #IN or OUT
      t.timestamps
    end
    add_index :io_logs, :ip_address
    add_index :io_logs, :mac_address
  end
end
