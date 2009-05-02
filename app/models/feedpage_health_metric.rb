class FeedpageHealthMetric < ActiveRecord::Base
  belongs_to :feedpage
  belongs_to :source
  class MetricType
    LASTWEEK = 1
    SUM      = 2
    MAXIMUM  = 3
  end
  
  class << self
    def metric_types
      [MetricType::LASTWEEK, MetricType::SUM, MetricType::MAXIMUM]
    end
  end
end
