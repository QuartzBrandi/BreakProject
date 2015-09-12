module HomeHelper
  def url(game)
    if game.img_logo_url.empty?
      url = "no_logo.jpg"
    else
      url = "http://media.steampowered.com/steamcommunity/public/images/apps/" +
            game.appid + "/" + game.img_logo_url + ".jpg"
    end

    return url
  end
end
