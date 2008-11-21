class RawstoriesController < ApplicationController
  
   
  
  def index  
  
      @sources = Source.find(:all)
    
  end
  
  def opinions
    #@rawstories=Rawstory.find(:all, :order => 'id DESC', :limit => '10', :conditions => 'opinion = 1')
    
  #  @search = Ultrasphinx::Search.new(:query => $query, 
   #                                   :weights => { 'title' => 2.0 },
    #                                  :filter => {'opinion' => 1})
                                      
  #  @search.run
  #  @rawstories = @search.results
  #  @rawstories = @rawstories.paginate :page => params[:page],
    #                                    :per_page => 8
    
   # render :action => 'search'        
  end
  
  
  def search
    require 'will_paginate'

    @search = Ultrasphinx::Search.new(:query => params[:q], 
                                      :weights => { 'title' => 2.0 })
                                      
    @search.run
    @rawstories = @search.results
    @rawstories = @rawstories.paginate :page => params[:page],
                                        :per_page => 8
  end
  
  def sort_by_time
    require 'will_paginate'
    @search = Ultrasphinx::Search.new(:query => $query, 
                                      :weights => { 'title' => 2.0 },
                                      :sort_by => 'created_at', 
                                      :sort_mode => 'descending')
                                      
    @search.run
    @rawstories = @search.results
    @rawstories = @rawstories.paginate :page => params[:page],
                                        :per_page => 8
    
    
    render :action => 'search'
  
  end  
  

  
  def show
     @rawstory = Rawstory.find(params[:id])
  end
 
end
