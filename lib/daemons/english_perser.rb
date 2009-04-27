#!/usr/bin/env ruby

#You might want to change this
ENV["RAILS_ENV"] ||= "production"

require File.dirname(__FILE__) + "/../../config/environment"
require 'feed_tools'
require 'hpricot'
require 'open-uri'
require 'iconv'  

$running = true;
Signal.trap("TERM") do 
  $running = false
end

  
  def read_page page_source_name, item_link


     if page_source_name == 'www.washingtonpost.com' 
      doc =Hpricot(open(item_link))
       a= read_wpost doc
     end


          if page_source_name == 'www.ft.com' 
             f = open(item_link)
              f.rewind
              doc = Hpricot(Iconv.conv('utf-8', f.charset, f.readlines.join("\n")))
             a= read_ft doc
          end

          if page_source_name == 'euobserver.com' 
            doc =Hpricot(open(item_link))
             a= read_euobserver doc
           end
           
          if page_source_name == 'www.huffingtonpost.com' 
           doc =Hpricot(open(item_link))
            a= read_huffington doc
          end

          if page_source_name == 'www.politico.com' 
           doc =Hpricot(open(item_link))
            a= read_politico doc
          end

             if page_source_name == 'www.nytimes.com' 
              doc =Hpricot(open(item_link))
               a= read_nytimes doc
             end

            if page_source_name == 'www.economist.com' 
               doc =Hpricot(open(item_link))
                a= read_economist doc
            end

              if page_source_name == 'www.latimes.com' 
                doc =Hpricot(open(item_link))
                 a= read_latimes doc
              end

               if page_source_name == 'online.wsj.com' 
                 doc =Hpricot(open(item_link))
                  a= read_wsj doc
               end


                if page_source_name == 'www.chicagotribune.com' 
                  doc =Hpricot(open(item_link))
                   a= read_ctribune doc
                end

                 if page_source_name == 'www.slate.com' 
                   doc =Hpricot(open(item_link))
                    a= read_slate doc
                 end

            if page_source_name == 'www.salon.com' 
                      doc =Hpricot(open(item_link))
                       a= read_salon doc
            end

                 if page_source_name == 'www.newsweek.com' 
                        doc =Hpricot(open(item_link))
                         a= read_newsweek doc
                 end

                 if page_source_name == 'www.time.com' 
                        doc =Hpricot(open(item_link))
                         a= read_time doc
                 end

                 if page_source_name == 'www.nationalreview.com' 
                        doc =Hpricot(open(item_link))
                         a= read_nreview doc
                 end

                 if page_source_name == 'www.tnr.com' 
                   #does not work yet!
                        doc =Hpricot(open(item_link))
                         a= read_tnr doc
                 end

                 if page_source_name == 'www.newyorker.com' 
                        doc =Hpricot(open(item_link))
                         a= read_newyorker doc
                 end

                 if page_source_name == 'harpers.org' 
                        doc =Hpricot(open(item_link))
                         a= read_harpers doc
                 end

                 if page_source_name == 'www.businessweek.com' 
                        doc =Hpricot(open(item_link))
                         a= read_businessweek doc
                 end

                 if page_source_name == 'www.redherring.com' 
                        doc =Hpricot(open(item_link))
                         a= read_redherring doc
                 end

                 if page_source_name == 'www.guardian.co.uk' 
                        doc =Hpricot(open(item_link))
                         a= read_guardian doc
                 end

                 if page_source_name == 'www.independent.co.uk' 
                        doc =Hpricot(open(item_link))
                         a= read_independent doc
                 end



                 if page_source_name == 'timesofindia.indiatimes.com' 
                        doc =Hpricot(open(item_link))
                         a= read_indiatimes doc
                 end

                 if page_source_name == 'economictimes.indiatimes.com' 
                        doc =Hpricot(open(item_link))
                         a= read_economictimes doc
                 end



                 if page_source_name == 'www.theaustralian.news.com.au' 
                        doc =Hpricot(open(item_link))
                         a= read_australian doc
                 end

                 if page_source_name == 'www.theage.com.au' 
                        doc =Hpricot(open(item_link))
                         a= read_theage doc
                 end

                 if page_source_name == 'www.smh.com.au' 
                        doc =Hpricot(open(item_link))
                         a= read_sidney doc
                 end



                 if page_source_name == 'www.sptimes.ru' 
                        doc =Hpricot(open(item_link))
                         a= read_sptimes doc
                 end

                 if page_source_name == 'www.moscowtimes.ru' 
                   item_link = item_link + '&print=Y'
                        doc =Hpricot(open(item_link))
                         a= read_moscowtimes doc
                 end

                 if page_source_name == 'www.haaretz.com' 
                   item_link = item_link.sub('spages/', 'objects/pages/PrintArticleEn.jhtml?itemNo=')
                   item_link = item_link.sub('.html','')
                         doc =Hpricot(open(item_link))
                          a= read_haaretz doc
                 end

                  if page_source_name == 'www.jpost.com' 
                         doc =Hpricot(open(item_link))
                          a= read_jpost doc
                  end



       if page_source_name == 'www.spiegel.de' 
           f = open(item_link)
           f.rewind
           doc = Hpricot(Iconv.conv('utf-8', f.charset, f.readlines.join("\n")))
           a= read_spiegel doc
       end
       
       if page_source_name == 'www.reuters.com' 
                       doc =Hpricot(open(item_link))
                        a= read_reuters doc
        end

     
      if page_source_name == 'www.cfr.org' 
        doc =Hpricot(open(item_link))
         a= read_cfr doc
       end


       return a
   end

   def read_wpost doc

       author = (doc/"#byline").inner_text


       unless author == ''
         if author.match('By')
           author = author.sub(' and ', '+') 
           author = author.sub(' in ', '+')
           author = author.gsub('By ', '+')
           author = author.gsub(',', '+')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', "’")
         else
           author= ''
         end
       end

       intro = (doc/"#article/div/h2").inner_text

       text = (doc/"#article_body/p").inner_text
       text_2 = (doc/"#body_after_content_column/p").inner_text  

       text = intro + ' ' + text + ' ' + text_2

       text = text.sub('Jan.', '')
       text = text.sub("Feb.", '')
       text = text.sub('Mar.', '')
       text = text.sub('Apr.', '')
       text = text.sub("May.", '')
       text = text.sub('Jun.', '')
       text = text.sub('Jul.', '')
       text = text.sub("Aug.", '')
       text = text.sub('Sep.', '')
       text = text.sub('Oct.', '')
       text = text.sub("Nov.", '')
       text = text.sub('Dec.', '')
       text = text.sub('JAN', '')
       text = text.sub("FEB", '')
       text = text.sub('MAR', '')
       text = text.sub('APR', '')
       text = text.sub("MAY", '')
       text = text.sub('JUN', '')
       text = text.sub('JUL', '')
       text = text.sub("AUG", '')
       text = text.sub('SEP', '')
       text = text.sub('OCT', '')
       text = text.sub("NOV", '')
       text = text.sub('DEC', '')







       return author, text
   end

  
   def read_euobserver doc

       author = (doc/"p.author/a").inner_text
       author = (doc/"p.author").inner_text if author == ''

       text = (doc/"div.content/p").inner_text
       text= text.gsub('Permalink','')
       text= text.sub(author, '')
       text= text.sub('CETEUOBSERVER', '')
       text= text.sub('BRUSSELS', '')
       text= text.sub('Today', '')  
       text= text.sub('COMMENT', '') 

       unless author == ''
           author = author.sub(' and ', '+') 
           author = author.gsub(' AND ', '+')
           author = author.gsub('By ', '+')
           author = author.gsub(',', '+')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', "’")


           author = author.downcase
           author_array = author.scan(/\w+/)
           author = ''
          author_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             author += word + ' '
           end

       end

       return author, text
   end

   def read_cfr doc

       author = (doc/"div.name/a").inner_text
       author = (doc/"div.float_left/h2/a").inner_text if author == ''


      unless author == ''
          author = author.sub('and ', '+') 
          author = author.gsub('and', '+')
          author = author.gsub('By ', '+')
          author = author.gsub(',', '+')
          author = author.gsub("’", '3')
          author = author.gsub('-', '2')
          author = author.gsub('.', '1')
          author = author.gsub(' ', '0')

          author = author.gsub('+', ' ')
          author_array = author.scan(/\w+/)
          author = author_array[0]
          author = author.gsub('0', ' ')
          author = author.gsub('1', '.')
          author = author.gsub('2', '-')
          author = author.gsub('3', "’")


          author = author.downcase
          author_array = author.scan(/\w+/)
          author = ''
         author_array.each do |word|
            word_a = word.first.upcase
            word_b = word.sub(word.first, '')

            word = word_a + word_b  
            author += word + ' '
          end

      end

       text = (doc/"div.cms").inner_text
       text = (doc/"#mainContent/ul").inner_text if text == ''
       text= text.gsub('Permalink','')

       return author, text
   end

   def read_huffington doc

       author = (doc/"div.about_reporter_name/a").inner_text
       author = (doc/"div.float_left/h2/a").inner_text if author == ''


      unless author == ''
          author = author.sub('and ', '+') 
          author = author.gsub('and', '+')
          author = author.gsub('By ', '+')
          author = author.gsub(',', '+')
          author = author.gsub("’", '3')
          author = author.gsub('-', '2')
          author = author.gsub('.', '1')
          author = author.gsub(' ', '0')

          author = author.gsub('+', ' ')
          author_array = author.scan(/\w+/)
          author = author_array[0]
          author = author.gsub('0', ' ')
          author = author.gsub('1', '.')
          author = author.gsub('2', '-')
          author = author.gsub('3', "’")


          author = author.downcase
          author_array = author.scan(/\w+/)
          author = ''
         author_array.each do |word|
            word_a = word.first.upcase
            word_b = word.sub(word.first, '')

            word = word_a + word_b  
            author += word + ' '
          end

      end

       text = (doc/"div.entry_body_text").inner_text
       text = (doc/"#mainContent/ul").inner_text if text == ''
       text= text.gsub('Permalink','')

       return author, text
   end

   def read_politico doc

       author = (doc/"a.bylineLink").inner_text

      unless author == ''
          author = author.sub('and ', '+') 
          author = author.gsub('and', '+')
          author = author.gsub('By ', '+')
          author = author.gsub(',', '+')
          author = author.gsub("’", '3')
          author = author.gsub('-', '2')
          author = author.gsub('.', '1')
          author = author.gsub(' ', '0')

          author = author.gsub('+', ' ')
          author_array = author.scan(/\w+/)
          author = author_array[0]
          author = author.gsub('0', ' ')
          author = author.gsub('1', '.')
          author = author.gsub('2', '-')
          author = author.gsub('3', "’")


          author = author.downcase
          author_array = author.scan(/\w+/)
          author = ''
         author_array.each do |word|
            word_a = word.first.upcase
            word_b = word.sub(word.first, '')

            word = word_a + word_b  
            author += word + ' '
          end

      end

       text = (doc/"#storyText").inner_text
       text = (doc/"#mainContent/ul").inner_text if text == ''
       text= text.gsub('Permalink','')

       return author, text
   end

   def read_reuters doc

       author = (doc/"#resizeableText/p[1]").inner_text


       unless author == ''
         if author.match('By')
           author = author.sub(' and ', '+') 
           author = author.sub(' in ', '+')
           author = author.gsub('By ', '+')
           author = author.gsub(',', '+')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', "’")
         else
           author= ''
         end
       end


       text = (doc/"#resizeableText/p").inner_text
       trash = 'By ' + author

       text = text.sub(trash,'')
       text = text.sub('LONDON (Reuters)','')
       text = text.sub('NEW YORK (Reuters)','')
       text = text.sub('LOS ANGELES (Reuters)','')
       text = text.sub('(Reuters)','')
       text = text.sub('Quote, Profile, Research, Stock Buzz','')

       return author, text
   end

   def read_nytimes doc

     author = (doc/"div.byline/a[0]").inner_text
     author = (doc/"div.byline/a").inner_text if author == ''
     author = (doc/"div.byline").inner_text if author == ''
     author = (doc/"address.byline/a").inner_text if author == ''
     author = '' if author.match('ASSOCIATED PRESS')

       unless author == ''
           author = author.gsub(' and ', '+') 

           author = author.gsub('By ', '+')
           author = author.gsub(',', '+')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', "’")


           author = author.downcase
           author_array = author.scan(/\w+/)
           author = ''
          author_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             author += word + ' '
           end

       end


       document = nil

       document = (doc/"div.entry-content/p") 
       document = (doc/"#articleBody/nyt_text/p") if document.size < 1 #if document == nil or document == '' 
       text = document.inner_text

     #  text = intro + ' ' + text
      author = '' if author == 'Reuters '
       return author, text
   end

   def read_ft doc
       #roof_title = (doc/"h1.dach").inner_text
       #title = (doc/"h2.artikelhead").inner_html
       #title = roof_title + ': ' + title if roof_title != '' 
       author = (doc/"div.ft-story-header/p[1]").inner_text
     #  /html/body/div[4]/div/div/div/div/div[2]/div/div/div/p

       unless author == nil
           author = author.sub(' and ', '+') 
           author = author.sub(' in ', '+')
           author = author.gsub('By ', '+')
           author = author.gsub(',', '+')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', "’")


       end

     #  intro = (doc/"h3.anlauf").inner_text
   #//*[@id="floating-target"]
       doc = (doc/"div.ft-story-body/p")
       text = doc.inner_text

     #  text = intro + ' ' + text
       return author, text
   end

   def read_economist doc

       author = ''

       super_headline = (doc/"p.fly-title").inner_text 
       title =  (doc/"div.blog-entry/h3").inner_text
       title = (doc/"div.col-left/h1").inner_text if title == ''
     title = super_headline + ': ' + title if super_headline != ''  
       intro = (doc/"div.col-left/h2[1]").inner_text
      # trash = (doc/"div.col-left/p[2]").inner_text
       trash_2 = (doc/"p.info").inner_text
       trash_3 = (doc/"dl.posted-by").inner_text
       trash_4 = (doc/"p.timestamp").inner_text

       text = (doc/"div.blog-entry").inner_text
       text = (doc/"div.col-left/p").inner_text if text == ''

     # text = text.sub(trash, '') 
      text = text.sub(trash_2, '')
       text = text.sub(trash_3, '')
       text = text.sub(trash_4, '')

       text = text.sub(title, '')
       text = text.sub('Categories:', '')



      text = text.sub(super_headline, '')
      text = intro + '. ' + text if intro != ''
       return author, text, title
   end
  
   def read_latimes doc

       author = (doc/"div.storybyline").inner_text
       #author = (doc/"address.byline/a").inner_text if author == ''

       unless author == ''
           author = author.sub(' and ', '+') 
           author = author.gsub('By ', '+')
           author = author.gsub(',', '+')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', "’")


           author = author.downcase
           author_array = author.scan(/\w+/)
           author = ''
           author_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             author += word + ' '
           end
            author = '' if author.match('Associated Press')
            author = '' if author.match('Staff And Wire')
            
       end



      trash =  (doc/"div.storybody[1]").inner_text
       (doc/"div.content").remove
       (doc/"#inlinegoogleads").remove
       text = (doc/"div.storybody").inner_text
       #document = (doc/"div.storybody[1]")
      #document = (doc/"#articleBody/nyt_text/p") if document.size < 1 #if document == nil or document == '' 
       text = text.sub(trash,'')
       intro = (doc/"div.storysubhead").inner_text 
       text = intro + ' ' + text
       return author, text
   end

   def read_wsj doc

       author = (doc/"li.byline/h3").inner_text
       author = (doc/"h3.byline").inner_text if author == ''
       #author = (doc/"address.byline/a").inner_text if author == ''

       unless author == ''
           author = author.sub(' and ', '+') 

           author = author.gsub('By ', '+')
           author = author.gsub(',', '+')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', "’")


           author = author.downcase
           author_array = author.scan(/\w+/)
           author = ''
          author_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             author += word + ' '
           end

       end



      #trash =  (doc/"div.storybody[1]").inner_text
     #  (doc/"div.content").remove
      # (doc/"#inlinegoogleads").remove
       text = (doc/"div.articlePage").inner_text
      text = (doc/"div.article").inner_text if text == ''
       #document = (doc/"div.storybody[1]")
      #document = (doc/"#articleBody/nyt_text/p") if document.size < 1 #if document == nil or document == '' 
     #  text = text.sub(trash,'')
      # intro = (doc/"div.storysubhead").inner_text 
     #  text = intro + ' ' + text
       return author, text
   end

   def read_ctribune doc

       author = (doc/"span.story-byline").inner_text
       author = (doc/"span.byline").inner_text if author == ''

      # author = (doc/"h3.byline").inner_text if author == ''
       #author = (doc/"address.byline/a").inner_text if author == ''

       unless author == '' 
           author = author.gsub(' and ', '+')
           author = author.gsub('By ', '+')
           author = author.gsub(',', '+')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', "’")


           author = author.downcase
           author_array = author.scan(/\w+/)
           author = ''
          author_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             author += word + ' '
           end
       author = '' if author.match('Associated Press')
       end



      #trash =  (doc/"div.storybody[1]").inner_text
     #  (doc/"div.content").remove
      # (doc/"#inlinegoogleads").remove
       text = (doc/"#story-body").inner_text
      text = (doc/"div.article").inner_text if text == ''
       #document = (doc/"div.storybody[1]")
      #document = (doc/"#articleBody/nyt_text/p") if document.size < 1 #if document == nil or document == '' 
     #  text = text.sub(trash,'')
      # intro = (doc/"div.storysubhead").inner_text 
     #  text = intro + ' ' + text
       return author, text
   end

   def read_slate doc

       author = (doc/"span.byline").inner_text

      # author = (doc/"h3.byline").inner_text if author == ''
       #author = (doc/"address.byline/a").inner_text if author == ''

       unless author == ''
           author = author.sub(' and ', '+') 
           author = author.gsub('By ', '+')
           author = author.gsub(',', '+')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', "’")


           author = author.downcase
           author_array = author.scan(/\w+/)
           author = ''
          author_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             author += word + ' '
           end
       author = '' if author.match('Associated Press')
       end



      #trash =  (doc/"div.storybody[1]").inner_text
     #  (doc/"div.content").remove
      # (doc/"#inlinegoogleads").remove
       text = (doc/"#article_body/p").inner_text
     # text = (doc/"div.article").inner_text if text == ''
       #document = (doc/"div.storybody[1]")
      #document = (doc/"#articleBody/nyt_text/p") if document.size < 1 #if document == nil or document == '' 
     #  text = text.sub(trash,'')
       #intro = (doc/"div.h1_subhead").inner_text 
       #text = intro + ' ' + text
       return author, text
   end

   def read_salon doc

       author = (doc/"#byline").inner_text

       author = (doc/"div.byline").inner_text if author == ''
       #author = (doc/"address.byline/a").inner_text if author == ''

       unless author == ''
           author = author.gsub(' and ', '+') 
           author = author.gsub('By ', '+')
           author = author.gsub(',', '+')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', "’")


           author = author.downcase
           author_array = author.scan(/\w+/)
           author = ''
          author_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             author += word + ' '
           end
       author = '' if author.match('Associated Press')
       end



      #trash =  (doc/"div.storybody[1]").inner_text
     #  (doc/"div.content").remove
      # (doc/"#inlinegoogleads").remove
     text = (doc/"#abody/p").inner_text
      text = (doc/"div.pbody").inner_text if text == ''
       #document = (doc/"div.storybody[1]")
      #document = (doc/"#articleBody/nyt_text/p") if document.size < 1 #if document == nil or document == '' 
     #  text = text.sub(trash,'')
     datespace= (doc/"#abody/p").inner_text
     date = datespace.first(15)
     text = text.sub(date,'')
       intro = (doc/"#deck").inner_text 
       # intro = (doc/"div.pbody/p").inner_text if intro == ''
      text = intro + ' ' + text

       return author, text
   end

   def read_newsweek doc

       author = (doc/"div.authorInfo/a").inner_text

       author = (doc/"h2.authorname").inner_text if author == ''
       #author = (doc/"address.byline/a").inner_text if author == ''

       unless author == ''
           author = author.sub(' and ', '+') 

           author = author.gsub('By ', '+')
           author = author.gsub(',', '+')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', "’")


           author = author.downcase
           author_array = author.scan(/\w+/)
           author = ''
          author_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             author += word + ' '
           end
       author = '' if author.match('Associated Press')
       end



      #trash =  (doc/"div.storybody[1]").inner_text
     #  (doc/"div.content").remove
      # (doc/"#inlinegoogleads").remove
     text = (doc/"div.story/p").inner_text
     # text = (doc/"div.article").inner_text if text == ''
       #document = (doc/"div.storybody[1]")
      #document = (doc/"#articleBody/nyt_text/p") if document.size < 1 #if document == nil or document == '' 
     #  text = text.sub(trash,'')

      intro = (doc/"#deck.deck").inner_text 
    text = intro + ' ' + text

       return author, text
   end

   def read_time doc

       author = (doc/"span.name/a").inner_text

       #author = (doc/"h2.authorname").inner_text if author == ''
       #author = (doc/"address.byline/a").inner_text if author == ''

       unless author == ''
           author = author.gsub(' and ', '+') 
           author = author.gsub('By ', '+')
           author = author.gsub(',', '+')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author_array[1] if author_array[0] == 'AP'
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', "’")


           author = author.downcase
           author_array = author.scan(/\w+/)
           author = ''
          author_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             author += word + ' '
           end
       author = '' if author.match('Associated Press')
       end



      #trash =  (doc/"div.storybody[1]").inner_text
     #  (doc/"div.content").remove
      # (doc/"#inlinegoogleads").remove
     text = (doc/"div.artTxt/p").inner_text
     # text = (doc/"div.article").inner_text if text == ''
       #document = (doc/"div.storybody[1]")
      #document = (doc/"#articleBody/nyt_text/p") if document.size < 1 #if document == nil or document == '' 
     #  text = text.sub(trash,'')

     # intro = (doc/"#deck.deck").inner_text 
    #text = intro + ' ' + text

       return author, text
   end

   def read_nreview doc

       author = (doc/"span.articlesubtitle[4]").inner_text

       #author = (doc/"h2.authorname").inner_text if author == ''
       #author = (doc/"address.byline/a").inner_text if author == ''

       unless author == ''
           author = author.gsub(' and ', '+') 
           author = author.gsub('By ', '+')
           author = author.gsub(',', '+')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', "’")


           author = author.downcase
           author_array = author.scan(/\w+/)
           author = ''
          author_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             author += word + ' '
           end
       author = '' if author.match('Associated Press')
       end



      #trash =  (doc/"div.storybody[1]").inner_text
     #  (doc/"div.content").remove
      # (doc/"#inlinegoogleads").remove
     text = (doc/"p.MsoNormal").inner_text
     # text = (doc/"div.article").inner_text if text == ''
       #document = (doc/"div.storybody[1]")
      #document = (doc/"#articleBody/nyt_text/p") if document.size < 1 #if document == nil or document == '' 
     #  text = text.sub(trash,'')

     intro = (doc/"span.articlesubtitle[3]").inner_text 
     text = intro + ' ' + text

       return author, text
   end

   def read_tnr doc
     # does not work yet

       author = (doc/"span.articleAuthor").inner_text
       #author = (doc/"h2.authorname").inner_text if author == ''
       author = (doc/"div.post-body/i").inner_text if author == ''

       unless author == ''
           author = author.gsub(' and ', '+') 
           author = author.gsub('By ', '+')
           author = author.gsub(',', '+')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', "’")


           author = author.downcase
           author_array = author.scan(/\w+/)
           author = ''
          author_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             author += word + ' '
           end
       author = '' if author.match('Associated Press')
       end



      #trash =  (doc/"div.storybody[1]").inner_text
     #  (doc/"div.content").remove
      # (doc/"#inlinegoogleads").remove
     text = (doc/"p.articleText").inner_text
      text = (doc/"p.first").inner_text if text == ''
       #document = (doc/"div.storybody[1]")
      #document = (doc/"#articleBody/nyt_text/p") if document.size < 1 #if document == nil or document == '' 
     #  text = text.sub(trash,'')

     # intro = (doc/"#deck.deck").inner_text 
    #text = intro + ' ' + text

       return author, text
   end

   def read_newyorker doc

       author = (doc/"span.c/a").inner_text

       #author = (doc/"h2.authorname").inner_text if author == ''
       #author = (doc/"address.byline/a").inner_text if author == ''

       unless author == ''
           author = author.gsub(' and ', '+') 
           author = author.gsub('By ', '+')
           author = author.gsub(',', '+')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', "’")


           author = author.downcase
           author_array = author.scan(/\w+/)
           author = ''
          author_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             author += word + ' '
           end
       author = '' if author.match('Associated Press')
       end



      #trash =  (doc/"div.storybody[1]").inner_text
     #  (doc/"div.content").remove
      # (doc/"#inlinegoogleads").remove
     text = (doc/"#articletext/p").inner_text
     # text = (doc/"div.article").inner_text if text == ''
       #document = (doc/"div.storybody[1]")
      #document = (doc/"#articleBody/nyt_text/p") if document.size < 1 #if document == nil or document == '' 
     #  text = text.sub(trash,'')

   #   intro = (doc/"#deck.deck").inner_text 
   # text = intro + ' ' + text

       return author, text
   end

   def read_harpers doc

       author = (doc/"#cached/p/i/a").inner_text

       #author = (doc/"h2.authorname").inner_text if author == ''
       #author = (doc/"address.byline/a").inner_text if author == ''

       unless author == ''

           author = author.gsub(' and ', '+')
           author = author.gsub('By ', '+')
           author = author.gsub(',', '+')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', "’")


           author = author.downcase
           author_array = author.scan(/\w+/)
           author = ''
          author_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             author += word + ' '
           end
       author = '' if author.match('Associated Press')
       end



      #trash =  (doc/"div.storybody[1]").inner_text
     (doc/"table.rcnt").remove
     (doc/"#cached/h1").remove
     (doc/"#cached/p/i").remove
     text = (doc/"#cached").inner_text
     # text = (doc/"div.article").inner_text if text == ''
       #document = (doc/"div.storybody[1]")
      #document = (doc/"#articleBody/nyt_text/p") if document.size < 1 #if document == nil or document == '' 
     #  text = text.sub(trash,'')

   #   intro = (doc/"#deck.deck").inner_text 
   # text = intro + ' ' + text

       return author, text
   end

   def read_businessweek doc

       author = (doc/"p.byline/a[1]").inner_text

       #author = (doc/"h2.authorname").inner_text if author == ''
       #author = (doc/"address.byline/a").inner_text if author == ''

       unless author == ''
           author = author.gsub(' and ', '+') 

           author = author.gsub('By ', '+')
           author = author.gsub(',', '+')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', "’")


           author = author.downcase
           author_array = author.scan(/\w+/)
           author = ''
          author_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             author += word + ' '
           end
       author = '' if author.match('Associated Press')
       end



     (doc/"p.byline").remove
     #(doc/"#cached/h1").remove
     #(doc/"#cached/p/i").remove
     text = (doc/"#storyBody/p").inner_text
     # text = (doc/"div.article").inner_text if text == ''


     intro = (doc/"#storyBody/h2").inner_text 
     text = intro + ' ' + text

       return author, text
   end

   def read_redherring doc

       author = (doc/"#ctl00_phMain_singlePostControl_postTitleControl_hlAuthor").inner_text

       #author = (doc/"h2.authorname").inner_text if author == ''
       #author = (doc/"address.byline/a").inner_text if author == ''

       unless author == ''
           author = author.gsub(' and ', '+') 
           author = author.gsub('By ', '+')
           author = author.gsub(',', '+')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', "’")


           author = author.downcase
           author_array = author.scan(/\w+/)
           author = ''
          author_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             author += word + ' '
           end
       author = '' if author.match('Associated Press')
       end



     (doc/"p.byline").remove
     #(doc/"#cached/h1").remove
     #(doc/"#cached/p/i").remove
     text = (doc/"div.entry-content/p").inner_text
     text = (doc/"div.entry-content").inner_text if text == ''
     text=text.sub('showInitialOdiogoReadNowFrame','')
     text=text.sub("('32285', '0', 290, 0);",'')

   #  intro = (doc/"#storyBody/h2").inner_text 
   #  text = intro + ' ' + text

       return author, text
   end

   def read_guardian doc

       author = (doc/"li.byline/a").inner_text

       author = (doc/"div.blog-byline/a").inner_text if author == ''
       #author = (doc/"address.byline/a").inner_text if author == ''

       unless author == ''
           author = author.gsub(' and ', '+') 
           author = author.gsub('By ', '+')
           author = author.gsub(',', '+')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', "’")


           author = author.downcase
           author_array = author.scan(/\w+/)
           author = ''
          author_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             author += word + ' '
           end
       author = '' if author.match('Associated Press')
       end



     #(doc/"p.byline").remove
     #(doc/"#cached/h1").remove
     #(doc/"#cached/p/i").remove
     text = (doc/"#article-wrapper/p").inner_text
     #text = (doc/"div.entry-content").inner_text if text == ''
     #text=text.sub('showInitialOdiogoReadNowFrame','')
     #text=text.sub("('32285', '0', 290, 0);",'')

    intro = (doc/"#stand-first").inner_text 
     text = intro + '. ' + text

       return author, text
   end

   def read_independent doc

       author = (doc/"p.info/author").inner_text

       #author = (doc/"div.blog-byline/a").inner_text if author == ''
       #author = (doc/"address.byline/a").inner_text if author == ''

       unless author == ''
           author = author.sub('From ', '+')
           author = author.sub('at ', '+')
           author = author.gsub(' and ', '+')        
           author = author.gsub('By ', '+')
           author = author.gsub(' in ', '+')
           author = author.gsub(',', '+')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', "’")


           author = author.downcase
           author_array = author.scan(/\w+/)
           author = ''
          author_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             author += word + ' '
           end
       author = '' if author.match('Associated Press')
       end



     #(doc/"p.byline").remove
     #(doc/"#cached/h1").remove
     #(doc/"#cached/p/i").remove
     text = (doc/"div.body/p").inner_text
     #text = (doc/"div.entry-content").inner_text if text == ''
     #text=text.sub('showInitialOdiogoReadNowFrame','')
     #text=text.sub("('32285', '0', 290, 0);",'')

   # intro = (doc/"#stand-first").inner_text 
    # text = intro + '. ' + text

       return author, text
   end

   def read_times doc
    #does not work yet
       author = (doc/"span.byline").inner_text

       #author = (doc/"div.blog-byline/a").inner_text if author == ''
       #author = (doc/"address.byline/a").inner_text if author == ''

       unless author == ''
           author = author.sub('From ', '+')
           author = author.gsub(' and ', '+') 
           author = author.gsub(' in ', '+')
           author = author.gsub('By ', '+')
           author = author.gsub(',', '+')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', "’")


           author = author.downcase
           author_array = author.scan(/\w+/)
           author = ''
          author_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             author += word + ' '
           end
       author = '' if author.match('Associated Press')
       end



     #(doc/"p.byline").remove
     #(doc/"#cached/h1").remove
     #(doc/"#cached/p/i").remove
     text = (doc/"#related-article-links/p").inner_text
     #text = (doc/"div.entry-content").inner_text if text == ''
     #text=text.sub('showInitialOdiogoReadNowFrame','')
     #text=text.sub("('32285', '0', 290, 0);",'')

   # intro = (doc/"#stand-first").inner_text 
    # text = intro + '. ' + text

       return author, text
   end

   def read_indiatimes doc

       author = (doc/"span.headingnextag").inner_text

       #author = (doc/"#page1/p").inner_text if author == ''
       #author = (doc/"address.byline/a").inner_text if author == ''

       unless author == ''
         author = author.gsub(' ', 'LUECKE')
         author = author.gsub(',', ' ')
         #author = author.gsub('IST', ' ')
       author_array = author.scan(/\w+/)
       author = author_array[2]
       author= '' if author == nil
         author = author.gsub('LUECKE', ' ')
       author = '' if author == 'AFP'
       author = '' if author == 'PTI'
       author = '' if author == 'AP'
       author = '' if author == 'IANS'
       author = '' if author == 'ANI'
       author = '' if author == 'TNN'
       author = '' if author == 'DPA'
       author = '' if author == 'REUTERS'
       author = '' if author == 'AGENCIES'
       
       

          author = author.downcase
           author_array = author.scan(/\w+/)
           author = ''
          author_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             author += word + ' '
           end  

       
       end



  unless author == ''
     text = (doc/"div.Normal").inner_text
  end
  
  if author == ''
    text= ''
    title = ''
  end
  
  author = '' if author == 'Timesofindia'
  author = '' if author == 'Times Now'
       return author, text
   end

   def read_economictimes doc

       author = (doc/"span.headingnext").inner_text

       #author = (doc/"#page1/p").inner_text if author == ''
       #author = (doc/"address.byline/a").inner_text if author == ''

       unless author == ''
         author = author.gsub(' ', 'LUECKE')
         author = author.gsub(',', ' ')
         #author = author.gsub('IST', ' ')
       author_array = author.scan(/\w+/)
       author = author_array[3]
       author= '' if author == nil
       author = author.gsub('LUECKE', ' ')
       author = '' if author == 'AFP'
       author = '' if author == 'PTI'
       author = '' if author == 'AP'
       author = '' if author == 'IANS'
       author = '' if author == 'ANI'
       author = '' if author == 'TNN'
       author = '' if author == 'DPA'
       author = '' if author == 'REUTERS'
       
      author = '' if author == 'AGENCIES'
      author = '' if author == 'TIMESOFINDIA'
      
        
    

          author = author.downcase
           author_array = author.scan(/\w+/)
           author = ''
          author_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             author += word + ' '
           end  

       #author = '' if author.match('Associated Press')

       end

    unless author == ''
      
     #(doc/"p.byline").remove
     #(doc/"#cached/h1").remove
     #(doc/"td.table").remove
     text = (doc/"#storydiv").inner_text

     text = (doc/"span").inner_text if text == ''
     #text=text.sub('showInitialOdiogoReadNowFrame','')
     text=text.sub("doweshowbellyad = 0;",'')
     text=text.sub("ECONOMICTIMES.COM",'')
    end
    
    if author == ''
      title = ''
      text = ''
    end
   # intro = (doc/"#stand-first").inner_text 
    # text = intro + '. ' + text
    author = ' ' if author == 'Economictimes'
    author = ' ' if author == 'Et Bureau'
    
       return author, text
   end

   def read_hindustantimes doc
    #does not work yet
       author = (doc/"#ctl00_RelatedWebSite_Relatedurl").inner_text

       #author = (doc/"#page1/p").inner_text if author == ''
       #author = (doc/"address.byline/a").inner_text if author == ''
       author = '' if author == nil
       unless author == '' 
           author = author.sub('From ', '+')
           author = author.sub('and ', '+') 
           author = author.gsub(' in ', '+')
           author = author.gsub('By ', '+')
           author = author.gsub(',', '+')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', "’")


           author = author.downcase
           author_array = author.scan(/\w+/)
           author = ''
          author_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             author += word + ' '
           end
       author = '' if author.match('Associated Press')
       end




     #(doc/"p.byline").remove
     #(doc/"#cached/h1").remove
     #(doc/"td.table").remove
     text = (doc/"#mainstory2/p").inner_text

     #text = (doc/"span").inner_text if text == ''
     #text=text.sub('showInitialOdiogoReadNowFrame','')
     #text=text.sub("doweshowbellyad = 0;",'')
     #text=text.sub("ECONOMICTIMES.COM",'')

   # intro = (doc/"#stand-first").inner_text 
    # text = intro + '. ' + text


       return author, text
   end

   def read_australian doc

       author = (doc/"div.module-subheader/p").inner_text

       #author = (doc/"#page1/p").inner_text if author == ''
       #author = (doc/"address.byline/a").inner_text if author == ''

       unless author == ''
         author = author.gsub(' and ', ',')
         author = author.gsub(' ', 'LUECKE')
         author = author.gsub(',', ' ')
         #author = author.gsub('IST', ' ')
       author_array = author.scan(/\w+/)
       author = author_array[0]
       author = author_array[1] if author == 'UPDATE'
       author = '' if author_array[1].match('20')
       author= '' if author == nil
       author = author.gsub('LUECKE', ' ')
       author = '' if author == 'AFP'
       author = '' if author == 'PTI'
       author = '' if author == 'AP'
       author = '' if author == 'IANS'
       author = '' if author == 'ANI'
       author = '' if author == 'TNN'
       author = '' if author == 'DPA'
       author = '' if author == 'REUTERS'
       author = '' if author == 'ECONOMICTIMES'

          author = author.downcase
           author_array = author.scan(/\w+/)
           author = ''
          author_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             author += word + ' '
           end  

       author = '' if author.match('Tour Match')
       end



     (doc/"div.module-subheader").remove
     #(doc/"#cached/h1").remove
     #(doc/"td.table").remove

     text = (doc/"#article.module").inner_text

     text = (doc/"#storydiv").inner_text if text == ''

     text = (doc/"span").inner_text if text == ''
     #text = (doc/"span").inner_text if text == ''
     #text=text.sub('showInitialOdiogoReadNowFrame','')
     text=text.sub("doweshowbellyad = 0;",'')
     
     text=text.sub("Article from:? The Australian",'')
     text=text.sub("Article",'')
     text=text.sub("Australian",'')

   # intro = (doc/"#stand-first").inner_text 
    # text = intro + '. ' + text


       return author, text
   end

   def read_theage doc

       author = (doc/"ul.articleDetails/li/strong").inner_text

       #author = (doc/"#page1/p").inner_text if author == ''
       #author = (doc/"address.byline/a").inner_text if author == ''

       unless author == ''

           author = author.sub('State Politics', '')
           author = author.sub('From ', '+')
           author = author.gsub(' and ', '+') 
           author = author.gsub(' in ', '+')
           author = author.gsub('By ', '+')
           author = author.gsub(',', '+')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', "’")


           author = author.downcase
           author_array = author.scan(/\w+/)
           author = ''
          author_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             author += word + ' '
           end
       author = '' if author.match('Associated Press')
       end




     #(doc/"p.byline").remove
     #(doc/"#cached/h1").remove
     #(doc/"td.table").remove
     text = (doc/"div.col1/p").inner_text

     #text = (doc/"span").inner_text if text == ''
     #text=text.sub('showInitialOdiogoReadNowFrame','')
     #text=text.sub("doweshowbellyad = 0;",'')
     #text=text.sub("ECONOMICTIMES.COM",'')

   # intro = (doc/"#stand-first").inner_text 
    # text = intro + '. ' + text


       return author, text
   end

   def read_sidney doc

       author = (doc/"#bylineDetails/byline").inner_text

       author = (doc/"div.articleDetails/byline").inner_text if author == ''
       #author = (doc/"address.byline/a").inner_text if author == ''

       unless author == ''

           author = author.sub('State Politics', '')
           author = author.sub('Political Correspondent', '')

           author = author.sub('From ', '+')
           author = author.gsub(' and ', '+') 
           author = author.gsub(' in ', '+')
           author = author.gsub('By ', '+')
           author = author.gsub(',', '+')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', "’")


           author = author.downcase
           author_array = author.scan(/\w+/)
           author = ''
          author_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             author += word + ' '
           end
       author = '' if author.match('Associated Press')
       end




     #(doc/"p.byline").remove
     #(doc/"#cached/h1").remove
     #(doc/"td.table").remove
     text = (doc/"#content/bod").inner_text

     #text = (doc/"span").inner_text if text == ''
     #text=text.sub('showInitialOdiogoReadNowFrame','')
     #text=text.sub("doweshowbellyad = 0;",'')
     #text=text.sub("ECONOMICTIMES.COM",'')

   # intro = (doc/"#stand-first").inner_text 
    # text = intro + '. ' + text


       return author, text
   end

   def read_kommersant doc
    # does not work yet
       author = (doc/"div.textauthor").inner_text

      # author = (doc/"div.articleDetails/byline").inner_text if author == ''
       #author = (doc/"address.byline/a").inner_text if author == ''

       unless author == ''

           author = author.sub('State Politics', '')
           author = author.sub('Political Correspondent', '')

           author = author.sub('From ', '+')
           author = author.gsub(' and ', '+') 
           author = author.gsub(' in ', '+')
           author = author.gsub('By ', '+')
           author = author.gsub(',', '+')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', "’")


           author = author.downcase
           author_array = author.scan(/\w+/)
           author = ''
          author_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             author += word + ' '
           end
       author = '' if author.match('Associated Press')
       end




     #(doc/"p.byline").remove
     #(doc/"#cached/h1").remove
     #(doc/"td.table").remove
     text = (doc/"span.news_main").inner_text

     #text = (doc/"span").inner_text if text == ''
     #text=text.sub('showInitialOdiogoReadNowFrame','')
     #text=text.sub("doweshowbellyad = 0;",'')
     #text=text.sub("ECONOMICTIMES.COM",'')

   # intro = (doc/"#stand-first").inner_text 
    # text = intro + '. ' + text


       return author, text
   end

   def read_sptimes doc

       author = (doc/"p.story_author").inner_text

       #author = (doc/"div.articleDetails/byline").inner_text if author == ''
       #author = (doc/"address.byline/a").inner_text if author == ''

       unless author == ''

           author = author.sub('State Politics', '')
           author = author.sub('Political Correspondent', '')

           author = author.sub('From ', '+')
           author = author.gsub(' and ', '+') 
           author = author.gsub(' in ', '+')
           author = author.gsub('By ', '+')
           author = author.gsub(',', '+')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', "’")


           author = author.downcase
           author_array = author.scan(/\w+/)
           author = ''
          author_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             author += word + ' '
           end
       author = '' if author.match('Associated Press')
       end




     #(doc/"p.byline").remove
     (doc/"p.story_author").remove
     (doc/"p.story_publisher").remove
     text = (doc/"td/p").inner_text

     #text = (doc/"span").inner_text if text == ''
     #text=text.sub('showInitialOdiogoReadNowFrame','')
     #text=text.sub("doweshowbellyad = 0;",'')
     #text=text.sub("ECONOMICTIMES.COM",'')

   # intro = (doc/"#stand-first").inner_text 
    # text = intro + '. ' + text


       return author, text
   end

   def read_moscowtimes doc

       author = (doc/"span.autor").inner_text

       #author = (doc/"div.articleDetails/byline").inner_text if author == ''
       #author = (doc/"address.byline/a").inner_text if author == ''

       unless author == ''

           author = author.sub('State Politics', '')
           author = author.sub('Political Correspondent', '')

           author = author.sub('From ', '+')
           author = author.gsub(' and ', '+') 
           author = author.gsub(' in ', '+')
           author = author.gsub('By ', '+')
           author = author.gsub(',', '+')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', "’")


           author = author.downcase
           author_array = author.scan(/\w+/)
           author = ''
          author_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             author += word + ' '
           end
       author = '' if author.match('Associated Press')
       end




     (doc/"p.textar").remove
     (doc/"td.foto_courtesy").remove
     (doc/"td.left_coll").remove
      (doc/"#caph1").remove
    # text = (doc/"td/i").inner_text

     text = (doc/"td").inner_text #if text == ''
     #text=text.sub('showInitialOdiogoReadNowFrame','')
     #text=text.sub("doweshowbellyad = 0;",'')
     text=text.sub("addthis_pub  = 'ruslanTMT';",'')

   # intro = (doc/"#stand-first").inner_text 
    # text = intro + '. ' + text


       return author, text
   end


   def read_spiegel doc

          intro = (doc/"p.spIntrotext/strong").inner_html

          author = (doc/"p.spAutorenzeile/a[1]").inner_html
          if author == ''
          author = (doc/"p.spAutorenzeile").inner_html 
          if author != ''

           author = author.sub('From ', '+')
           author = author.sub(' and ', '+') 
           author = author.gsub(' in ', '+')
           author = author.gsub('By ', '+')
           author = author.gsub(',', '+')       
           author = author.gsub('Von ', '+')

           author = author.gsub(',', '+')
          author = author.gsub('ß', 'ss')
           author = author.gsub('ä', '6')
           author = author.gsub('ü', '5')
           author = author.gsub('ö', '4')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

          author = author.gsub('+', ' ')
          author_array = author.scan(/\w+/)
          author = author_array[0]
          author = author.gsub('0', ' ')
          author = author.gsub('1', '.')
           author = author.gsub('2', '-')
            author = author.gsub('3', "’")
            author = author.gsub('6', 'ä')
            author = author.gsub('5', 'ü')
            author = author.gsub('4', 'ö')

          end
          end

          doc = (doc/"#spArticleBody/p")


          (doc/"div.spAsset").remove
          (doc/"div.spArticleImageBox").remove
          (doc/"div.spPhotoGallery").remove
          (doc/"div.spAssetInner").remove
          (doc/"div.spTagbox").remove
          (doc/"div.spCommentBox").remove



          text = doc.inner_text
          text = intro + ' ' + text

          return author, text
   end


   def read_sidney doc

       author = (doc/"#bylineDetails/byline").inner_text

       author = (doc/"div.articleDetails/byline").inner_text if author == ''
       #author = (doc/"address.byline/a").inner_text if author == ''

       unless author == ''

           author = author.sub('State Politics', '')
           author = author.sub('Political Correspondent', '')

           author = author.sub('From ', '+')
           author = author.gsub(' and ', '+') 
           author = author.gsub(' in ', '+')
           author = author.gsub('By ', '+')
           author = author.gsub(',', '+')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', "’")


           author = author.downcase
           author_array = author.scan(/\w+/)
           author = ''
          author_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             author += word + ' '
           end
       author = '' if author.match('Associated Press')
       end




     #(doc/"p.byline").remove
     #(doc/"#cached/h1").remove
     #(doc/"td.table").remove
     text = (doc/"#content/bod").inner_text

     #text = (doc/"span").inner_text if text == ''
     #text=text.sub('showInitialOdiogoReadNowFrame','')
     #text=text.sub("doweshowbellyad = 0;",'')
     #text=text.sub("ECONOMICTIMES.COM",'')

   # intro = (doc/"#stand-first").inner_text 
    # text = intro + '. ' + text


       return author, text
   end

   def read_haaretz doc

       author = (doc/"a.tUbl2").inner_text

       author = (doc/"td.t11B").inner_text if author == ''
       #author = (doc/"address.byline/a").inner_text if author == ''

       unless author == ''

           author = author.sub('State Politics', '')
           author = author.sub('Political Correspondent', '')

           author = author.sub('From ', '+')
           author = author.gsub(' and ', '+') 
           author = author.gsub(' in ', '+')
           author = author.gsub('By ', '+')
           author = author.gsub(',', '+')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', "’")

           author = '' if author == 'Reuters'
           author = author.downcase
           author_array = author.scan(/\w+/)
           author = ''
          author_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             author += word + ' '
           end
       author = '' if author.match('Associated Press')
       end


   #/html/body/table[4]/tbody/tr/td/table[2]/tbody/tr/td/table/tbody/tr[8]/td
     (doc/"span.wwwHaaretz").remove
     (doc/"sub").remove
     (doc/"h2").remove
     #(doc/"div.spAssetInner").remove
     #(doc/"div.spTagbox").remove
     #(doc/"div.spCommentBox").remove

     text = (doc/"td").inner_text

     #text = (doc/"span").inner_text if text == ''
     #text=text.sub('showInitialOdiogoReadNowFrame','')
     #text=text.sub("doweshowbellyad = 0;",'')
     #text=text.sub("ECONOMICTIMES.COM",'')

    #intro = (doc/"p.spIntrotext/strong").inner_text 
   #  text = intro + '. ' + text


       return author, text
   end

   def read_jpost doc

       author = (doc/"span.byline/a").inner_text

      # author = (doc/"div.articleDetails/byline").inner_text if author == ''
       #author = (doc/"address.byline/a").inner_text if author == ''

       unless author == ''

           author = author.sub('State Politics', '')
           author = author.sub('Political Correspondent', '')

           author = author.sub('From ', '+')
           author = author.gsub(' and ', '+') 
           author = author.gsub(' in ', '+')
           author = author.gsub('By ', '+')
           author = author.gsub(',', '+')
           author = author.gsub("’", '3')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')

           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', "’")

           author = '' if author.match('JPOST.COM STAFF')

           author = author.downcase
           author_array = author.scan(/\w+/)
           author = ''
          author_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             author += word + ' '
           end

       end




     #(doc/"p.byline").remove
     #(doc/"#cached/h1").remove
     #(doc/"td.table").remove
     text = (doc/"#artTxtMin/p").inner_text

     #text = (doc/"span").inner_text if text == ''
     #text=text.sub('showInitialOdiogoReadNowFrame','')
     #text=text.sub("doweshowbellyad = 0;",'')
     #text=text.sub("ECONOMICTIMES.COM",'')

   # intro = (doc/"#stand-first").inner_text 
    # text = intro + '. ' + text
         if author.match('Associated Press')
            text=''
            title =''
            author =''
        end
       return author, text
   end




   def en_create
     Eintrag.create(:name => 'English crawling started') 
     starting_time = Time.new

       @uncrawled_stories = []  
       language = 1
       @feedpages         = Feedpage.find(:all, :conditions => 'Active = 1')  
       @feedpages         = @feedpages.find_all{|l| l.language == 1 }
       @feedpages         = @feedpages.find_all{|l| l.video != true  }
       feedpage_ids       = @feedpages.collect{|f| f.id}.uniq*","
       unless feedpage_ids.blank?
         stories            = Rawstory.find(:all,
                                            :conditions => ["feedpage_id IN ( #{feedpage_ids})"],
                                            :select     => 'id, feedpage_id')
         stories_hashed     = stories.group_by{|s| s.feedpage_id} 
       end
       @feedpages.each do |page| 
           page.previous_size = stories_hashed[page.id].size
           page.save
           feed = FeedTools::Feed.open(page.url)


           feed.items.each do |item|    
               begin
                 #if stories_to_check.find_all{|l| l.title == item.title} == []
                  # if stories_to_check.find_all{|l| l.link == item.link} == []
                  # if (Rawstory.find_by_title(item.title) == nil) && (Rawstory.find_by_link(item.link) == nil)
              
                       
                       @story = Rawstory.create(:link => item.link)
              
                       
                       author, text, title, opinionated = read_page page.source.name, item.link
                       title = item.title if title == nil
                       author = '' if author == nil
                       text = text + ' ' + author

                       keywords = en_find_keywords title, text 

                       if Author.find_by_name(author) == nil
                           @author = Author.new(:name => author)
                           @author.save
                       else
                           @author = Author.find_by_name(author)
                       end        

                       opinionated = 1 if page.opinionated == 1
                       opinionated = 1 if @author.opinionated == 1  
                       opinionated = 1 if title.match('Commentary')
                       opinionated = 1 if title.match('Column')
                       opinionated = 1 if title.match('Op-Ed')     
                       opinionated = 1 if title.match('OpEd')          
                       opinionated = 1 if title.match('Interview')
                       opinionated = 1 if title.match('Analysis')
                       opinionated = 1 if title.match('Opinion')
                       opinionated = 1 if title.match('Editorial')
                       opinionated = 1 if title.match('Editors')
                       opinionated = 1 if title.match('Comment')

                       #@author.rawstories.create(:author => @author, :title => title, :link => item.link, :feedpage => page, :source => page.source, :body => text, :opinion => opinionated, :language => language, :keywords => keywords)
                   @story.title = title
                   @story.author = @author
                   @story.feedpage = page
                   @story.source = page.source
                   @story.body = text
                   @story.opinion = opinionated
                   @story.language = language
                   @story.keywords = keywords
                   @story.save
                   
                   # end
                  #end
                  # end
                   rescue StandardError, Interrupt
                   #@uncrawled_stories = @uncrawled_stories + [item] 

               end  
           end  
       end
       finishing_time = Time.new
       duration = (finishing_time - starting_time)/60
       Eintrag.create(:name => 'English crawling completed', :duration => duration) 
   end


   def en_find_keywords title, text

             text = title + ' ' + text
             text = text.gsub(/\W/, ' ')

             array = text.split(/\s+/)

             array = array.collect {|e| e if e.match(/[A-Z]/)}


             array = array.collect {|e| e.downcase if e != nil}
             array = array.first(40)

             position = array.inject(Hash.new(0)) {|h,x| h[x]+=1;h}
             position.delete_if {|key, value| key == nil}
             position.delete_if {|key, value| key.size < 2}
             keys = position.keys.first(30)
             keywords = keys.join(' ')
             keywords = ' ' + keywords + ' '
             if keywords != nil
            
            keywords=keywords.sub('—',' ')
            
            keywords=keywords.sub(' jan ',' ')
            keywords=keywords.sub(' feb ',' ')
            keywords=keywords.sub(' mar ',' ')
            keywords=keywords.sub(' apr ',' ')
            keywords=keywords.sub(' may ',' ')
            keywords=keywords.sub(' jun ',' ')
            keywords=keywords.sub(' jul ',' ')
            keywords=keywords.sub(' aug ',' ')
            keywords=keywords.sub(' sep ',' ')
            keywords=keywords.sub(' oct ',' ')
            keywords=keywords.sub(' nov ',' ')
            keywords=keywords.sub(' dec ',' ')
            
            keywords=keywords.sub(' monday ',' ')
            keywords=keywords.sub(' tuesday ',' ')
            keywords=keywords.sub(' wednesday ',' ')
            keywords=keywords.sub(' thursday ',' ')
            keywords=keywords.sub(' friday ',' ')
            keywords=keywords.sub(' saturday ',' ')
            keywords=keywords.sub(' sunday ',' ')
               
            keywords=keywords.sub(' a ',' ')
            keywords=keywords.sub(' ap ',' ')
            keywords=keywords.sub(' about ',' ')
            keywords=keywords.sub(' an ',' ')
            keywords=keywords.sub(' am ',' ')
            keywords=keywords.sub(' and ',' ')
            keywords=keywords.sub(' are ',' ')
            keywords=keywords.sub(' at ',' ')
            keywords=keywords.sub(' as ',' ')
            keywords=keywords.sub(' be ',' ')
            keywords=keywords.sub(' but ',' ')
            keywords=keywords.sub(' by ',' ')
            keywords=keywords.sub(' can ',' ')
            keywords=keywords.sub(' do ',' ')
            keywords=keywords.sub(' does ',' ')    
            keywords=keywords.sub(' for ',' ')
            keywords=keywords.sub(' from ',' ')
            keywords=keywords.sub(' got ',' ')
            keywords=keywords.sub(' has ',' ')
            keywords=keywords.sub(' have ',' ')
            keywords=keywords.sub(' he ',' ')
            keywords=keywords.sub(' her ',' ')
            keywords=keywords.sub(' him ',' ')
            keywords=keywords.sub(' if ',' ')
            keywords=keywords.sub(' ii ',' ')
            keywords=keywords.sub(' in ',' ')
            keywords=keywords.sub(' into ',' ')
            keywords=keywords.sub(' is ',' ')
            keywords=keywords.sub(' it ',' ')
            keywords=keywords.sub(' no ',' ')
            keywords=keywords.sub(' not ',' ')
            keywords=keywords.sub(' now ',' ')
            keywords=keywords.sub(' of ',' ')
            keywords=keywords.sub(' off ',' ')
            keywords=keywords.sub(' on ',' ')
            keywords=keywords.sub(' out ',' ')
            keywords=keywords.sub(' over ',' ')
            keywords=keywords.sub(' she ',' ')
            keywords=keywords.sub(' should ',' ')
            keywords=keywords.sub(' so ',' ')
            keywords=keywords.sub(' some ',' ')
            keywords=keywords.sub(' that ',' ')
            keywords=keywords.sub(' the ',' ')
            keywords=keywords.sub(' their ',' ')
            keywords=keywords.sub(' them ',' ')
            keywords=keywords.sub(' there ',' ')
            keywords=keywords.sub(' they ',' ')
            keywords=keywords.sub(' this ',' ')
            keywords=keywords.sub(' to ',' ')
            keywords=keywords.sub(' under ',' ')
            keywords=keywords.sub(' up ',' ')
            keywords=keywords.sub(' you ',' ')
            keywords=keywords.sub(' was ',' ')
            keywords=keywords.sub(' we ',' ')
            keywords=keywords.sub(' what ',' ')
            keywords=keywords.sub(' when ',' ')
            keywords=keywords.sub(' which ',' ')
            keywords=keywords.sub(' who ',' ')
            keywords=keywords.sub(' will ',' ')
            keywords=keywords.sub(' with ',' ')
         
           end
             return keywords

   end


while($running) do
 en_create
 sleep 1
end
