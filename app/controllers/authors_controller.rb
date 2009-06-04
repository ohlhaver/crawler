class AuthorsController < ApplicationController
  
 before_filter :login_required
  def map_authors
  end
  def search_authors
    puts params.inspect
    params[:page] = params[:page].blank? ? 1 : params[:page].to_i
    params[:per_page] = params[:per_page].blank? ? 20 : params[:per_page].to_i
    search_hash =  {:query       => params[:name],
                    :class_names => 'Author',
                    :page        => params[:page],
                    :per_page    => params[:per_page]}
    @search = Ultrasphinx::Search.new(search_hash)
    @authors = @search.results
  end
  def search_unique_authors
    params[:page] = params[:page].blank? ? 1 : params[:page].to_i
    params[:per_page] = params[:per_page].blank? ? 20 : params[:per_page].to_i
    search_hash =  {:query       => params[:name],
                    :class_names => 'UniqueAuthor',
                    :page        => params[:page],
                    :per_page    => params[:per_page]}
    @search = Ultrasphinx::Search.new(search_hash)
    @authors = @search.results
  end
  
  def index
    @authors = Author.find(:all, :order => 'authors.name ASC')
  end

  def show
     @author = Author.find(params[:id])
     @rawstories_published = @author.rawstories.find(:all, :order => 'rawstories.id DESC')
  end

  def opinionate
    @author = Author.find(params[:id])
    @author.opinionated = 1
    @author.save
    @author.rawstories.each do |story|
      story.opinion = 1
      story.save
    end
    redirect_to :action => 'index' 
  end
  
  def deopinionate
    @author = Author.find(params[:id])
    @author.opinionated = 0
    @author.save
    @author.rawstories.each do |story|
      story.opinion = 0
      story.save
    end
    redirect_to :action => 'index'
  end

  def manual_suggestions
    unless (params[:auth].nil? || params[:unique_auth].nil?)
      arr = []
      params[:auth].each{|key,val| arr.push(val)}
      if arr.uniq.length >= 1
        puts params[:auth].inspect
        puts params[:unique_auth].inspect
        unique_author = UniqueAuthor.find_by_id(params[:unique_auth]["name"])
        author_array = []
        params[:auth].each{|key,val|
          author_array.push(Author.find_by_id(key)) if val == "1" 
        }
        puts author_array.inspect
        author_array.each{|author,val|
           #map = AuthorMap.find_by_sql("select * from author_maps where author_id=#{author.id} and unique_author_id=#{unique_author_id}")
           map = AuthorMap.find_by_author_id(author.id)
           puts map.inspect 
           unless map.nil?
             map.unique_author_id ==  unique_author.id
             map.status = JConst::AuthorMapStatus::APPROVED
           else
             map = AuthorMap.new({:author_id => author.id, :unique_author_id => unique_author.id, :status => JConst::AuthorMapStatus::APPROVED})
           end
           author.approval_status = JConst::AuthorStatus::APPROVED
           author.save
           map.save
        }
      end
    end
    redirect_to :action => :map_authors
  end



  def show_suggestions
   @hello = "" 
   @map_hash = {}
   @map_hash_first_20 = {}
   @i = 0
   @all_maps = AuthorMap.find(:all, :conditions => ["status=?",JConst::AuthorMapStatus::UNAPPROVED])
   @all_maps.each{|map|
      if @map_hash[map.unique_author].nil?
        @map_hash[map.unique_author] = Array.new 
        @i = @i + 1
        @map_hash_first_20[map.unique_author] = Array.new if @i < 21
      end
      @map_hash[map.unique_author].push(map) 
      @map_hash_first_20[map.unique_author].push(map) unless @map_hash_first_20[map.unique_author].nil?
   }
   puts @map_hash.length
   puts @map_hash_first_20.length
  end

  def approve_suggestions
    params[:auth_map].each{|key,val|
      @map = AuthorMap.find_by_id(key.to_i)
      if(val == "false") 
        @old_unique_auth = @map.unique_author
        @uniq_auth = UniqueAuthor.new({:name => @map.author.name,:opinionated => @map.author.opinionated})
        @uniq_auth.save!
		@old_unique_auth.destroy if Array(AuthorMap.find_by_unique_author_id(@old_unique_auth.id)).length == 0

        @map.unique_author = @uniq_auth
      end
      @map.status = JConst::AuthorMapStatus::APPROVED
      @map.author.approval_status = JConst::AuthorStatus::APPROVED
      @map.save
      @map.author.save
      #puts map.unique_author.id.to_s + "    " + map.author_id.to_s
    }
    redirect_to :action => :show_suggestions
  end


  def show_incremental_suggestions
   @hello = "" 
   @all_approval_pending_authors_first_20 = Author.find(:all, :conditions => ["approval_status=?", JConst::AuthorStatus::APPROVAL_PENDING], :order => "id DESC", :limit => 20)
   @all_approval_pending_authors = Author.find(:all, :conditions => ["approval_status=?", JConst::AuthorStatus::APPROVAL_PENDING])
  end

  def approve_incremental_suggestions
   puts params[:auth_map]
   params[:auth_map].each{|key,val|
     @author = Author.find_by_id(key.to_i)
     if (val == "new") ## Its a new author
       ### Clean up the suggestions
       @junk_maps = Array(AuthorMap.find_by_author_id(@author.id))
       @junk_maps.each{|map| 
          unique_author = map.unique_author
          map.destroy
          unique_author.destroy if Array(AuthorMap.find_by_unique_author_id(unique_author.id)).length == 0
       }
       ### create new entries
       @new_unique_author = UniqueAuthor.new({:name => @author.name,:opinionated => @author.opinionated})
       @new_unique_author.save!

       @auth_map = AuthorMap.new({:author_id => @author.id, :unique_author_id => @new_unique_author.id, :status => JConst::AuthorMapStatus::APPROVED})
       @auth_map.save!

       @author.approval_status = JConst::AuthorStatus::APPROVED
       @author.save
     else  ## It belongs to an existing category
       @map = AuthorMap.find_by_id(val.to_i) 
       @map.status = JConst::AuthorMapStatus::APPROVED      
       @map.save
       @author.approval_status = JConst::AuthorStatus::APPROVED
       @author.save  
     end
   }
   redirect_to :action => :show_incremental_suggestions
  end


  def edit
  end

end
