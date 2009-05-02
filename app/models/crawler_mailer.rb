class CrawlerMailer < ActionMailer::Base
  def feedpage_health_alert(feedpage)
    
    @recipients  = %w(ohlhaver@gmail.com jrath95@gmail.com ubhay.iitd@gmail.com sinha.riteshk@gmail.com)
    @from        = "#{SITE_EMAIL}"
    @subject     = "#{SITE_NAME} : Feedpage Health Alert"
    @sent_on     = Time.now
    @body[:feedpage]     = feedpage
  end
end
