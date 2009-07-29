require 'rubygems'
require 'text'

class AuthorsApi
  class << self
    @@dissimilarity_threshold = 0.3
    def sanitize_author_name(line)
      ## Generic Clean UP 
      return "" if line.nil?
      list_of_non_names = ['January', 'February', 'March','April','May','June','July','August','September','October','November','December', ' Jan ',' Feb ', ' Mar ', ' Apr ', ' Jun ', ' Jul ', ' Aug ', ' Sep ', ' Oct ',' Nov ', ' Dec ', ' am ', ' pm ',' Ist', ' Am ', ' Pm ', 'year', 'Cent', '-', '..', '/', "Hrs", "hrs", 'By ']
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

    def simple_last_name_grouping
      last_name_groups = {}
      all_pending_authors = Author.find(:all, :conditions => ["approval_status=?",JConst::AuthorStatus::SUGGESTION_PENDING])
 
      if all_pending_authors.length == 0
         puts "No new authors found "
         return 0
      end
     
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
      @count_last_name_suggestions = 0
      last_name_groups.each{|key,val|
         if(val.length > 1) 
           #puts "Category : " + key
           uniq_auth = UniqueAuthor.new({:name => val[0].name,:opinionated => val[0].opinionated})
           uniq_auth.save!
           val.each{|author|
              #puts "   " + author.name
              auth_map = AuthorMap.new({:author_id => author.id, :unique_author_id => uniq_auth.id, :status => JConst::AuthorMapStatus::UNAPPROVED})
              auth_map.save!
              author.approval_status = JConst::AuthorStatus::APPROVAL_PENDING
           } 
           @count_last_name_suggestions = @count_last_name_suggestions + 1
         else
           uniq_auth = UniqueAuthor.new({:name => val[0].name,:opinionated => val[0].opinionated})
           uniq_auth.save!
		   auth_map = AuthorMap.new({:author_id => val[0].id, :unique_author_id => uniq_auth.id, :status => JConst::AuthorMapStatus::APPROVED})
           auth_map.save!
           val[0].approval_status = JConst::AuthorStatus::APPROVED
           #val[0].save!
         end
      }
      @count_unconsidered_authors = 0
      all_pending_authors.each{|author|
		  if author.approval_status == JConst::AuthorStatus::SUGGESTION_PENDING
		 #   #author.approval_status = JConst::AuthorStatus::APPROVAL_PENDING 
		    @count_unconsidered_authors = @count_unconsidered_authors + 1 
            puts author.name
          end
		 author.save
      }
      puts @count_unconsidered_authors
      puts "Database updated. " + @count_last_name_suggestions.to_s + " new suggestions generated"
      return 0
    end
      
    def simple_last_name_grouping_variant
      puts "This method will search the last name through out the span of authors name"
      last_name_groups = {}
      all_pending_authors = Author.find(:all, :conditions => ["approval_status=?",JConst::AuthorStatus::SUGGESTION_PENDING])
 
      if all_pending_authors.length == 0
         puts "No new authors found "
         return 0
      end
     
      puts "Fetching all authors from db complete "
      all_pending_authors.each{|author|
        temp = author.name.split(" ")[-1] 
        unless temp.nil?
          last_name_groups[temp] = Array.new if last_name_groups[temp].nil?
          last_name_groups[temp].push(author) 
        end
      }
      all_pending_authors.each{|author|
        author.name.split(" ").each{|partial_name|
          unless last_name_groups[partial_name].nil?
            last_name_groups[partial_name].push(author) unless last_name_groups[partial_name].map{|x| x.name}.include?(author.name)
          end
        }
      }

      #last_name_groups.each{|key,val|
      #   val = val.uniq
      #}
      # Here we have all the unique categories, where we will put all our authors.
      puts "Last name grouping complete"
      puts "Number of Unique Categories = " + last_name_groups.length.to_s
      ## Now last_name_groups are ready for levenshtein based similarity refinement.
      @count_last_name_suggestions = 0
      last_name_groups.each{|key,val|
         if(val.length > 1) 
           #puts "Category : " + key
           uniq_auth = UniqueAuthor.new({:name => val[0].name,:opinionated => val[0].opinionated})
           uniq_auth.save!
           val.each{|author|
              #puts "   " + author.name
              auth_map = AuthorMap.new({:author_id => author.id, :unique_author_id => uniq_auth.id, :status => JConst::AuthorMapStatus::UNAPPROVED})
              auth_map.save!
              author.approval_status = JConst::AuthorStatus::APPROVAL_PENDING
           } 
           @count_last_name_suggestions = @count_last_name_suggestions + 1
         else
           uniq_auth = UniqueAuthor.new({:name => val[0].name,:opinionated => val[0].opinionated})
           uniq_auth.save!
		   auth_map = AuthorMap.new({:author_id => val[0].id, :unique_author_id => uniq_auth.id, :status => JConst::AuthorMapStatus::APPROVED})
           auth_map.save!
           val[0].approval_status = JConst::AuthorStatus::APPROVED
           #val[0].save!
         end
      }
      @count_unconsidered_authors = 0
      all_pending_authors.each{|author|
		  if author.approval_status == JConst::AuthorStatus::SUGGESTION_PENDING
		 #   #author.approval_status = JConst::AuthorStatus::APPROVAL_PENDING 
		    @count_unconsidered_authors = @count_unconsidered_authors + 1 
            puts author.name
          end
		 author.save
      }
      puts @count_unconsidered_authors
      puts "Database updated. " + @count_last_name_suggestions.to_s + " new suggestions generated"
      return 0
    end

   
    def enhanced_levenshtein_grouping
      puts "Enhances levenshtein grouping, by trying to find out more similar author name results from db"
      last_name_groups = {}
      all_pending_authors = Author.find(:all, :conditions => ["approval_status=?",JConst::AuthorStatus::SUGGESTION_PENDING])
 
      if all_pending_authors.length == 0
         puts "No new authors found "
         return 0
      end
     
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
      pending_unique_authors = []
      min_length_group = {}
      last_name_groups.each{|key,val|
        if (val.length > 1)
          get_groups(key,val).each{|cat,authors|
             levenshtein_refined_groups[cat]=Array.new
             authors.each{|auth|
               levenshtein_refined_groups[cat].push(auth)
               if min_length_group[cat].nil?
                  min_length_group[cat]=auth
               else
                  min_length_group[cat] = auth if min_length_group[cat].name.length > auth.name.length
               end
             }
           }
        end 
      }
  
      puts "Levenstein grouping complete : "
      db_similarity_groups = {}
      min_length_group.each{|key,val|
         #puts "select * from authors where name like '%#{val.name}%'"
         db_similarity_groups[val.id] = Author.find_by_sql("select * from authors where name like '%#{val.name}%'")
      }
      puts "DB Similarity grouping complete : Writing Groups To database"
      @count_levenshtein_groups = 0 
      ## Now we have our levenshtein_refined_groups ready. Next we save it in DB :)
      db_similarity_groups.each{|key,val|
         if(val.length > 1) 
           #puts "Category : " + key
           uniq_auth = UniqueAuthor.new({:name => val[0].name,:opinionated => val[0].opinionated})
           uniq_auth.save!
           val.each{|author|
              #puts "   " + author.name
              auth_map = AuthorMap.new({:author_id => author.id, :unique_author_id => uniq_auth.id, :status => JConst::AuthorMapStatus::UNAPPROVED})
              auth_map.save!
              author.approval_status = JConst::AuthorStatus::APPROVAL_PENDING
              author.save
           } 
           @count_levenshtein_groups = @count_levenshtein_groups + 1 
         end
      }
      puts "Check" 
      all_pending_authors.each{|author|
         if !author.name.strip.empty? && author.approval_status == JConst::AuthorStatus::SUGGESTION_PENDING
           uniq_auth = UniqueAuthor.new({:name => author.name,:opinionated => author.opinionated})
           uniq_auth.save!
		   auth_map = AuthorMap.new({:author_id => author.id, :unique_author_id => uniq_auth.id, :status => JConst::AuthorMapStatus::APPROVED})
           auth_map.save!
           author.approval_status = JConst::AuthorStatus::APPROVED
           author.save
         end
      }

     # puts all_pending_authors.length 
     # @count_unconsidered_authors = 0
     # all_pending_authors.each{|author|
	 #     if author.approval_status == JConst::AuthorStatus::SUGGESTION_PENDING
	 #    #   #author.approval_status = JConst::AuthorStatus::APPROVAL_PENDING 
	 #       @count_unconsidered_authors = @count_unconsidered_authors + 1 
     #       puts author.name
     #     end
	 #    author.save
     # }
      puts "Database updated. " + @count_levenshtein_groups.to_s + " new suggestions generated"
      return 0
    end

    def subscription_based_grouping
       all_subscribed_authors = Author.find_by_sql("select * from authors where id in (select distinct author_id from subscriptions)")
       if all_subscribed_authors.length == 0
         puts "No new subscribed authors found "
         return 0
       end
      puts "These many subscription authors : #{all_subscribed_authors.length}"
      all_pending_authors = Author.find(:all)
      db_similarity_groups = {}
      all_subscribed_authors.each{|author|
         #puts "select * from authors where name like '%#{val.name}%'"
         db_similarity_groups[author.name] = Author.find_by_sql("select * from authors where name like '%#{author.name}%'")
      }
      puts "DB Similarity grouping complete : Writing Groups To database"
      @count_levenshtein_groups = 0 
      ## Now we have our levenshtein_refined_groups ready. Next we save it in DB :)
      db_similarity_groups.each{|key,val|
         if(val.length > 1) 
           #puts "Category : " + key
           uniq_auth = UniqueAuthor.new({:name => val[0].name,:opinionated => val[0].opinionated})
           uniq_auth.save!
           val.each{|author|
              #puts "   " + author.name
              auth_map = AuthorMap.new({:author_id => author.id, :unique_author_id => uniq_auth.id, :status => JConst::AuthorMapStatus::UNAPPROVED})
              auth_map.save!
              author.approval_status = JConst::AuthorStatus::APPROVAL_PENDING
              author.save
           } 
           @count_levenshtein_groups = @count_levenshtein_groups + 1 
         end
      }
      puts "Check" 
      all_pending_authors.each{|author|
         if !author.name.strip.empty? && author.approval_status == JConst::AuthorStatus::SUGGESTION_PENDING
           uniq_auth = UniqueAuthor.new({:name => author.name,:opinionated => author.opinionated})
           uniq_auth.save!
		   auth_map = AuthorMap.new({:author_id => author.id, :unique_author_id => uniq_auth.id, :status => JConst::AuthorMapStatus::APPROVED})
           auth_map.save!
           author.approval_status = JConst::AuthorStatus::APPROVED
           author.save
         end
      }

      puts "Database updated. " + @count_levenshtein_groups.to_s + " new suggestions generated"
      return 0
      
    end
   
   
    def first_name_bucket_with_levenshtein
      first_name_groups = {}
      all_pending_authors = Author.find(:all, :conditions => ["approval_status=?",JConst::AuthorStatus::SUGGESTION_PENDING])
 
      if all_pending_authors.length == 0
         puts "No new authors found "
         return 0
      end
      sanitized_names = {}
      all_pending_authors.each{|author| 
        name = author.name
        name = name.split(' And ')[0] if name.include?(' And ')
        name = name.split(' and ')[0] if name.include?(' and ')
        name = name.split(' Und ')[0] if name.include?(' Und ')
        name = name.split(' und ')[0] if name.include?(' und ')
        name = name.split(',')[0] if name.include?(',')
        sanitized_names[author.id] = name 
      }
      puts "Fetching all authors from db complete "
      
      all_pending_authors.each{|author|
        temp = sanitized_names[author.id].split(" ")[0] 
        unless temp.nil?
          first_name_groups[temp] = Array.new if first_name_groups[temp].nil?
          first_name_groups[temp].push(author)
        end
      }
      ## Here we have all the unique categories, where we will put all our authors.
      puts "First name grouping complete"
      puts "Number of Unique Categories = " + first_name_groups.length.to_s
      ## Now last_name_groups are ready for levenshtein based similarity refinement.
      levenshtein_refined_groups = {}
      first_name_groups.each{|key,val|
        if (val.length > 1)
          get_groups_modified(key,val,sanitized_names).each{|cat,authors|
             levenshtein_refined_groups[cat]=Array.new
             authors.each{|auth|
               levenshtein_refined_groups[cat].push(auth)
             }
           }
        else
           uniq_auth = UniqueAuthor.new({:name => val[0].name,:opinionated => val[0].opinionated})
           uniq_auth.save!
		   auth_map = AuthorMap.new({:author_id => val[0].id, :unique_author_id => uniq_auth.id, :status => JConst::AuthorMapStatus::APPROVED})
           auth_map.save!
           val[0].approval_status = JConst::AuthorStatus::APPROVED
        end 
      }
      puts "Levenstein grouping complete : Writing Groups To database"
      @count_levenshtein_groups = 0 
      ## Now we have our levenshtein_refined_groups ready. Next we save it in DB :)
      levenshtein_refined_groups.each{|key,val|
         if(val.length > 1) 
           #puts "Category : " + key
           uniq_auth = UniqueAuthor.new({:name => val[0].name,:opinionated => val[0].opinionated})
           uniq_auth.save!
           val.each{|author|
              #puts "   " + author.name
              auth_map = AuthorMap.new({:author_id => author.id, :unique_author_id => uniq_auth.id, :status => JConst::AuthorMapStatus::UNAPPROVED})
              auth_map.save!
              author.approval_status = JConst::AuthorStatus::APPROVAL_PENDING
           } 
           @count_levenshtein_groups = @count_levenshtein_groups + 1 
         else
           uniq_auth = UniqueAuthor.new({:name => val[0].name,:opinionated => val[0].opinionated})
           uniq_auth.save!
		   auth_map = AuthorMap.new({:author_id => val[0].id, :unique_author_id => uniq_auth.id, :status => JConst::AuthorMapStatus::APPROVED})
           auth_map.save!
           val[0].approval_status = JConst::AuthorStatus::APPROVED
           #val[0].save!
         end
      }

      puts all_pending_authors.length 
      @count_unconsidered_authors = 0
      all_pending_authors.each{|author|
		  if author.approval_status == JConst::AuthorStatus::SUGGESTION_PENDING
		 #   #author.approval_status = JConst::AuthorStatus::APPROVAL_PENDING 
		    @count_unconsidered_authors = @count_unconsidered_authors + 1 
            puts author.name
          end
		 author.save
      }
      puts "Database updated. " + @count_levenshtein_groups.to_s + " new suggestions generated"
      puts @count_unconsidered_authors
      return 0
    end



    def generate_initial_author_group_suggestions
      last_name_groups = {}
      all_pending_authors = Author.find(:all, :conditions => ["approval_status=?",JConst::AuthorStatus::SUGGESTION_PENDING])
 
      if all_pending_authors.length == 0
         puts "No new authors found "
         return 0
      end
     
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
        else
           uniq_auth = UniqueAuthor.new({:name => val[0].name,:opinionated => val[0].opinionated})
           uniq_auth.save!
		   auth_map = AuthorMap.new({:author_id => val[0].id, :unique_author_id => uniq_auth.id, :status => JConst::AuthorMapStatus::APPROVED})
           auth_map.save!
           val[0].approval_status = JConst::AuthorStatus::APPROVED
        end 
      }
      puts "Levenstein grouping complete : Writing Groups To database"
      @count_levenshtein_groups = 0 
      ## Now we have our levenshtein_refined_groups ready. Next we save it in DB :)
      levenshtein_refined_groups.each{|key,val|
         if(val.length > 1) 
           #puts "Category : " + key
           uniq_auth = UniqueAuthor.new({:name => val[0].name,:opinionated => val[0].opinionated})
           uniq_auth.save!
           val.each{|author|
              #puts "   " + author.name
              auth_map = AuthorMap.new({:author_id => author.id, :unique_author_id => uniq_auth.id, :status => JConst::AuthorMapStatus::UNAPPROVED})
              auth_map.save!
              author.approval_status = JConst::AuthorStatus::APPROVAL_PENDING
           } 
           @count_levenshtein_groups = @count_levenshtein_groups + 1 
         else
           uniq_auth = UniqueAuthor.new({:name => val[0].name,:opinionated => val[0].opinionated})
           uniq_auth.save!
		   auth_map = AuthorMap.new({:author_id => val[0].id, :unique_author_id => uniq_auth.id, :status => JConst::AuthorMapStatus::APPROVED})
           auth_map.save!
           val[0].approval_status = JConst::AuthorStatus::APPROVED
           #val[0].save!
         end
      }

      puts all_pending_authors.length 
      @count_unconsidered_authors = 0
      all_pending_authors.each{|author|
		  if author.approval_status == JConst::AuthorStatus::SUGGESTION_PENDING
		 #   #author.approval_status = JConst::AuthorStatus::APPROVAL_PENDING 
		    @count_unconsidered_authors = @count_unconsidered_authors + 1 
            puts author.name
          end
		 author.save
      }
      puts "Database updated. " + @count_levenshtein_groups.to_s + " new suggestions generated"
      puts @count_unconsidered_authors
      return 0
    end

    def generate_incremental_author_group_suggestions
      @all_pending_authors = Author.find(:all, :conditions => ["approval_status=?",JConst::AuthorStatus::SUGGESTION_PENDING], :limit => 10)
      if @all_pending_authors.length == 0
         puts "No new authors found"
         return 0
      end
      @all_unique_authors = UniqueAuthor.find(:all)
      @count = 0
      recommendations = {}
      @all_pending_authors.each{|author|
         @all_unique_authors.each{|unique_author|
            if get_dissimilarity(author.name,unique_author.name) < @@dissimilarity_threshold
              author_map = AuthorMap.new({:author_id => author.id, :unique_author_id => unique_author.id, :status => JConst::AuthorMapStatus::UNAPPROVED })
              author_map.save
			  author.approval_status = JConst::AuthorStatus::APPROVAL_PENDING
              @count = @count + 1
            end
         }
         puts @count
         if @count == 0 
			unique_author = UniqueAuthor.new({:name => author.name , :opinionated => author.opinionated})
            unique_author.save
            author_map = AuthorMap.new({:author_id => author.id, :unique_author_id => unique_author.id, :status => JConst::AuthorMapStatus::APPROVED})
            author_map.save
			author.approval_status = JConst::AuthorStatus::APPROVED
         end
		 author.save
         puts author.name
      }
      
    end
    
    private
    
    def get_dissimilarity(a,b)
       (Text::Levenshtein.distance(a,b) / [a.length, b.length].max.to_f)
    end
 
    def get_groups_modified(category,author_array,sanitized_names)
      flag = Array.new
      refined_groups = {}
      author_array.each{|e| flag.push(0)} ## initialize the flag for marking visited authors
 
      (0..author_array.length-1).each{|i|
        if(flag[i]==0) 
          author_x = author_array[i]
          refined_groups[sanitized_names[author_x.id]] = Array.[](author_x) 
          flag[i] = 1 
          (0..author_array.length-1).each{|j|
            author_y = author_array[j]
            a = sanitized_names[author_x.id].gsub(category, "") 
            b = sanitized_names[author_y.id].gsub(category, "") 
            if(flag[j]==0 && (get_dissimilarity(a,b) < @@dissimilarity_threshold ) ) 
              refined_groups[sanitized_names[author_x.id]].push(author_y)
              flag[j] = 1 
            end
          }   
        end 
      }
      refined_groups
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
    public
    def update_site_map
      latest_author_id = SiteMapCategoryAuthorMap.maximum :author_id
      authors        = Author.find(:all, 
                                   :conditions => ["id > ?", latest_author_id],
                                   :select => "id, name")
      authors.reject!{|a| (a.name.to_s.size < 2 or a.rawstories.count < 1) rescue true }
      s_cs = SiteMapAuthorSubCategory.find(:all, :limit => 2500)
      authors.each do |a|
        # Find the appropriate sub category
        i = 0 
        s_cs_size = s_cs.size
        while i < s_cs_size
          s_c = s_cs[i]
          l1, l2 = s_c.label.split(' - ')
          l2 = l2.to_s
          n = a.name.to_s[0,30]
          if n <= l2 or (i == s_cs_size -1)
            # Insert in the group
            SiteMapCategoryAuthorMap.create!(:author_id => a.id,
                                             :category_id => s_c.category_id, 
                                             :sub_category_id => s_c.id)  
            # Fix labels
            if n < l1 
              label = "#{n} - #{l2}"
              s_c.label = label
              s_c.save!
              c = s_c.category
              ll1, ll2 = c.label.split(' - ') 
              if n < ll1
                label = "#{n} - #{ll2.to_s}"
                c.label = label
                c.save!
              end
            end
            puts "i = #{i}"
            puts s_c.inspect
            break
          end
          i += 1
        end
      end
    end
    def create_site_map
      # Find the old site map
      old_cs = SiteMapAuthorCategory.find(:all, :select => "id").collect{|c| c.id}
      old_s_cs = SiteMapAuthorSubCategory.find(:all, :select => "id").collect{|c| c.id}
      old_a_ms = SiteMapCategoryAuthorMap.find(:all, :select => "id").collect{|a| a.id}

      authors        = Author.find(:all, 
                                   :select => 'id, name')
      authors.reject!{|a| (a.name.to_s.size < 2 or a.rawstories.count < 1) rescue true }.sort_by{|a| a.name}

      authors_size   = authors.size
      no_of_groups   = 50 * 50
      items_per_group = authors_size/no_of_groups
      items_per_group =  ( authors_size % no_of_groups  > 0 ) ?  items_per_group + 1 : items_per_group
      # Partition the authors into categories and sub categories
      author_groups = []
      i = 0
      while i < authors_size
        author_groups << authors[i, items_per_group]
        i += items_per_group
      end
      super_groups = []
      i = 0
      author_groups_size = author_groups.size 
      while i < author_groups_size
        super_groups << author_groups[i,50]
        i += 50
      end
      super_groups.each do |s_g|
        label = "#{s_g.first.first.name.to_s[0,30]} - #{s_g.last.last.name.to_s[0,30]}"
        c = SiteMapAuthorCategory.create!(:label => label)
        s_g.each do |a_g|
          label = "#{a_g.first.name.to_s[0,30]} - #{a_g.last.name.to_s[0,30]}"
          s_c = SiteMapAuthorSubCategory.create!(:label => label, :category_id => c.id)
          a_g.each do |a|
            SiteMapCategoryAuthorMap.create!(:author_id => a.id, :category_id => c.id,:sub_category_id => s_c.id)
          end
        end
      end
      # Delete old Site map
      SiteMapCategoryAuthorMap.delete(old_a_ms) unless old_a_ms.blank?
      SiteMapAuthorSubCategory.delete(old_s_cs) unless old_s_cs.blank?
      SiteMapAuthorCategory.delete(old_cs)      unless old_cs.blank?
    end
  end
end
