def self.get_facebook_count(url)
  https://graph.facebook.com/#{url}
  data = get_access_to_api("https://graph.facebook.com/",url)
  return data["shares"]
end                                                                                            

def self.get_twitter_count(url)
  data = get_access_to_api("https://cdn.api.twitter.com/1/urls/count.json?url=",url)
  return data["count"]
end

def self.get_pocket_count(url)
  #apiから取得したボタンをhtml-parseしてカウント部を取得する
  api_url = "http://widgets.getpocket.com/v1/button?v=1&count=horizontal&url="
  data = URI("#{api_url}#{url}").read
  doc = Nokogiri::HTML(data, nil, 'utf-8')
  count = doc.css("#cnt").first.content
  return count.to_i
end

def self.get_hatebu_count(url)
  data = get_access_to_api("http://api.b.st-hatena.com/entry.count?url=",url)
  return data
end

def self.get_linkedin_count(url)
  data = get_access_to_api("https://www.linkedin.com/countserv/count/share?format=json&url=",url)
  return data["count"]
end

def self.get_google_count(url)
  api_url = "https://plusone.google.com/_/+1/fastbutton?url="
  data = URI("#{api_url}#{url}").read
  doc = Nokogiri::HTML(data, nil, 'utf-8')
  count = doc.css("#aggregateCount").children.text
  return count.to_i
end

def self.get_access_to_api(api_url, target_url)
  data = URI("#{api_url}#{target_url}").read
  json_data = ActiveSupport::JSON.decode(data)
  return json_data
end