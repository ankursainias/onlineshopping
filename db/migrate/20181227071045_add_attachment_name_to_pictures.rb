class AddAttachmentNameToPictures < ActiveRecord::Migration[5.2]
  def self.up
    change_table :pictures do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :pictures, :image
  end
end
