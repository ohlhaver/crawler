require 'rubygems'
require 'text'

class AuthorsApi
  class << self
    @@dissimilarity_threshold = 0.2
    def sanitize_author_name(line)
      ## Generic Clean UP 
      return "" if line.nil?
      list_of_non_names = [' Jan ',' Feb ', ' Mar ', ' Apr ', ' May ', ' Jun ', ' Jul ', ' Aug ', ' Sep ', ' Oct ',' Nov ', ' Dec ', ' am ', ' pm ',' Ist', ' Am ', ' Pm ', 'year', 'Cent', '-', '..', '/', "Hrs", "hrs", 'By ']
      line.chomp
      without_spaces_tabs = line.gsub(/\\n/,"").gsub(/\\t/,"").gsub(/\r/,"").gsub(/\^M/,'').strip
      without_html_tags = (without_spaces_tabs.gsub(/\/byline$/,"/byline>").gsub(%r{</?[^>]+?>}, ''))
      without_html_tags = ""  if without_html_tags.nil?
      list_of_non_names.each{|elem|
        without_html_tags = without_html_tags.gsub(elem,"") 
      }
      without_numbers = without_html_tags.gsub(/[0-9]/,"").strip
      without_numbers = ""  if without_numbers.nil?
      without_numbers
      #with_new_line = without_numbers + "\n" 
    end
    
    def generate_author_group_suggestions
      last_name_groups = {}
      all_pending_authors = Author.find(:all, :conditions => ["approval_status=?",JConst::AuthorStatus::SUGGESTION_PENDING])
      puts "Fetching all authors from db complete "
      all_pending_authors.each{|author|
        temp = author.name.split(" ")[-1] 
        unless temp.nil?
          last_name_groups[temp] = Array.new if last_name_groups[temp].nil?
          last_name_groups[temp].push(author)
        end
      }
      ## Here we have all the unique categories, where we will put all our authors.
      puts "Last name grouping complete"
      puts "Number of Unique Categories = " + last_name_groups.length.to_s
      ## Now last_name_groups are ready for levenshtein based similarity refinement.
      levenshtein_refined_groups = {}
      last_name_groups.each{|key,val|
        if (val.length > 1)
          get_groups(key,val).each{|cat,authors|
             levenshtein_refined_groups[cat]=Array.new
             authors.each{|auth|
               levenshtein_refined_groups[cat].push(auth)
             }
           }
        end 
      }
      puts "Levenstein grouping complete : Writing Groups To database"
      @count_levenshtein_groups = 0 
      ## Now we have our levenshtein_refined_groups ready. Next we save it in DB :)
      levenshtein_refined_groups.each{|key,val|
         if(val.length > 1) 
           #puts "Category : " + key
           uniq_auth = UniqueAuthor.new({:name => val[0].name,:opinionated => val[0].opinionated})
           uniq_auth.save
           val.each{|author|
              #puts "   " + author.name
              auth_map = AuthorMap.new({:author_id => author.id, :unique_author_id => uniq_auth.id, :status => JConst::AuthorMapStatus::UNAPPROVED})
              auth_map.save
              author.approval_status = JConst::AuthorStatus::APPROVAL_PENDING
           } 
           @count_levenshtein_groups = @count_levenshtein_groups + 1 
         else
           uniq_auth = UniqueAuthor.new({:name => val[0].name,:opinionated => val[0].opinionated})
           uniq_auth.save
		   auth_map = AuthorMap.new({:author_id => val[0].id, :unique_author_id => uniq_auth.id, :status => JConst::AuthorMapStatus::APPROVED})
           auth_map.save
           val[0].approval_status = JConst::AuthorStatus::APPROVED
         end
      }
      puts "Database updated. " + @count_levenshtein_groups.to_s + " new suggestions generated"
      return 0
    end
    
    private
    
    def get_dissimilarity(a,b)
       (Text::Levenshtein.distance(a,b) / [a.length, b.length].max.to_f)
    end
 
    def get_groups(category,author_array)
      flag = Array.new
      refined_groups = {}
      author_array.each{|e| flag.push(0)} ## initialize the flag for marking visited authors
 
      (0..author_array.length-1).each{|i|
        if(flag[i]==0) 
          author_x = author_array[i]
          refined_groups[author_x.name] = Array.[](author_x) 
          flag[i] = 1 
          (0..author_array.length-1).each{|j|
            author_y = author_array[j]
            a = author_x.name.gsub(category, "") 
            b = author_y.name.gsub(category, "") 
            if(flag[j]==0 && (get_dissimilarity(a,b) < @@dissimilarity_threshold ) ) 
              refined_groups[author_x.name].push(author_y)
              flag[j] = 1 
            end
          }   
        end 
      }
      refined_groups
    end

  end
end
