Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1304354512970696', 'edb43665ccedf911823b1fd70e91683b',
  scope: 'public_profile, user_friends, taggable_friends', info_fields: 'id,name,link'
end
