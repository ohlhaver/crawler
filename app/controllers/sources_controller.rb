class SourcesController < ApplicationController

 before_filter :login_required

def show
  @source = Source.find(params[:id])
  @feedpages = @source.feedpages.find(:all, :order => 'feedpages.id DESC')
  @rawstories_published = Rawstory.find(:all, :conditions => "source_id = #{@source.id}", :order => 'rawstories.id DESC', :limit => '10')
end

def index
  @sources = Source.find(:all)
end

def update

  @source = Source.find(params[:id])
  @source.website = params[:website]
  @source.save
  redirect_to :id => @source.id



end


end
