class CreateYoutubeChannels < ActiveRecord::Migration[5.2]
  def change
    create_table :youtube_channels do |t|
      t.string :title
      t.string :link

      t.timestamps
    end
  end
end
