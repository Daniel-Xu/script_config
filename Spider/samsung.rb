#endcoding: utf-8
require 'hpricot'
require 'open-uri'
require 'httpclient'
require 'nokogiri'
require "iconv"

def page_info
  #@keyword="三星"
  #encode_keyword = URI.escape(@keyword.encode("gb2312"))
  #encode_site_name = URI.escape("淘宝".encode("gb2312"))
  
  pages = 1
  pages.times do |p|
  link = "http://s8.taobao.com/search?q=%C8%FD%D0%C7&commend=all&search_type=auction&user_action=initiative&f=D9_5_1&at_topsearch=1&sid=&sort=&spercent=0&st=1&pid=mm_18345116_2579614_10874899&unid="
  #link = "http://www.amazon.cn/s/ref=nb_sb_noss/478-6402524-0271912?__mk_zh_CN=%E4%BA%9A%E9%A9%AC%E9%80%8A%E7%BD%91%E7%AB%99&url=search-alias%3Daps&field-keywords=%E4%B8%89%E6%98%9F"
  #doc = Nokogiri::HTML(open(link))
  @page_list = HTTPClient.new(:agent_name => "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 2.0.50727)")
  doc=Hpricot(Iconv.conv("utf8", "gbk", @page_list.get_content(link)))

  puts doc 

  doc.search("div[@id=list-content]").search("h3").each do |x|
    begin
    lk = x.search("a")[0].to_s.gsub("\n","").gsub("\r","").gsub("\t","").gsub(/<a(.+?)href="/,"").gsub(/"(.+)/,"")#["href"]
    puts "###############################################"
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
  @client = HTTPClient.new(:agent_name => "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 2.0.50727)")
  doc=Hpricot(Iconv.conv("utf8","gbk",@client.get_content(url)))
  #doc = Nokogiri::HTML(open(url))
  puts doc
  #info=doc.search("div[@class=tb-detail-hd")
  #puts info
  #puts title=info.search("h3")[0].to_s.gsub(/<(\S*?)[^>]*>.*?|<.*? \/>/,"").gsub("&nbsp;","")
  #puts "title"
  #puts title = info.search("h3")[0]
    #puts time=Time.parse(info.search("div[@class=multicnt]").search("span[@class=pleft]").search("span[@class=blogsep]")[0].inner_html.to_s.gsub("(","").gsub(")",""))
    #tags=[]
    #tmp_tags=info.search("div[@class=multicnt]").search("span[@class=pleft]").search("a").each {|n| tags << n.to_s.gsub(/<(\S*?)[^>]*>.*?|<.*? \/>/,"")}
    #puts tags
   #puts content=info.search("div")[0].to_s.gsub("\t","").gsub("\n","").gsub("\r","").gsub(/<h3(.+?)h3>/,"").gsub(/<span class="blogsep"(.+?)span>/,"").gsub(/<span class="pleft"(.+?)span>/,"").gsub(/<span class="pright fc07 ztag"(.+?)span>/,"").gsub(/<div class="nbw-act tbar fc03 clearfix"(.+?)div>/,"").gsub(/<(\S*?)[^>]*>.*?|<.*? \/>/,"").gsub("&nbsp;","").gsub("评论这张","").gsub("转发至微博","").gsub("分享到：","").gsub(/阅读\((.+?)\)/,"").gsub(/评论\((.+?)\)/,"").gsub(/引用 \((.+?)\)/,"").gsub("|举报","").gsub("大中小订阅","")
   #puts view_count=info.search("div[@class=pright]").search("span")[0].search("span")[0].to_s.gsub(/<(\S*?)[^>]*>.*?|<.*? \/>/,"").gsub("(","").gsub(")","")
    #puts comment_count=info.to_s.match(/评论\((.+?)\)/).to_s.gsub(/评论/,"").gsub("(","").gsub(")","").gsub(/<(\S*?)[^>]*>.*?|<.*? \/>/,"")#.search("div[@class=pright]").search("span")[2].search("span")[0].to_s.gsub(/<(\S*?)[^>]*>.*?|<.*? \/>/,"").gsub("(","").gsub(")","")
    #info_tmp=doc.search("script").to_s.gsub("\r","").gsub("\t","").gsub("\n","").to_s.match(/ UD.host = \{(.+?)\}/)
    #puts author_name=info_tmp.to_s.gsub(/(.+?)nickName:'/,"").gsub(/'(.+)/,"")#url.to_s.gsub(/(.+?)\//,"").gsub(/\/(.+)/,"")# doc.search("div[@class=cnt ztag]").search("div[@class=uinfo ztag]").search("a")[1].to_s.gsub(/<(\S*?)[^>]*>.*?|<.*? \/>/,"")
    #puts author_id=info_tmp.to_s.gsub(/(.+?)userId:/,"").gsub(/,(.+)/,"")## doc.search("div[@class=cnt ztag]").search("div[@class=uinfo ztag]").search("a")[1].to_s.gsub(/<a(.+?)href="/,"").gsub(/"(.+)/,"").gsub("http://blog.163.com/","").gsub("/","")
    
  #puts "-"*200

  #puts bolg_id=doc.search("textarea").to_s.match(/id:'(.+?)'/).to_s.gsub(/id:'/,"").gsub(/'(.+)/,"") #http://api.blog.163.com/pjf1225/dwr/call/plaincall/BlogBeanNew.getComments.dwr?callCount=1&scriptSessionId=${scriptSessionId}187&c0-scriptName=BlogBeanNew&c0-methodName=getComments&c0-id=0&c0-param0=string:fks_085070081083087065085081081095093085088071092085094&c0-param1=number:25&c0-param2=number:0&batchId=0
 #puts comment=@client.post_content("http://api.blog.163.com/pjf1225/dwr/call/plaincall/BlogBeanNew.getComments.dwr",res)
end

page_info

