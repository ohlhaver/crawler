#!/usr/bin/env ruby

#You might want to change this
#ENV["RAILS_ENV"] ||= "production"

require File.dirname(__FILE__) + "/../../config/environment"
require 'rubygems' 
require 'feed_tools'
require 'hpricot'
require 'rubygems/open-uri'
require 'iconv' 
require 'authors_api'
require 'fix_urls'



$running = true;
$timeout_in_seconds = 4
Signal.trap("TERM") do 
  $running = false
end


    
  def read_page page_source_name, item_link
         

         
         
      if page_source_name == 'www.11freunde.de'
       f = open(item_link, :read_timeout => $timeout_in_seconds)
       f.rewind
       doc = Hpricot(Iconv.conv('utf-8', f.charset, f.readlines.join("\n")))
       a= read_11freunde doc
      end
  
      if page_source_name == 'www.kicker.de'
        f = open(item_link, :read_timeout => $timeout_in_seconds)
        f.rewind
        doc = Hpricot(Iconv.conv('utf-8', f.charset, f.readlines.join("\n")))
        a= read_kicker doc
      end
  
      if page_source_name == 'www.fr-online.de'
        f = open(item_link, :read_timeout => $timeout_in_seconds)
        f.rewind
        doc = Hpricot(Iconv.conv('utf-8', f.charset, f.readlines.join("\n")))
        a= read_rundschau doc
      end
  
      if page_source_name == 'www.handelsblatt.com'
       f = open(item_link, :read_timeout => $timeout_in_seconds)
         f.rewind
      doc = Hpricot(Iconv.conv('utf-8', f.charset, f.readlines.join("\n")))
        a= read_handelsblatt doc
      end
      
      if page_source_name == 'www.tagesspiegel.de'
         f = open(item_link, :read_timeout => $timeout_in_seconds)
         f.rewind
        doc = Hpricot(Iconv.conv('utf-8', f.charset, f.readlines.join("\n")))
         a= read_tagesspiegel doc
      end
         
      if page_source_name == 'diepresse.com' 
       doc =Hpricot(open(item_link, :read_timeout => $timeout_in_seconds))
        a= read_diepresse doc
      end

      if page_source_name == 'www.cicero.de Blogs' 
          f = open(item_link, :read_timeout => $timeout_in_seconds)
          f.rewind
          doc = Hpricot(Iconv.conv('utf-8', f.charset, f.readlines.join("\n")))
          a= read_cicero_blogs doc
      end
 
      if page_source_name == 'www.cicero.de' 
          f = open(item_link, :read_timeout => $timeout_in_seconds)
          f.rewind
          doc = Hpricot(Iconv.conv('utf-8', f.charset, f.readlines.join("\n")))
          a= read_cicero doc
      end

      if page_source_name == 'derstandard.at' 
          doc =Hpricot(open(item_link, :read_timeout => $timeout_in_seconds))
          a= read_derstandard doc
      end

      if page_source_name == 'bazonline.ch'
          doc =Hpricot(open(item_link, :read_timeout => $timeout_in_seconds))
          a= read_baz doc
      end

      if page_source_name == 'www.ftd.de' 
          f = open(item_link, :read_timeout => $timeout_in_seconds)
          f.rewind
          doc = Hpricot(Iconv.conv('utf-8', f.charset, f.readlines.join("\n")))
          a= read_ftd doc
      end
          
      if page_source_name == 'www.spiegel.de' 
          f = open(item_link, :read_timeout => $timeout_in_seconds)
          f.rewind
          doc = Hpricot(Iconv.conv('utf-8', f.charset, f.readlines.join("\n")))
          a= read_spiegel doc
      end
      
      if page_source_name == 'www.faz.net'
            doc =Hpricot(open(item_link, :read_timeout => $timeout_in_seconds))
            a= read_faz doc
      end
      
      if page_source_name == 'www.nzz.ch' 
          doc =Hpricot(open(item_link, :read_timeout => $timeout_in_seconds))
          a= read_nzz doc
      end
            
      if page_source_name == 'www.zeit.de'
            f = open(item_link, :read_timeout => $timeout_in_seconds)
            f.rewind
            doc = Hpricot(Iconv.conv('utf-8', f.charset, f.readlines.join("\n")))
            a= read_zeit doc
      end
       
      if page_source_name == 'www.sueddeutsche.de'
            f = open(item_link, :read_timeout => $timeout_in_seconds)
            f.rewind
            doc = Hpricot(Iconv.conv('utf-8', f.charset, f.readlines.join("\n")))
            a= read_sueddeutsche doc 
      end
      
      if page_source_name == 'www.welt.de'
            f = open(item_link, :read_timeout => $timeout_in_seconds)
            f.rewind
            doc = Hpricot(Iconv.conv('utf-8', f.charset, f.readlines.join("\n")))
            a= read_welt doc 
      end
      
      if page_source_name == 'www.taz.de'
            doc =Hpricot(open(item_link, :read_timeout => $timeout_in_seconds))
            a= read_taz doc
      end
      
       a = a.to_a
       a[0] = AuthorsApi.sanitize_author_name(a[0])
  
      return a
  end

  def read_spiegel doc
    
        title = (doc/"#spMainContent/h2").inner_html  

        roof = (doc/"#spMainContent/h1").inner_html
        roof = '' if roof == nil
        #if roof != nil
        #roof = roof.downcase
        #roof = roof.gsub('Ä','ä')
        #roof = roof.gsub('Ö','ö')
        #roof = roof.gsub('Ü','ü')
        #roof_array = roof.scan(/\w+/)
        #roof = ''
        #roof_array.each do |word|
        #   word_a = word.first.upcase
        #   word_b = word.sub(word.first, '')

        #   word = word_a + word_b  
        #   roof += ' ' + word
           
        # end  
        # roof = roof.sub(' ', '')   
      #  end
      #   title = roof +': ' + title if roof != ''
                            
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
          author = author.gsub('von ', '+')
          
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

     image_url = nil
     d         = (doc/"#spArticleBody div.spArticleImageBox img")
     image_url = d.first.attributes['src'] unless d.blank?

         doc = (doc/"#spArticleBody/p")
         
         (doc/"div.spAsset").remove
         (doc/"div.spArticleImageBox").remove
         (doc/"div.spPhotoGallery").remove
         (doc/"div.spAssetInner").remove
         (doc/"div.spTagbox").remove
         (doc/"div.spCommentBox").remove

         text = doc.inner_text
         text = intro + ' ' + text + ' ' + roof

         return author, text, title, nil, image_url
  end


  def read_handelsblatt doc
      roof_title = (doc/"span.headline").inner_text
      title = (doc/"div.cnArticle/h2").inner_text
      title = roof_title + ': ' + title if roof_title != ''
      title = title.sub(' ','') if title.first == ' '
      author = (doc/"div.cnArticle/cite").inner_text
      unless author == nil or author == ''
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
      
      image_url = nil
       d         = (doc/"#content div.imageBox img")  
      image_url = d.first.attributes['src'] unless d.blank?
      
      doc = (doc/"div.text")     
      text = doc.inner_text

      return author, text, title, nil, image_url
  end
  
  def read_tagesspiegel doc
     author = (doc/"a.ISI_IGNORE[1]").inner_html
     
     unless author == nil or author == ''
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
     end
     image_url = nil
      d         = (doc/"#thumbbig.ISI_IGNORE span.ISI_IGNORE img")  
     image_url = d.first.attributes['src'] unless d.blank?
     image_url = 'http://www.tagesspiegel.de' + image_url unless image_url == nil
     image_url = nil if image_url == 'http://www.tagesspiegel.de/pics/icon_lupe.gif'
     
     return author, text, nil, nil, image_url
  end
 
  def read_faz doc
       author = (doc/"p.Author/a").inner_html
       author = (doc/"p.Author").inner_html if author == ''
        unless author == nil or author == ''
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

        image_url = nil
         d         = (doc/"#MainColumn div.ArticleImgLeft img")
         image_url = d.first.attributes['src'] unless d.blank?
         if image_url == nil
           d         = (doc/"#MedContent_quelle div.ArticleImgLarge img") 
           image_url = d.first.attributes['src'] unless d.blank?
         end



         image_url = 'http://www.faz.net' + image_url unless image_url == nil

        doc = (doc/"div.Article/p")
        (doc/"span.Italic").remove
        text = doc.inner_text
        return author, text, nil, nil, image_url
  end
  
  def read_sueddeutsche doc

       roof_title = (doc/"h2.artikelDachzeile").inner_text
       #title = (doc/"h1.artikelTitel").inner_text
       #title = roof_title + ': ' + title
       author = (doc/"td/p/cite").inner_text
       unless author.empty?
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
           author = author.sub('Interview von ', '+')
           author = author.sub('Eine Reportage von ', '+')


           author = author.gsub('Von ', '+')
           author = author.gsub(' und ', '+')
           author = author.gsub(',', '+')
           author = author.gsub('-', '2')
           author = author.gsub('.', '1')
           author = author.gsub(' ', '0')
           author = author.gsub('+', ' ')
           author = author.gsub('ä', '3')
           author = author.gsub('ü', '4')
           author = author.gsub('ö', '5')
           author = author.gsub('á', '6')
           author_array = author.scan(/\w+/)
           author = author_array[0]
           author = author.gsub('0', ' ')
           author = author.gsub('1', '.')
           author = author.gsub('2', '-')
           author = author.gsub('3', 'ä')
           author = author.gsub('4', 'ü')
           author = author.gsub('5', 'ö')
           author = author.gsub('6', 'á')

       end
       intro = (doc/"p.artikelTeaser").inner_text


       text =(doc/"div.main/p").inner_text
       text =(doc/"p.artikelFliestext").inner_text if text == ''

       text = intro + ' ' + text

       image_url = nil
        d         = (doc/"#contentTable.content div.photo img")
        image_url = d.first.attributes['src'] unless d.blank?

       return author, text, nil, nil, image_url
  end
   
  def read_zeit doc
     roof_title = (doc/"div.articletext/h3").inner_text
     title = (doc/"div.articletext/h2").inner_text
     title = roof_title + ': ' + title if roof_title != ''

     author = (doc/"cite.author").inner_html
     author_array = author.split(/\|/)
     author = author_array.first.sub('Von ', '') unless author_array.first == nil 
     author = author.chop

     image_url = nil
     d         = (doc/"#content div.image_full img")
     image_url = d.first.attributes['src'] unless d.blank?

     doc = (doc/"div.articlebody/p")
     text = doc.inner_text


     return author, text ,title, nil, image_url
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

          image_url = nil
          d         = (doc/"#article div.article img")
          image_url = d.first.attributes['src'] unless d.blank?
          image_url = 'http://www.nzz.ch' + image_url unless image_url == nil
          image_url = nil if image_url == 'http://www.nzz.ch/static-images/pixel.gif'

      intro = (doc/"div.body/h5").inner_text  
      doc = (doc/"div.body/p")
      text = doc.inner_text
      text = intro + ' ' + text
      title = nil
      return author, text , title, opinionated, image_url
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

     image_url = nil
     d         = (doc/"#contentContainer div.articleBox img")
     image_url = d.first.attributes['src'] unless d.blank?
     image_url = nil if image_url == 'http://www.welt.de/images/bg_barometer.gif' 

     doc = (doc/"div.articleBox/p")  
     text = doc.inner_text
       return author, text, nil, nil, image_url
  end
  
  def read_ftd doc

      roof_title = (doc/"h1.dach").inner_text
      title = (doc/"h2.artikelhead").inner_text
      title = roof_title + ': ' + title if roof_title != '' 
      title = title.sub('Dossier ', '')
      author = (doc/"h4.bot").inner_text

      unless author == nil or author == ''
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

     author = (doc/"a[4]/b").inner_text if author == ''
     author = author.sub('Von ', '') unless author == nil

      image_url = nil
        d         = (doc/"#objectContent.artikel div.artikelLeft img")
        image_url = d.first.attributes['src'] unless d.blank?


       intro = (doc/"#artikelBody/h2")
       doc = (doc/"#artikelBody/p")
       text = intro.inner_text + " " + doc.inner_text
       return author, text, nil, nil, image_url
  end
   
  def read_diepresse doc
       author = (doc/"p.articletime").inner_html
       unless author == nil or author == ''
         author = author.gsub('|', '+')
         author = author.gsub('(', '+')
         author = author.gsub(' ', '0')
         author = author.gsub('+', ' ')
         author_array = author.scan(/\w+/)
         author = author_array[7]
         author = author.gsub('0', ' ')
         author = '' if author == 'DiePresse'
         author = '' if author == 'Die Presse'
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
         author = author_array[0] if author_array[0] != nil
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

       image_url = nil
       d         = (doc/"#content div.articlecontent a")
       #/html/body/div[5]/div/div[5]/div[2]/div/div/div/div/a
       image_url = d.first.attributes['href'] unless d.blank?
       image_url = 'http://www.diepresse.com' + image_url unless image_url == nil

       intro = (doc/"p.articlelead/strong").inner_text  
       doc = (doc/"div.articletext/p")
       text = doc.inner_text
       text = intro + ' ' + text
       return author, text, nil, nil, image_url
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

            image_url = nil
             d         = (doc/"#artikel.artikel div.artikel_main/a img")  
            image_url = d.first.attributes['src'] unless d.blank?
            image_url = 'http://taz.de' + image_url unless image_url == nil


           doc = (doc/"p.artikeltext")
           text = doc.inner_text
           text = intro + ' ' + text
           return author, text, nil, nil, image_url
  end
 
  def read_cicero_blogs doc


      title = (doc/"td.header").inner_text

      author = (doc/"div[2]/table[5]/tr[2]").inner_text

      author = author.sub('von ', '') unless author == nil

      image_url = nil
       d         = (doc/"#rc table[3] img")  
       #/html/body/div[2]/div/div[3]/table[3]/tbody/tr/td/img
      image_url = d.first.attributes['src'] unless d.blank?
      image_url = image_url.sub('../../..','')
      image_url = 'http://www.cicero.de' + image_url unless image_url == nil

      doc = (doc/"table[6]")
      text = doc.inner_text

      text = text.sub('Dieses Video ist in Zusammenarbeit mit unserem Kooperationspartner politik.de entstanden.', '' )

      return author, text, title, nil, image_url
  end

  def read_cicero doc
      title = (doc/"span.header").inner_text
      author = (doc/"span.red[2]").inner_html
      author = author.sub('von ', '') unless author == nil
      #intro = (doc/"span.boldRed").inner_text
      image_url = nil
       d         = (doc/"#mainmitrc table[5] img")  
      image_url = d.first.attributes['src'] unless d.blank?
      image_url = image_url.sub('../../..','')
      image_url = 'http://www.cicero.de' + image_url unless image_url == nil

      doc = (doc/"table[5]")
      text = doc.inner_text
      text = text.sub('Kolumnen', '' )
      return author, text, title, nil, image_url
  end

  def read_rundschau doc
         #roof_title = (doc/"span.dz").inner_text
         #title = (doc/"h2.hz").inner_text
         #title = roof_title + ': ' + title if roof_title != ''
         author = (doc/"div.az").inner_text
         unless author == nil or author == ''
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

          image_url = nil
           d         = (doc/"#em_body a.media_content_link img")  
          image_url = d.first.attributes['src'] unless d.blank?
          image_url = 'http://www.fr-online.de' + image_url unless image_url == nil


              doc = (doc/"div.text")
         text = doc.inner_text
         #if title.match('Seite nicht gefunden')
         #    text = ''
         #    title = ''
         #    author = ''
         #end
         return author, text, nil, nil, image_url
  end

  def read_11freunde doc
      roof_title = (doc/"span.orgType").inner_text
      title = (doc/"div[2]/h1/a").inner_text
      title = title.sub('SCHLAGZEILEN' ,'')

      title = roof_title + ': ' + title
      author = (doc/"span.info[2]").inner_text
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

      image_url = nil
       d         = (doc/"#main div.col1_content img")  
      image_url = d.first.attributes['src'] unless d.blank?

      intro = (doc/"div.col1_content/p/strong").inner_text
      #doc_2 = (doc/"div[2]/p[3]")
      #doc = (doc/"div.col1_content/p")
      text = (doc/"div.col1_content/p[4]").inner_text

     # if text == ''
    #      text_2 = doc_2.inner_text
    #  else
     #     text_2 = ''
    #  end

      text = intro + ' ' + text
      text = text.sub('---News, Interviews, Blogs, Statistiken und Service zu:', '') 
      return author, text, title, nil, image_url
  end
  
  def read_kicker doc
      roof_title = (doc/"p.topline").inner_text
      roof_title = roof_title.gsub(':', '')
      title = (doc/"h1").inner_text
      title = roof_title + ': ' + title
      title = title.sub('Hintergrundreport', '')
      author = ''
      image_url = nil
       d         = (doc/"#art div.img-l img")  
      image_url = d.first.attributes['src'] unless d.blank?
      
      doc = (doc/"#art/p")
      text = doc.inner_text
      text = text.sub(roof_title, '')
      return author, text, title, nil, image_url
  end
 

  def de_create
      Eintrag.create(:name => 'German crawling started') 
      starting_time = Time.new

        language = 2
        @uncrawled_stories = []  

        @feedpages = Feedpage.find(:all, :conditions => 'Active = 1')  
        @feedpages = @feedpages.find_all{|l| l.language == 2 }
        @feedpages = @feedpages.find_all{|l| l.video != true }
        #feedpage_ids       = @feedpages.collect{|f| f.id}.uniq*","
        #unless feedpage_ids.blank?
        #  stories            = Rawstory.find(:all,
        #                                     :conditions => ["feedpage_id IN ( #{feedpage_ids})"],
        #                                     :select     => 'id, feedpage_id')
        #  stories_hashed     = stories.group_by{|s| s.feedpage_id} 
        #end

        @feedpages.each do |page| 
          begin
           last_story_at = nil
           new_stories = 0
           feed = FeedTools::Feed.open(page.url, :http_timeout => $timeout_in_seconds)


            feed.items.each do |item|    
                begin
                  #  if (Rawstory.find_by_title(item.title) == nil) && (Rawstory.find_by_link(item.link) == nil)
                        @story = Rawstory.create(:link => item.link)
                    
                        author, text, title, opinionated, image_url,doc_url = read_page page.source.name, item.link
                        title = item.title if title == nil
                        author = '' if author == nil
                        text = text + ' ' + author
                        unless image_url.blank?
                          image_url = FixUrls.get_absolute_url(image_url, (doc_url || item.link))
                          si = StoryImage.create!(:baseurl => image_url, :source_id => page.source_id)
                          RawstoriesStoryImage.create!(:rawstory_id => @story.id, :story_image_id => si.id)
                        end
 
                        title = title.gsub('Ã¼','ü')
                        title = title.gsub('Ã¤','ä')
                        title = title.gsub(' Ã',' Ä')     
                        title = title.gsub('Ã','ß')
                        title = title.gsub('ß¶','ö')
                        
                        author = author.gsub('Ã¼','ü')
                        author = author.gsub('Ã¤','ä')
                        author = author.gsub(' Ã',' Ä')
                        author = author.gsub('Ã','ß')
                        author = author.gsub('ß¶','ö')

                       keywords = de_find_keywords title, text 
                       quality = page.quality
                       @author = Author.find_by_name(author, :include => [:subscriptions])
                       if @author.nil?
                           @author = Author.create!(:name => author)
                       else
                           quality = 4 if @author.subscriptions.size > 5
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
                       last_story_at = Time.now
                       @story.save    
                       new_stories += 1

                       # Save quality and subscription details
                       RawstoryDetail.create!(:rawstory_id => @story.id, 
                                              :subscription_type => page.subscription_type,
                                              :quality => quality)

                    #end
                    rescue Timeout::Error => e
                      raise e
                    rescue Exception => e
                    #@uncrawled_stories = @uncrawled_stories + [item] 

                end  
            end  
           page.source.update_attributes(:last_story_at => last_story_at) if last_story_at
           if new_stories > 0
            page.previous_size = page.story_count
            page.story_count  += new_stories
           end
           page.last_story_at = last_story_at if last_story_at
           page.save if new_stories > 0 or last_story_at

         rescue Exception => e
            next
         end
        end
        finishing_time = Time.new
        duration = (finishing_time - starting_time)/60
        Eintrag.create(:name => 'German crawling completed', :duration => duration) 
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


while($running) do
  de_create
  sleep 1
end

