class HaufensController < ApplicationController

  def latest_top_ten
    @hsession = Hsession.find(:first, 
                              :order => "id DESC")
    @haufens = Haufen.find(:all,
                           :conditions => "haufens.hsession_id = #{@hsession.id}",
                           :order      => "haufens.broadness DESC",
                           :limit      => 10)
    rawstories = []
    story_ids = @haufens.collect{|h| h.members.strip.split(' ')}.flatten*','
    rawstories = Rawstory.find(:all, :conditions => "id IN ( #{story_ids} )") unless story_ids.blank?
    @rawstories_hashed = rawstories.group_by{|s| s.haufen_id}
  end
  def show
    @haufen = Haufen.find(params[:id])
    @rawstories = []
    story_ids = @haufen.members.strip.split(' ')*','
    @rawstories = Rawstory.find(:all, :conditions => "id IN ( #{story_ids} )") unless story_ids.blank?
  end
end
