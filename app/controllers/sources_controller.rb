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
  params[:source][:quality] = JConst::Quality::LOW if !params[:source].blank? and params[:source][:quality].blank? and !params[:source][:subscription_type].blank? and JConst::SubscriptionType.login_required?(params[:source][:subscription_type])

  @source.update_attributes!(params[:source])
  update_query = []
  update_query << "subscription_type = #{params[:source][:subscription_type]}" unless params[:source][:subscription_type].blank?
  update_query << "quality = #{params[:source][:quality]}" unless params[:source][:quality].blank?
  update_query = update_query*","
  Feedpage.update_all(update_query,"source_id = #{@source.id}") unless update_query.blank?

  redirect_to :id => @source.id
end


end
