class CreateImageTransformations < ActiveRecord::Migration[5.2]
  def change
    create_table :image_transformations, id: :uuid, default: 'uuid_generate_v4()', force: true do |t|
      t.references :image, type: :uuid, foreign_key: true, index: true
      t.jsonb :file_data
      t.jsonb :specs

      t.timestamps
    end
  end
end
