#!/usr/bin/env ruby

#You might want to change this
#ENV["RAILS_ENV"] ||= "production"

require File.dirname(__FILE__) + "/../../config/environment"
require 'feed_tools'
require 'hpricot'
require 'open-uri'
require 'iconv'

$running = true;
Signal.trap("TERM") do 
  $running = false
end

  
  def read_page page_source_name, item, item_link

        if page_source_name == 'www.cnn.com' 
         doc = ''
          a= read_cnn doc, item
        end
        
        if page_source_name == 'www.reuters.com' 
         doc = ''
          a= read_reuters doc, item
        end

        if page_source_name == 'news.bbc.co.uk' 
         doc =Hpricot(open(item_link))
          a= read_bbc doc, item
        end
        
            if page_source_name == 'financialtimes.a.mms.mavenapps.net' 
             doc =Hpricot(open(item_link))
              a= read_ft doc, item
            end

            if page_source_name == 'audiovideo.economist.com' 
             doc =Hpricot(open(item_link))
              a= read_economist doc, item
            end

            if page_source_name == 'www.wsj.com' 
             doc =Hpricot(open(item_link))
              a= read_wsj doc, item
            end

            if page_source_name == 'link.brightcove.com' 
             doc =Hpricot(open(item_link))
              a= read_slatev doc, item
            end

            if page_source_name == 'feedroom.businessweek.com' 
             doc =Hpricot(open(item_link))
              a= read_bweek doc, item
            end

            if page_source_name == 'www.guardian.co.uk' 
             doc =Hpricot(open(item_link))
              a= read_guardian doc, item
            end


            if page_source_name == 'www.c-span.org' 
             doc =Hpricot(open(item_link))
              a= read_cspan doc, item
            end

            if page_source_name == 'www.youtube.com' 
             doc =Hpricot(open(item_link))
              a= read_youtube doc, item
            end

            if page_source_name == 'www.euronews.net' 
              doc =Hpricot(open(item_link))
              a= read_euronews doc, item
            end

            if page_source_name == 'www.zeit.de' 
              doc =Hpricot(open(item_link))
              a= read_zeit doc, item
            end
        

        return a
  end


  def read_cnn doc, item

    text = item.description
    text = '' if text.match('Your immediate world news headlines.')
    text = '' if text.match('Your quick and complete hourly news update.')

      unless text == ''

          text = text.sub('<p>', '+') 
          text = text.gsub("CNN's", 'CNNZEICHEN')
          text = text.gsub("CNN.com's", 'CNNZEICHEN')
          text = text.gsub("CNN Deputy Political Director", 'CNNZEICHEN')
          text = text.gsub("Showbiz Tonight's", 'CNNZEICHEN')
          text = text.gsub("ITN's", 'CNNZEICHEN')


          text = text.gsub("Dr.", ' ')
          text = text.gsub(' ', 'LUECKE1')
          text = text.gsub(',', 'LUECKE2')
          text = text.gsub('.', 'LUECKE3')
          text = text.gsub("'", 'LUECKE5')
          text = text.gsub('"', 'LUECKE6')

          text = text.gsub('+', ' ')
          text_array = text.scan(/\w+/)
          text = text_array[0]
          text = text.gsub('LUECKE1', ' ')
          text = text.gsub('LUECKE2', ',')
          text = text.gsub('LUECKE3', '.')

          text = text.gsub('LUECKE5', "'")
          text = text.gsub('LUECKE6', '"')

          text = text.downcase
          text_array = text.scan(/\w+/)
          text = ''
         text_array.each do |word|
            word_a = word.first.upcase
            word_b = word.sub(word.first, '')

            word = word_a + word_b  
            text += word + ' '
          end

      end
      author = ''
      unless text == ''
        if text.match('Cnnzeichen')
          atext = text.gsub(' ', 'LUECKE')
           atext = atext.gsub('Cnnzeichen', ' ')
          atext_array = atext.scan(/\w+/)
          atext = atext_array[1]
          atext = atext_array[0] if atext == nil
          atext = atext.gsub('LUECKE', ' ')

          atext_array = atext.scan(/\w+/)

          name_1 = atext_array[0] 
          name_2 = atext_array[1]
          author = name_1.to_s + ' ' + name_2.to_s
        end
      end

      return author, text
  end
  
  def read_reuters doc, item

    text = item.description
        unless text == nil

           text = text.sub('div class', '+') 

            text = text.gsub(' ', 'LUECKE1')
            text = text.gsub(',', 'LUECKE2')
            text = text.gsub('.', 'LUECKE3')
            text = text.gsub("'", 'LUECKE5')
            text = text.gsub('"', 'LUECKE6')
           

            text = text.gsub('+', ' ')
            text_array = text.scan(/\w+/)
            text = text_array[1]
            text = text.gsub('LUECKE1', ' ')
            text = text.gsub('LUECKE2', ',')
            text = text.gsub('LUECKE3', '.')

            text = text.gsub('LUECKE5', "'")
            text = text.gsub('LUECKE6', '"')

          text = text.downcase
          text_array = text.scan(/\w+/)
          text = ''
         text_array.each do |word|
            word_a = word.first.upcase
            word_b = word.sub(word.first, '')

            word = word_a + word_b  
            text += word + ' '
          end

      end
      author = ''


      return author, text
  end

  def read_bbc doc, item

    text = (doc/"div.storybody").inner_text

    second_paragraph = (doc/"div.storybody/p[2]").inner_text 

    if second_paragraph.match('report') or second_paragraph.match('story') 
      author = second_paragraph
    else
      author = (doc/"div.storybody/p[3]").inner_text
            
    end


        unless author == ''
          author_array = author.scan(/\w+/) 
         first_name = author_array[0]
         last_name = author_array[1]
         author = first_name + ' ' + last_name
        end

        unless text == nil

          text = text.downcase
          text_array = text.scan(/\w+/)
          text = ''
         text_array.each do |word|
            word_a = word.first.upcase
            word_b = word.sub(word.first, '')

            word = word_a + word_b  
            text += word + ' '
          end

      end
      return author, text
  end

  def read_ft doc, item

   # text = item.description
   text = item.description
     author = ''
        unless text == nil

           text = text.sub('<p>', '+') 

            text = text.gsub(' ', 'LUECKE1')
            text = text.gsub(',', 'LUECKE2')
            text = text.gsub('.', 'LUECKE3')
            text = text.gsub("'", 'LUECKE5')
            text = text.gsub('"', 'LUECKE6')
            text = text.gsub('=', 'LUECKE7')
            text = text.gsub("/", 'LUECKE8')
            text = text.gsub('_', 'LUECKE9')
            text = text.gsub(':', 'LUECKE10')
            text = text.gsub('-', 'LUECKE11')
            text = text.gsub('?', 'LUECKE12')
            text = text.gsub('(', 'LUECKE')
            text = text.gsub(')', 'LUECKE')
            text = text.gsub('&', 'LUECKE')
            text = text.gsub(';', 'LUECKE')

            text = text.gsub('+', ' ')
            text_array = text.scan(/\w+/)
            text = text_array[1]
            text = text.gsub('LUECKE1', ' ')
            text = text.gsub('LUECKE2', ',')
            text = text.gsub('LUECKE3', '.')

            text = text.gsub('LUECKE5', "'")
            text = text.gsub('LUECKE6', '"')
            text = text.gsub( 'LUECKE7','=')
            text = text.gsub( 'LUECKE8', "/")
            text = text.gsub( 'LUECKE9', '_')
            text = text.gsub( 'LUECKE10', ':')
            text = text.gsub( 'LUECKE11', '-')
            text = text.gsub( 'LUECKE12', '?')
            text = text.gsub( 'LUECKE', ' ')
            #text = text.gsub('LUECKE7', '-')

          text = text.downcase
          text_array = text.scan(/\w+/)
          text = ''
         text_array.each do |word|
            word_a = word.first.upcase
            word_b = word.sub(word.first, '')

            word = word_a + word_b  
            text += word + ' '
          end

        end


      return author, text
  end

  def read_economist doc, item

    text = item.description
      author = ''
         text = text.downcase
          text_array = text.scan(/\w+/)
          text = ''
         text_array.each do |word|
            word_a = word.first.upcase
            word_b = word.sub(word.first, '')

            word = word_a + word_b  
            text += word + ' '
          end


      return author, text
  end

  def read_wsj doc, item


    #text = item.description
     text = (doc/"#video_headline.embedContainer").inner_text

      author = ''
         text = text.downcase
          text_array = text.scan(/\w+/)
          text = ''
         text_array.each do |word|
            word_a = word.first.upcase
            word_b = word.sub(word.first, '')

            word = word_a + word_b  
            text += word + ' '
          end

      return author, text
  end

  def read_slatev doc, item

    text = item.description
    unless text == nil

       text = text.sub('/>', '+') 

        text = text.gsub(' ', 'LUECKE1')
        text = text.gsub(',', 'LUECKE2')
        text = text.gsub('.', 'LUECKE3')
        text = text.gsub("'", 'LUECKE5')
        text = text.gsub('"', 'LUECKE6')
        text = text.gsub('=', 'LUECKE7')
        text = text.gsub("/", 'LUECKE8')
        text = text.gsub('_', 'LUECKE9')
        text = text.gsub(':', 'LUECKE10')
        text = text.gsub('-', 'LUECKE11')
        text = text.gsub('?', 'LUECKE12')

        text = text.gsub('+', ' ')
        text_array = text.scan(/\w+/)
        text = text_array[1]
        text = text.gsub('LUECKE1', ' ')
        text = text.gsub('LUECKE2', ',')
        text = text.gsub('LUECKE3', '.')

        text = text.gsub('LUECKE5', "'")
        text = text.gsub('LUECKE6', '"')
        text = text.gsub( 'LUECKE7','=')
        text = text.gsub( 'LUECKE8', "/")
        text = text.gsub( 'LUECKE9', '_')
        text = text.gsub( 'LUECKE10', ':')
        text = text.gsub( 'LUECKE11', '-')
        text = text.gsub( 'LUECKE12', '?')
        #text = text.gsub('LUECKE7', '-')

      text = text.downcase
      text_array = text.scan(/\w+/)
      text = ''
     text_array.each do |word|
        word_a = word.first.upcase
        word_b = word.sub(word.first, '')

        word = word_a + word_b  
        text += word + ' '
      end


      author = ''
      end  

      return author, text
  end

  def read_bweek doc, item

    text = item.description
      author = ''
         text = text.downcase
          text_array = text.scan(/\w+/)
          text = ''
         text_array.each do |word|
            word_a = word.first.upcase
            word_b = word.sub(word.first, '')

            word = word_a + word_b  
            text += word + ' '
          end


      return author, text
  end

  def read_guardian doc, item


    #text = item.description
     text = (doc/"#stand-first").inner_text

      author = (doc/"li.credit/a[1]").inner_text
       author = (doc/"li.credit").inner_text if author == ''
         text = text.downcase
          text_array = text.scan(/\w+/)
          text = ''
         text_array.each do |word|
            word_a = word.first.upcase
            word_b = word.sub(word.first, '')

            word = word_a + word_b  
            text += word + ' '
          end

      return author, text
  end

  def read_cspan doc, item

    text = item.description
      author = ''
         unless text == nil

            text = text.sub(' br ', '+') 

             text = text.gsub(' ', 'LUECKE1')
             text = text.gsub(',', 'LUECKE2')
             text = text.gsub('.', 'LUECKE3')
             text = text.gsub("'", 'LUECKE5')
             text = text.gsub('"', 'LUECKE6')
             text = text.gsub('=', 'LUECKE7')
             text = text.gsub("/", 'LUECKE8')
             text = text.gsub('_', 'LUECKE9')
             text = text.gsub(':', 'LUECKE10')
             text = text.gsub('-', 'LUECKE11')
             text = text.gsub('?', 'LUECKE12')
             text = text.gsub('(', 'LUECKE')
             text = text.gsub(')', 'LUECKE')
             text = text.gsub('&', 'LUECKE')
             text = text.gsub(';', 'LUECKE')

             text = text.gsub('+', ' ')
             text_array = text.scan(/\w+/)
             text = text_array[0]
             text = text.gsub('LUECKE1', ' ')
             text = text.gsub('LUECKE2', ',')
             text = text.gsub('LUECKE3', '.')

             text = text.gsub('LUECKE5', "'")
             text = text.gsub('LUECKE6', '"')
             text = text.gsub( 'LUECKE7','=')
             text = text.gsub( 'LUECKE8', "/")
             text = text.gsub( 'LUECKE9', '_')
             text = text.gsub( 'LUECKE10', ':')
             text = text.gsub( 'LUECKE11', '-')
             text = text.gsub( 'LUECKE12', '?')
             text = text.gsub( 'LUECKE', ' ')
             #text = text.gsub('LUECKE7', '-')

           text = text.downcase
           text_array = text.scan(/\w+/)
           text = ''
          text_array.each do |word|
             word_a = word.first.upcase
             word_b = word.sub(word.first, '')

             word = word_a + word_b  
             text += word + ' '
           end

         end



      return author, text
  end

  def read_youtube doc, item


    #text = item.description
     text = (doc/"div.watch-video-desc").inner_text

      #author = (doc/"li.credit/a[1]").inner_text
      # author = (doc/"li.credit").inner_text if author == ''
         text = text.downcase
          text_array = text.scan(/\w+/)
          text = ''
         text_array.each do |word|
            word_a = word.first.upcase
            word_b = word.sub(word.first, '')

            word = word_a + word_b  
            text += word + ' '
          end

     author = ''
      return author, text
  end

  def read_euronews doc, item
  text = (doc/"#article-text/p").inner_text
  author = ''
  return author, text
  end

  def read_zeit doc, item

    text = item.description
      author = ''
         text = text.downcase
          text_array = text.scan(/\w+/)
          text = ''
         text_array.each do |word|
            word_a = word.first.upcase
            word_b = word.sub(word.first, '')

            word = word_a + word_b  
            text += word + ' '
          end


      return author, text
  end




  def video_create
    Eintrag.create(:name => 'Video crawling started') 
    starting_time = Time.new

      @uncrawled_stories = []  
      #language = 1
      @feedpages = Feedpage.find(:all, :conditions => 'Active = 1')  
      #@feedpages = @feedpages.find_all{|l| l.language == 1 }
      @feedpages = @feedpages.find_all{|l| l.video == true }
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
             
                      
                      author, text, title, opinionated = read_page page.source.name, item, item.link
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
                  @story.language = page.language
                  @story.keywords = keywords
                  @story.video = 1
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
      Eintrag.create(:name => 'Video crawling completed', :duration => duration) 
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
            position.delete_if {|key, value| key.size < 3}
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
            keywords=keywords.sub(' and ',' ')
            keywords=keywords.sub(' what ',' ')
            keywords=keywords.sub(' like ',' ')
            keywords=keywords.sub(' about ',' ')
            keywords=keywords.sub(' who ',' ')
            keywords=keywords.sub(' that ',' ')
            keywords=keywords.sub(' cnnzeichen ',' ')
            keywords=keywords.sub(' cnnzeichen',' ')
            

          end
            return keywords

  end

while($running) do
  video_create
  sleep 300
end

