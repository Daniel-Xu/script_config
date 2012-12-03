#endcoding: utf-8
require 'hpricot'
require 'open-uri'
require 'httpclient'
require 'nokogiri'
require "iconv"

def page_info
  pages = 10
  pages.times do |p|
  link = "http://www.tuan800.com/search?url_city=beijing&query=%E5%B0%8F%E5%90%83"
  doc = Nokogiri::HTML(open(link))

  doc.search("div[@class=deal]").each do |x|
    begin
    lk = x.search("h3").search("a")[0].to_s.gsub("\n","").gsub("\r","").gsub("\t","").gsub(/<a(.+?)href="/,"").gsub(/"(.+)/,"")#["href"]
    puts "####################################################################################################"
    puts "网址:"
    puts lk
    #next if title.blank?
    #next if !Site.set_base_links(lk)
    get_page(lk) 
    rescue Exception => e
    puts e.message
    end
  end
  end
end

def get_page(url)
  #@client = HTTPClient.new(:agent_name => "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 2.0.50727)")
  #doc=Hpricot(Iconv.conv("utf8","zh-CN",@client.get_content(url)))
  doc = Nokogiri::HTML(open(url))

  info = doc.search("div[@id=dealinfo]")
  puts "标题为:"
  puts title = doc.search("head").search("title")[0].inner_html
  puts "价格情况:"
  puts price = info.search("h3").to_s.gsub("\t","").gsub("\n","").gsub("\r","").gsub(/<\S*?>/, "")
  puts "购买情况:"
  puts price = info.search("h2").search("span").inner_html.to_s
  puts "消费提醒"    
  puts notice = doc.search("div[@id=xftx]")[0].to_s.gsub("\t","").gsub("\n","").gsub("\r","").gsub(" ", "").gsub(/<\S*?[^>]*>|<.*? \/>/, "").gsub("&gt;", "")

  puts "商家信息"
  s_info = doc.search("div[class='bottom cf']")
  r_info = s_info.search("div[class=right]")
  puts seller = s_info.search("div[class=right]").search("a")[0].inner_html.to_s.gsub(/\(|\)/, "").gsub(/<\S*?[^>]*>|<.*? \/>/, "")
  puts "商家信誉"
  reputes = []
  puts repute = r_info.search("p").each{|r| reputes << r.to_s.gsub("\t","").gsub("\n","").gsub("\r","").gsub(" ", "").gsub(/<\S*?[^>]*>|<.*? \/>/, "")}
  puts reputes

  puts "用户评论"
  comment = []
  comments = doc.search("div[@class=clistone]").each {|p| comment << p.search("p").to_s.gsub("\t","").gsub("\n","").gsub("\r","").gsub(" ", "").gsub(/<\S*?[^>]*>|<.*? \/>/, "").gsub("举报", "")}
  puts comment 

end

page_info
