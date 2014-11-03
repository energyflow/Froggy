require 'gmail'
require 'nokogiri'

`wget -O temp.html "http://m.search.naver.com/search.naver?sm=mtb_hty.top&where=m_news&query=%EC%8A%88%ED%8D%BC%EC%8A%A4%ED%83%80k6&sort=1&pd=0&option_open=0"  --header="Accept-Language: en-US,en"`

file = File.open("temp.html","r")
page = Nokogiri::HTML(file)
file.close

article = page.xpath("//span[@class='tmbctw']").search('strong')

	article_edit = article[0]
	puts "#{article_edit}"


gmail = Gmail.connect("ddengbee@gmail.com","love0725")
puts gmail.logged_in?

gmail.deliver do
  to "ddengbee@gmail.com"
  subject  "this is a test mail" 
  html_part do
    content_type 'text/html; charset=UTF-8'
    body "#{article_edit}"
  end
 ## add_file "/path/to/some_image.jpg"

end
gmail.logout


=begin
0.upto(14) do |x|

        article_edit = article.text.split('...')[x]

        title = article_edit.split('시간전')[0]
        abstract = article_edit.split('시간전')[1]

        puts "#{x+1}. #{title}시간전"


end
=end
