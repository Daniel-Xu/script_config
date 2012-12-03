require 'rubygems'
require 'mechanize'

agent = Mechanize.new

page = agent.get('http://www.baidu.com')

=begin
page.links.each do |link|
  puts link.text
end
=end

#pp page

baidu_form = page.form('f')
baidu_form.wd = 'ruby mechanize'
page = agent.submit(baidu_form)
pp page








