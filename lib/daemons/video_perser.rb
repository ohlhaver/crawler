#!/usr/bin/env ruby

#You might want to change this
#ENV["RAILS_ENV"] ||= "production"

require File.dirname(__FILE__) + "/../../config/environment"

$running = true;
Signal.trap("TERM") do 
  $running = false
end

while($running) do
  
  def read_page page_source_name, item

        if page_source_name == 'www.cnn.com' 
         doc = ''
          a= read_cnn doc, item
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


  def video_create
    Eintrag.create(:name => 'Video crawling started') 
    starting_time = Time.new

      require 'rubygems'
      require 'feed_tools'
      @uncrawled_stories = []  
      language = 1
      @feedpages = Feedpage.find(:all, :conditions => 'Active = 1')  
      @feedpages = @feedpages.find_all{|l| l.language == 1 }
      @feedpages = @feedpages.find_all{|l| l.video == true }


      @feedpages.each do |page| 
         stories_to_check = page.rawstories #.find_all{|r| r.created_at > (Time.now - 1000000)}
          page.previous_size = page.rawstories.size
          page.save
          feed = FeedTools::Feed.open(page.url)


          feed.items.each do |item|    
              begin
                #if stories_to_check.find_all{|l| l.title == item.title} == []
                 # if stories_to_check.find_all{|l| l.link == item.link} == []
                 # if (Rawstory.find_by_title(item.title) == nil) && (Rawstory.find_by_link(item.link) == nil)
             
                      
                      @story = Rawstory.create(:link => item.link)
             
                      
                      author, text, title, opinionated = read_page page.source.name, item
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
video_create
sleep 300
end