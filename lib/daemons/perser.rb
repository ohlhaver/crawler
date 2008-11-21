#!/usr/bin/env ruby

#You might want to change this
#ENV["RAILS_ENV"] ||= "development"

require File.dirname(__FILE__) + "/../../config/environment"
include ExceptionNotifiable
$running = true;
Signal.trap("TERM") do 
  $running = false
end

while($running) do

    
  def read_page page_source_name, item_link
    require 'hpricot'
    require 'open-uri'
    require 'iconv'  
         
         if page_source_name == 'www.ft.com' 
            f = open(item_link)
             f.rewind
             doc = Hpricot(Iconv.conv('utf-8', f.charset, f.readlines.join("\n")))
            a= read_ft doc
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
         
         
      if page_source_name == 'www.11freunde.de'
       f = open(item_link)
       f.rewind
       doc = Hpricot(Iconv.conv('utf-8', f.charset, f.readlines.join("\n")))
       a= read_11freunde doc
      end
  
      if page_source_name == 'www.kicker.de'
        f = open(item_link)
        f.rewind
        doc = Hpricot(Iconv.conv('utf-8', f.charset, f.readlines.join("\n")))
        a= read_kicker doc
      end
  
      if page_source_name == 'www.fr-online.de'
        f = open(item_link)
        f.rewind
        doc = Hpricot(Iconv.conv('utf-8', f.charset, f.readlines.join("\n")))
        a= read_rundschau doc
      end
  
      if page_source_name == 'www.handelsblatt.com'
       f = open(item_link)
         f.rewind
      doc = Hpricot(Iconv.conv('utf-8', f.charset, f.readlines.join("\n")))
        a= read_handelsblatt doc
      end
      
      if page_source_name == 'www.tagesspiegel.de'
         f = open(item_link)
         f.rewind
        doc = Hpricot(Iconv.conv('utf-8', f.charset, f.readlines.join("\n")))
         a= read_tagesspiegel doc
      end
         
      if page_source_name == 'diepresse.com' 
       doc =Hpricot(open(item_link))
        a= read_diepresse doc
      end

      if page_source_name == 'www.cicero.de Blogs' 
          f = open(item_link)
          f.rewind
          doc = Hpricot(Iconv.conv('utf-8', f.charset, f.readlines.join("\n")))
          a= read_cicero_blogs doc
      end
 
      if page_source_name == 'www.cicero.de' 
          f = open(item_link)
          f.rewind
          doc = Hpricot(Iconv.conv('utf-8', f.charset, f.readlines.join("\n")))
          a= read_cicero doc
      end

      if page_source_name == 'derstandard.at' 
          item_link = item_link.sub("?url=/%3F", "text/?")
          doc =Hpricot(open(item_link))
          a= read_derstandard doc
      end

      if page_source_name == 'bazonline.ch'
          doc =Hpricot(open(item_link))
          a= read_baz doc
      end

      if page_source_name == 'www.ftd.de' 
          f = open(item_link)
          f.rewind
          doc = Hpricot(Iconv.conv('utf-8', f.charset, f.readlines.join("\n")))
          a= read_ftd doc
      end
          
      if page_source_name == 'www.spiegel.de' 
          f = open(item_link)
          f.rewind
          doc = Hpricot(Iconv.conv('utf-8', f.charset, f.readlines.join("\n")))
          a= read_spiegel doc
      end
      
      if page_source_name == 'www.faz.net'
            doc =Hpricot(open(item_link))
            a= read_faz doc
      end
      
      if page_source_name == 'www.nzz.ch' 
          doc =Hpricot(open(item_link))
          a= read_nzz doc
      end
            
      if page_source_name == 'www.zeit.de'
            f = open(item_link)
            f.rewind
            doc = Hpricot(Iconv.conv('utf-8', f.charset, f.readlines.join("\n")))
            a= read_zeit doc
      end
       
      if page_source_name == 'www.sueddeutsche.de'
            f = open(item_link)
            f.rewind
            doc = Hpricot(Iconv.conv('utf-8', f.charset, f.readlines.join("\n")))
            a= read_sueddeutsche doc 
      end
      
      if page_source_name == 'www.welt.de'
            f = open(item_link)
            f.rewind
            doc = Hpricot(Iconv.conv('utf-8', f.charset, f.readlines.join("\n")))
            a= read_welt doc 
      end
      
      if page_source_name == 'www.taz.de'
            doc =Hpricot(open(item_link))
            a= read_taz doc
      end
      
  
      return a
  end

  
  def read_nytimes doc

      author = (doc/"div.byline/a").inner_text
      author = (doc/"address.byline/a").inner_text if author == ''

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
      #roof_title = (doc/"h1.dach").inner_text
      #title = (doc/"h2.artikelhead").inner_html
      #title = roof_title + ': ' + title if roof_title != '' 
     # author = (doc/"div.ft-story-header/p[1]").inner_text
    #  /html/body/div[4]/div/div/div/div/div[2]/div/div/div/p
      author = ''

      super_headline = (doc/"p.fly-title").inner_text
      title = (doc/"div.col-left/h1").inner_text
    title = super_headline + ': ' + headline if super_headline != ''  
      intro = (doc/"div.col-left/h2[1]").inner_text
      trash = (doc/"div.col-left/p[2]").inner_text
      trash_2 = (doc/"p.info").inner_text
      text = (doc/"div.col-left/p").inner_text

     text = text.sub(trash, '')
     text = text.sub(trash_2, '')
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



    #(doc/"p.byline").remove
    #(doc/"#cached/h1").remove
    #(doc/"#cached/p/i").remove
    text = (doc/"div.Normal").inner_text
    #text = (doc/"div.entry-content").inner_text if text == ''
    #text=text.sub('showInitialOdiogoReadNowFrame','')
    #text=text.sub("('32285', '0', 290, 0);",'')

  # intro = (doc/"#stand-first").inner_text 
   # text = intro + '. ' + text

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

      #author = '' if author.match('Associated Press')
      end



    #(doc/"p.byline").remove
    #(doc/"#cached/h1").remove
    #(doc/"td.table").remove
    text = (doc/"#storydiv").inner_text

    text = (doc/"span").inner_text if text == ''
    #text=text.sub('showInitialOdiogoReadNowFrame','')
    text=text.sub("doweshowbellyad = 0;",'')
    text=text.sub("ECONOMICTIMES.COM",'')

  # intro = (doc/"#stand-first").inner_text 
   # text = intro + '. ' + text


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

      #author = '' if author.match('Associated Press')
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
    text=text.sub("ECONOMICTIMES.COM",'')

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

  def read_english_spiegel doc

      author = (doc/"p.spAutorenzeile").inner_text

      #author = (doc/"div.articleDetails/byline").inner_text if author == ''
      #author = (doc/"address.byline/a").inner_text if author == ''

      unless author == ''

          author = author.sub('State Politics', '')
          author = author.sub('Political Correspondent', '')

          author = author.sub('From ', '+')
          author = author.sub(' and ', '+') 
          author = author.gsub(' in ', '+')
          author = author.gsub('By ', '+')
          author = author.gsub(',', '+')
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



      (doc/"div.spAsset").remove
      (doc/"div.spArticleImageBox").remove
      (doc/"div.spPhotoGallery").remove
      (doc/"div.spAssetInner").remove
      (doc/"div.spTagbox").remove
      (doc/"div.spCommentBox").remove
    text = (doc/"#spArticleBody").inner_text

    #text = (doc/"span").inner_text if text == ''
    #text=text.sub('showInitialOdiogoReadNowFrame','')
    #text=text.sub("doweshowbellyad = 0;",'')
    #text=text.sub("ECONOMICTIMES.COM",'')

   intro = (doc/"p.spIntrotext/strong").inner_text 
    text = intro + '. ' + text


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
          author = '' if author.match('ASSOCIATED PRESS')
          author = '' if author.match('JPOST.COM STAFF')
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


      return author, text
  end
  
  def read_handelsblatt doc
      roof_title = (doc/"span.headline").inner_text
      title = (doc/"div.cnArticle/h2").inner_text
      title = roof_title + ': ' + title if roof_title != ''
      title = title.sub(' ','') if title.first == ' '
      author = (doc/"div.cnArticle/cite").inner_text
      unless author == nil
          author = author.sub('von ', '+')
          author = author.gsub(' und ', '+')
          author = author.gsub(',', '+')
          author = author.gsub('-', '2')
          author = author.gsub('.', '1')
          author = author.gsub(' ', '0')
          author = author.gsub('ä', '3')
          author = author.gsub('ü', '4')
          author = author.gsub('ö', '5')

          author = author.gsub('+', ' ')
          author_array = author.scan(/\w+/)
          author = author_array[0]
          author = author.gsub('0', ' ')
          author = author.gsub('1', '.')
          author = author.gsub('2', '-')
          author = author.gsub('3', 'ä')
          author = author.gsub('4', 'ü')
          author = author.gsub('5', 'ö')

      end

      doc = (doc/"div.text")     
      text = doc.inner_text

      return author, text, title
  end
  
  def read_tagesspiegel doc
     author = (doc/"a.ISI_IGNORE[1]").inner_html

     if ! author.match('Von')
       author_array = author.scan(/\w+/)
       author = author_array[0] + ' ' + author_array[2]
     else

       author = author.gsub('Von ', '+') unless author == nil
       author = author.gsub(',', '+')
       author = author.gsub('und', '+')
       author = author.gsub(' ', '0')
       author = author.gsub('-', '1')
       author = author.gsub('.', '2')
       author = author.gsub('+', ' ')
       author_array = author.scan(/\w+/)

       author = author_array[0]
       author = author.gsub('0', ' ')
       author = author.gsub('1', '-')
       author = author.gsub('2', '.')
       intro = (doc/"div.article_body/div[2]").inner_text
       doc = (doc/"#ar_text")
       text = doc.inner_text
       text =  intro + ' ' + text
     end
     return author, text
  end
 
  def read_faz doc
       author = (doc/"p.Author/a").inner_html
       author = (doc/"p.Author").inner_html if author == ''
        unless author == nil
            author = author.sub('Von ', '+')
            author = author.gsub(' und ', '+')
            author = author.gsub(',', '+')
            author = author.gsub('-', '2')
            author = author.gsub('.', '1')
            author = author.gsub(' ', '0')
            author = author.gsub('ä', '3')
            author = author.gsub('ü', '4')
            author = author.gsub('ö', '5')

            author = author.gsub('+', ' ')
            author_array = author.scan(/\w+/)
            author = author_array[0]
            author = author.gsub('0', ' ')
            author = author.gsub('1', '.')
            author = author.gsub('2', '-')
            author = author.gsub('3', 'ä')
            author = author.gsub('4', 'ü')
            author = author.gsub('5', 'ö')

        end
        doc = (doc/"div.Article/p")
        (doc/"span.Italic").remove
        text = doc.inner_text
        return author, text
  end
  
  def read_sueddeutsche doc
       roof_title = (doc/"h2.artikelDachzeile").inner_text
       title = (doc/"h1.artikelTitel").inner_text
       title = roof_title + ': ' + title if roof_title != ''

       author = (doc/"span.artikelAutor").inner_text
       opinionated = 1 if author.match('Kommentar')
       opinionated = 1 if author.match('Analyse')
       opinionated = 1 if author.match('Außenansicht')
       opinionated = 1 if author.match('kommentar')
       opinionated = 1 if author.match('Klagelied')
       opinionated = 1 if author.match('Nachruf')
       opinionated = 1 if author.match('Glosse')
       opinionated = 1 if author.match('Kritik')
       opinionated = 1 if author.match('kritik')
       opinionated = 1 if author.match('Interview')
       
       
       unless author == nil
           author = author.sub('Eine Analyse von ', '+')
           author = author.sub('Eine Außenansicht von ', '+')
           author = author.sub('Ein Audiokommentar von ', '+')
           author = author.sub('Ein Gastkommentar von ', '+')
           author = author.sub('Ein Klagelied von ', '+')
           author = author.sub('Ein Kommentar von ', '+')
           author = author.sub('Ein Nachruf von ', '+')
           author = author.sub('Ein Rückblick von ', '+')
           author = author.sub('Ein Rückblick in Bildern von ', '+')
           author = author.sub('Ein Überblick von  ', '+')
           author = author.sub('Eine Glosse von ', '+')
           author = author.sub('Eine Nachtkritik von ', '+')
           author = author.sub('Eine Reportage von ', '+')
           author = author.sub('Interview:  ', '+')
           author = author.sub('Interview: ', '+')
           author = author.sub('Interview von ', '+')
           author = author.sub('Eine Reportage von ', '+')


           author = author.gsub('Von ', '+')
           author = author.gsub(' und ', '+')
           author = author.gsub(',', '+')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')
           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')

       end
       intro = (doc/"p.artikelTeaser/strong").inner_text


       doc =(doc/"table.bgf2f2f2")
       text = doc.inner_text
       text = intro + ' ' + text

       return author, text, title, opinionated
  end
  
  def read_zeit doc
     roof_title = (doc/"div.articletext/h3").inner_text
     title = (doc/"div.articletext/h2").inner_text
     title = roof_title + ': ' + title if roof_title != ''

     author = (doc/"cite.author").inner_html
     author_array = author.split(/\|/)
     author = author_array.first.sub('Von ', '') unless author_array.first == nil 
     author = author.chop

     doc = (doc/"div.articlebody/p")
     text = doc.inner_text

     return author, text ,title
  end

  def read_nzz doc
      roof = (doc/"div.upperTitle").inner_text
      opinionated = 1 if roof.match('Kommentar')
      author = (doc/"p.quelle").inner_text
      opinionated = 1 if author.match('Interview')
      by_correspondent = 1 if author.match('Korrespondent')
       unless author == '' 
            author = author.gsub('Interview: ', '+')
            author = author.gsub('Korrespondenten ', '+')
            author = author.gsub('Korrespondentin ', '+')
            author = author.gsub('  ', '+')
            author = author.sub('Von ', '+')
            author = author.gsub(' und ', '+')
            author = author.gsub(',', '+')
            author = author.gsub('-', '2')
            author = author.gsub('.', '1')
            author = author.gsub(' ', '0')
            author = author.gsub('ä', '3')
            author = author.gsub('ü', '4')
            author = author.gsub('ö', '5')

            author = author.gsub('+', ' ')
            author_array = author.scan(/\w+/)
            author = author_array[0]
            author = author_array[2] if by_correspondent == 1
            author = author.gsub('0', ' ')
            author = author.gsub('1', '.')
            author = author.gsub('2', '-')
            author = author.gsub('3', 'ä')
            author = author.gsub('4', 'ü')
            author = author.gsub('5', 'ö')

          end
      intro = (doc/"div.body/h5").inner_text  
      doc = (doc/"div.body/p")
      text = doc.inner_text
      text = intro + ' ' + text
      title = nil
      return author, text , title, opinionated
  end
  
  def read_welt doc
      author = (doc/"span.author").inner_text
       unless author == nil
           author = author.gsub('Von ', '+')
           author = author.gsub(' und ', '+')
           author = author.gsub('  ', '')
           author = author.gsub(',', '+')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')
           author = author.gsub('+', ' ')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')

       end
     author = nil if author == 'Blanche Ebutt'
     author = nil if author == 'Uta Keseling'
     author = nil if author == 'Gnadenlos'
     author = nil if author == 'Mojib Latif'
     doc = (doc/"div.articleBox/p")  
     text = doc.inner_text
       return author, text
  end
  
  def read_ftd doc

      roof_title = (doc/"h1.dach").inner_text
      title = (doc/"h2.artikelhead").inner_text
      title = roof_title + ': ' + title if roof_title != '' 
      title = title.sub('Dossier ', '')
      author = (doc/"h4.bot").inner_text

      unless author == nil
          author = author.sub('von ', '+') 
          author = author.gsub('und', '+')
          author = author.gsub(',', '+')
          author = author.gsub('-', '2')
          author = author.gsub('.', '1')
          author = author.gsub(' ', '0')
          author = author.gsub('ä', '3')
          author = author.gsub('ü', '4')
          author = author.gsub('ö', '5')

          author = author.gsub('+', ' ')
          author_array = author.scan(/\w+/)
          author = author_array[0]
          author = author.gsub('0', ' ')
          author = author.gsub('1', '.')
          author = author.gsub('2', '-')
          author = author.gsub('3', 'ä')
          author = author.gsub('4', 'ü')
          author = author.gsub('5', 'ö')

      end
      intro = (doc/"h3.anlauf").inner_text
      doc = (doc/"div.artikeltext/p")
      text = doc.inner_text

      text = intro + ' ' + text
      return author, text, title
  end

  def read_derstandard doc
      author = (doc/"p.Author").inner_html
      #author = (doc/"a[4]/b").inner_text if author == ''
      author = author.sub('Von ', '') unless author == nil
      doc = (doc/"font.m")
      text = doc.inner_text
    
      text = text.sub('derStandard.at | Politik | Investor | Web | Sport | Panorama | Etat | Kultur | Wissenschaft | Meinung | Zeitungsarchiv? | Suche:', '')
      text = text.sub('derStandard.at | Politik | Investor | Web | Sport | Panorama | Etat | Kultur | Wissenschaft | Meinung | Zeitungsarchiv', '' )
      return author, text
  end

  def read_diepresse doc
         author = (doc/"p.articletime").inner_html
         unless author == nil
         author = author.gsub('|', '+')
         author = author.gsub('(', '+')
         author = author.gsub(' ', '0')
         author = author.gsub('+', ' ')
         author_array = author.scan(/\w+/)
         author = author_array[7]
         author = author.gsub('0', ' ')
         author = nil if author == 'DiePresse'
         author = nil if author == 'Die Presse'
         author = author.sub('Von unserem Korrespondenten ', '')
         author = author.sub('Von unserer Korrespondentin ', '')
         author = author.sub('Von ', '+')
         author = author.sub('VON ', '+')
         author = author.gsub(' und ', '+')
         author = author.gsub(' UND ', '+')
         author = author.gsub(',', '+')
         author = author.gsub('-', '2')
         author = author.gsub('.', '1')
         author = author.gsub(' ', '0')
         author = author.gsub('+', ' ')
         author_array = author.scan(/\w+/)
         author = author_array[0]
         author = author.gsub('0', ' ')
         author = author.gsub('1', '.')
         author = author.gsub('2', '-')
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
       intro = (doc/"p.articlelead/strong").inner_text  
       doc = (doc/"div.articletext/p")
       text = doc.inner_text
       text = intro + ' ' + text
       return author, text
  end

  def read_baz doc
      author = (doc/"#metaLine/h5").inner_text
      unless author == nil
          author = author.sub('Von ', '') 
          author = author.gsub(' ', '0')
          author = author.gsub('.', ' ')
          author_array = author.scan(/\w+/)
          author = author_array[0]
          author = author.gsub('0', ' ')
          author = nil if author.match('Aktualisiert')
      end
        doc = (doc/"#singleLeft/p")
        text = doc.inner_text
      return author, text
  end

  def read_taz doc
          author = (doc/"span.autor").inner_html
          intro = (doc/"p.artikelintro").inner_text
          intro = intro.sub(author, '')

          unless author == nil
             author = author.gsub('VON', '+')
             author = author.gsub('&', '+')
             author = author.gsub(' ', '0')
             author = author.gsub('.', '1')
             author = author.gsub('Ä', '3')
             author = author.gsub('Ü', '4')
             author = author.gsub('Ö', '5')
             author = author.gsub('ä', '3')
             author = author.gsub('ü', '4')
             author = author.gsub('ö', '5')
             author = author.gsub('-', '6')
             author = author.gsub('+', ' ')
             author_array = author.scan(/\w+/)
             author = author_array.first
             author = author.gsub('0', ' ')
             author = author.gsub('1', '.')
             author = author.gsub('6', '-')


             author = author.downcase
             author_array = author.scan(/\w+/)
             author = ''
            author_array.each do |word|
               word_a = word.first.upcase
               word_a = 'Ä' if word.first == '3'
               word_a = 'Ü' if word.first == '4'
               word_a = 'Ö' if word.first == '5'
               word_b = word.sub(word.first, '')

               word = word_a + word_b  
               author += word + ' '

             end
             author = author.gsub('3', 'ä')
             author = author.gsub('4', 'ü')
             author = author.gsub('5', 'ö')


           end

          doc = (doc/"p.artikeltext")
          text = doc.inner_text
          text = intro + ' ' + text
          return author, text
  end
  
  def read_cicero_blogs doc


      title = (doc/"td.header").inner_text
    
      author = (doc/"div[2]/table[5]/tr[2]").inner_text
    
      author = author.sub('von ', '') unless author == nil
      doc = (doc/"table[6]")
      text = doc.inner_text
      
      text = text.sub('Dieses Video ist in Zusammenarbeit mit unserem Kooperationspartner politik.de entstanden.', '' )
      
      return author, text, title
  end

  def read_cicero doc
      title = (doc/"span.header").inner_text
      author = (doc/"span.red[2]").inner_html
      author = author.sub('von ', '') unless author == nil
      #intro = (doc/"span.boldRed").inner_text
      doc = (doc/"table[5]")
      text = doc.inner_text
      text = text.sub('Kolumnen', '' )
      return author, text, title
  end

  def read_rundschau doc
       roof_title = (doc/"span.dz").inner_text
       title = (doc/"h2.hz").inner_text
       title = roof_title + ': ' + title if roof_title != ''
       author = (doc/"div.az").inner_text
       unless author == nil
         author = author.gsub('VON', '+')
         author = author.gsub('Von', '+')   
         author = author.sub('Von ', '+')
         author = author.gsub(' und ', '+')
         author = author.gsub(' UND ', '+')
         author = author.gsub(',', '+')
         author = author.gsub('-', '2')
         author = author.gsub('.', '1')
         author = author.gsub(' ', '0')
         author = author.gsub('?', '3')

         author = author.gsub('+', ' ')
         author_array = author.scan(/\w+/)
         author = author_array[0]
         author = author.gsub('0', ' ')
         author = author.gsub('1', '.')
         author = author.gsub('2', '-')

         author = author.downcase
         author_array = author.scan(/\w+/)
         author = ''
         author_array.each do |word|
           word_a = word.first.upcase
           word_b = word.sub(word.first, '')

           word = word_a + word_b  
           author += word + ' '
         end
         author = author.gsub('3', '?')
       end
            doc = (doc/"div.text")
       text = doc.inner_text
       if title.match('Seite nicht gefunden')
           text = ''
           title = ''
           author = ''
       end
       return author, text, title
  end
  
  def read_11freunde doc
      roof_title = (doc/"span.orgType").inner_text
      title = (doc/"div[2]/h1/a").inner_text
      title = title.sub('SCHLAGZEILEN' ,'')
      title = roof_title + ': ' + title
      author = (doc/"div[2]/p[2]/i/span[2]").inner_html
      author = nil if author == 'sid'
      author = '' if author == nil


      unless author == ''
          author = author.sub('Von ', '+')
          author = author.sub('von ', '+')
          author = author.gsub(' und ', '+')
          author = author.gsub(',', '+')
          author = author.gsub('-', '2')
          author = author.gsub('.', '1')
          author = author.gsub(' ', '0')
          author = author.gsub('ä', '3')
          author = author.gsub('ü', '4')
          author = author.gsub('ö', '5')

          author = author.gsub('+', ' ')
          author_array = author.scan(/\w+/)
          author = author_array[0]
          author = author.gsub('0', ' ')
          author = author.gsub('1', '.')
          author = author.gsub('2', '-')
          author = author.gsub('3', 'ä')
          author = author.gsub('4', 'ü')
          author = author.gsub('5', 'ö')

      end


      intro = (doc/"div[2]/p[3]/strong").inner_text
      doc_2 = (doc/"div[2]/p[3]")
      doc = (doc/"div[2]/p[4]")
      text = doc.inner_text
      
      if text == ''
          text_2 = doc_2.inner_text
        else
          text_2 = ''
      end
      
      text = intro + ' ' + text + text_2
      text = text.sub('---News, Interviews, Blogs, Statistiken und Service zu:', '') 
      return author, text, title
  end
 
  def read_kicker doc
      roof_title = (doc/"p.topline").inner_text
      roof_title = roof_title.gsub(':', '')
      title = (doc/"h1").inner_text
      title = roof_title + ': ' + title
      title = title.sub('Hintergrundreport', '')
      
      author = ''
      doc = (doc/"#art/p")
      text = doc.inner_text
      text = text.sub(roof_title, '')
      return author, text, title
  end
 

  def de_create
      Eintrag.create(:name => 'German crawling started') 
      starting_time = Time.new

        require 'rubygems'
        require 'feed_tools'
        language = 2
        @uncrawled_stories = []  

        @feedpages = Feedpage.find(:all, :conditions => 'Active = 1')  
        @feedpages = @feedpages.find_all{|l| l.language == 2 }

        @feedpages.each do |page| 
            page.previous_size = page.rawstories.size
            page.save
            feed = FeedTools::Feed.open(page.url)


            feed.items.each do |item|    
                begin
                  #  if (Rawstory.find_by_title(item.title) == nil) && (Rawstory.find_by_link(item.link) == nil)
                        @story = Rawstory.create(:link => item.link)
                    
                        author, text, title, opinionated = read_page page.source.name, item.link
                        title = item.title if title == nil
                        author = '' if author == nil
                        text = text + ' ' + author

                        keywords = de_find_keywords title, text 

                        if Author.find_by_name(author) == nil
                            @author = Author.new(:name => author)
                            @author.save
                        else
                            @author = Author.find_by_name(author)
                        end        

                        opinionated = 1 if page.opinionated == 1
                        opinionated = 1 if @author.opinionated == 1  
                        opinionated = 1 if title.match('Kommentar')
                        opinionated = 1 if title.match('Komment@r')
                        opinionated = 1 if title.match('Gastkommentar')     
                        opinionated = 1 if title.match('Kolumne')          
                        opinionated = 1 if title.match('Interview')
                        opinionated = 1 if title.match('Analyse')
                        opinionated = 1 if title.match('Glosse')

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
                    #end
                    rescue StandardError, Interrupt
                    #@uncrawled_stories = @uncrawled_stories + [item] 

                end  
            end  
        end
        finishing_time = Time.new
        duration = (finishing_time - starting_time)/60
        Eintrag.create(:name => 'German crawling completed', :duration => duration) 
    end
  
  def en_create
    Eintrag.create(:name => 'English crawling started') 
    starting_time = Time.new
     
      require 'rubygems'
      require 'feed_tools'
      @uncrawled_stories = []  
      language = 1
      @feedpages = Feedpage.find(:all, :conditions => 'Active = 1')  
      @feedpages = @feedpages.find_all{|l| l.language == 1 }
        
      
      @feedpages.each do |page| 
          page.previous_size = page.rawstories.size
          page.save
          feed = FeedTools::Feed.open(page.url)
        
          
          feed.items.each do |item|    
              begin
          #        if (Rawstory.find_by_title(item.title) == nil) && (Rawstory.find_by_link(item.link) == nil)
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
                      
                      @author.rawstories.create(:author => @author, :title => title, :link => item.link, :feedpage => page, :source => page.source, :body => text, :opinion => opinionated, :language => language, :keywords => keywords)
             
           #       end
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
            keywords = ' ' + keywords
            if keywords != nil
            keywords=keywords.sub(' is ',' ')
            keywords=keywords.sub(' am ',' ')
            keywords=keywords.sub(' the ',' ')
            keywords=keywords.sub(' are ',' ')
            keywords=keywords.sub(' was ',' ')
            keywords=keywords.sub(' will ',' ')
            keywords=keywords.sub(' have ',' ')
            keywords=keywords.sub(' has ',' ')
            keywords=keywords.sub(' in ',' ')
            keywords=keywords.sub(' of ',' ')
            keywords=keywords.sub(' not ',' ')
            keywords=keywords.sub(' out ',' ')
            keywords=keywords.sub(' off ',' ')
            keywords=keywords.sub(' for ',' ')
            keywords=keywords.sub(' to ',' ')
            keywords=keywords.sub(' at ',' ')
            keywords=keywords.sub(' got ',' ')
            keywords=keywords.sub(' by ',' ')
            keywords=keywords.sub(' be ',' ')
            keywords=keywords.sub(' an ',' ')
            keywords=keywords.sub(' we ',' ')
            keywords=keywords.sub(' you ',' ')
            keywords=keywords.sub(' they ',' ')
            keywords=keywords.sub(' them ',' ')
            keywords=keywords.sub(' it ',' ')
            keywords=keywords.sub(' he ',' ')
            keywords=keywords.sub(' she ',' ')
            keywords=keywords.sub(' him ',' ')
            keywords=keywords.sub(' her ',' ')
            keywords=keywords.sub(' their ',' ')
            keywords=keywords.sub(' under ',' ')
            keywords=keywords.sub(' over ',' ')
            keywords=keywords.sub(' can ',' ')
            keywords=keywords.sub(' should ',' ')
            keywords=keywords.sub(' with ',' ')
            keywords=keywords.sub(' as ',' ')
            keywords=keywords.sub(' from ',' ')
            keywords=keywords.sub(' no ',' ')
            keywords=keywords.sub(' a ',' ')
            keywords=keywords.sub(' but ',' ')
            keywords=keywords.sub(' which ',' ')
            keywords=keywords.sub(' on ',' ')
            keywords=keywords.sub(' do ',' ')
            keywords=keywords.sub(' does ',' ')
            
            
            
            
          end
            return keywords
           
  end
  
  def de_find_keywords title, text

            text = title + ' ' + text
            text = text.gsub(/\W/, ' ')

            array = text.split(/\s+/)

            array = array.collect {|e| e if e.match(/[A-Z]/)}

            array = array.collect {|e| e.downcase if e != nil}
            array = array.first(40)

            position = array.inject(Hash.new(0)) {|h,x| h[x]+=1;h}
            position.delete_if {|key, value| key == nil}

            keywords = (position.keys).join(' ')

            return keywords

  end


  de_create
  
  sleep 1
  
end