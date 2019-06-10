class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images, id: :uuid, default: 'uuid_generate_v4()', force: true do |t|
      t.jsonb :file_data

      t.timestamps
    end
  end
end
