Rails.application.routes.draw do
  get 'clipchamp-videos', to: 'clipchamp#videos', as: :clipchamp_videos
  get 'clipchamp-videos-show', to: 'clipchamp#video_show', as: :video_show
  get 'clipchamp-photos', to: 'clipchamp#photos', as: :clipchamp_photos
  get 'clipchamp-audios', to: 'clipchamp#audios', as: :clipchamp_audios
  get 'home-image', to: 'home#image', as: :home_image
  get 'flexclip', to: 'flexclip#index', as: :flexclip
  get 'flexclip-download', to: 'flexclip#download', as: :flexclip_download
  get 'public-audio', to: 'public_audio#index', as: :public_audio
  get 'public-photos', to: 'public_photos#index', as: :public_photos
  get 'unsplash', to: 'public_photos#unsplash', as: :unsplash
  get 'invideo', to: 'invideo#index', as: :invideo
  get 'invideo-download', to: 'invideo#download', as: :invideo_download
  get 'collected-blogs', to: 'collected_blogs#index', as: :collected_blogs
  get 'youtube-channels', to: 'collected_blogs#youtube_channel', as: :youtube_channel
  get 'useful-links', to: 'collected_blogs#useful_links', as: :useful_links
  get 'lumen', to: 'lumen#index', as: :lumen
  get 'promo', to: 'promo#index', as: :promo
  get 'promo-photos', to: 'promo#photos', as: :promo_photos
  get 'powton', to: 'powton#index', as: :powton
  get 'powton-download', to: 'powton#download', as: :powton_download
  get 'my-visme', to: 'my_visme#index', as: :my_visme
  get 'my-visme-download', to: 'my_visme#download', as: :my_visme_download
  get 'home/test'
  get 'unblock-site', to: 'unblock_site#index', as: :unblock_site
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  get 'temporary-phone-number', to: 'temporary_phone_number#index', as: :temporary_phone_number
  get 'temporary-phone-number/inbox', to: 'temporary_phone_number#inbox', as: :temporary_phone_number_inbox
  get 'fake-address-generator', to: 'fake_address_generator#index', as: :fake_address_generator
  get 'youtube-tag-extractor', to: 'youtube_tag_extractor#index', as: :youtube_tag_extractor
  get 'apk_download/index'
  get 'ubersuggest', to: 'ubersuggest#index', as: :ubersuggest
  get 'youtube_downloader', to: 'youtube_downloader#index', as: :youtube_downloader
  get 'tempmail', to: 'tempmail#index', as: :tempmail
  get 'change-mail', to: 'tempmail#change_mail', as: :change_mail
  get 'image/new'
  post 'image/create', as: :image
  get 'storyblocks', to: 'storyblocks#index', as: :storyblocks
  get 'storyblocks_photos', to: 'storyblocks#photos', as: :storyblocks_photos
  get 'jumpstory', to: 'jumpstory#index', as: :jumpstory
  get 'jumpstory-photos', to: 'jumpstory#photos', as: :jumpstory_photos
  get 'keyword-research', to: 'keyword_research#index', as: :keyword_research
  get 'shutterstock-videos', to: 'shutterstock_videos#index', as: :shutterstock_videos
  get 'shutterstock-video-details', to: 'shutterstock_videos#details', as: :shutterstock_videos_details
  get 'shutterstock-photos', to: 'shutterstock_photos#index', as: :shutterstock_photos
  get 'shutterstock_photo_details', to: 'shutterstock_photos#details', as: :shutterstock_photos_details
  get 'wevideo', to: 'wevideo#index', as: 'wevideo'
  get 'biteable', to: 'biteable#index', as: 'biteable'
  get 'biteable-photos', to: 'biteable#photos', as: 'biteable_photos'
  get 'vidnami', to: 'vidnami#index', as: 'vidnami'
  get 'download', to: 'vidnami#download', as: 'download'
  get 'vidnami-token', to: 'vidnami#vidnami_token'
  get 'home/index'
  get 'home/download'
  get 'home/confirm', as: 'confirm'
  root 'home#index'
  get 'home/links', as: 'links'
end
