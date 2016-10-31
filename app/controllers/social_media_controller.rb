class SocialMediaController < ApplicationController
  def facebook
    # Build out a User if we don't have one yet
    unless current_user
      user = User.create
      # Log in as this new user
      session[:user_id] = user.id.to_s
    end

    # Do they already have a facebook social medium?
    fb_social_medium = current_user.social_media.find {|sm| sm.fb_id != nil }
    # Go see if we can still act as them using their access token
    if fb_social_medium
      @access_token = fb_social_medium.acc
      # In case of a name change or whatever, keep our stuff up-to-date
      fb_social_medium.update(fb_params)
    else
      # Build out the facebook social medium
      response = Net::HTTP.get(URI.parse('https://graph.facebook.com/oauth/access_token?' +
        'client_id=' + ENV["FB_CLIENT_ID"] +
        '&redirect_uri=http://localhost:3000/social_media/facebook' +
        '&client_secret=' + ENV["FB_CLIENT_SECRET"] +
        "&code=#{params["code"]}"))
      @access_token = Rack::Utils.parse_nested_query(response)["access_token"]

      current_user.social_media.create({acc: @access_token}.merge(fb_params))
    end

    redirect_to home_path
  end

  # A little later we'll put this as private
  def fb_params
    unless @fb_params
      fb_info = JSON.parse(Net::HTTP.get(URI.parse('https://graph.facebook.com/v2.2/me?' +
        'fields=id,context,email,name,first_name,last_name,name_format,link,gender,locale,timezone,updated_time,age_range,currency' +
        '&access_token=' + @access_token)))

      context = fb_info["context"]

      @fb_params = {
        fb_id: fb_info["id"],
        first_name: fb_info["first_name"], last_name: fb_info["last_name"],
        name_format: fb_info["name_format"], full_name: fb_info["name_format"].gsub('{first}', fb_info["first_name"]).gsub('{last}', fb_info["last_name"]),
        website: fb_info["link"],
        email: fb_info["email"],

        gender: fb_info["gender"],
        locale: fb_info["locale"], # ISO 3166-1 alpha-2 standard country code
        timezone: fb_info["timezone"],
        age_range: fb_info["age_range"].inspect,
        currency: fb_info["currency"]["user_currency"],
        blurb: "#{context["mutual_friends"]["summary"]["total_count"]} friends, #{context["mutual_likes"]["summary"]["total_count"]} likes"
      }
    end
    @fb_params
  end

  def twitter
  end

  def soundcloud
  end

  def github
  end

  def linkedin
  end

  def google
  end

  def myspace
  end

  def bebo
  end

  def flicker
  end

  def pinterest
  end

  def instagram
  end

  def reddit
  end

  def snapchat
  end

  def mixcloud
  end

  def apple
  end
end
