class CreateSocialMedia < ActiveRecord::Migration[5.0]
  def change
    create_table :social_media do |t|
      t.references :user, foreign_key: true

      t.string :fb_id # Facebook
      t.string :ig_id # Instagram
      t.string :tw_id # Twitter
      t.string :pn_id # Pinterest
      t.string :li_id # LinkedIn

      t.string :acc # Access Token
      t.string :secret
      t.string :context # Permissions that are available
      t.string :email
      t.string :name # screen name in FB and twitter
      t.string :full_name
      t.string :first_name
      t.string :last_name
      t.string :maiden_name # Only LinkedIn
      t.string :name_format
      t.string :link
      t.string :gender
      t.string :locale # ISO 3166-1 alpha-2 standard country code
      t.string :timezone
      t.string :lang
      t.string :age_range # Only Facebook
      t.string :currency
      t.string :blurb # "description" in twitter, "headline" in linkedIn
      t.text :bio
      t.string :industry # Only LinkedIn
      t.string :website

      t.timestamps
    end

    add_foreign_key :users, :social_media, column: :default_social_medium_id
  end
end
