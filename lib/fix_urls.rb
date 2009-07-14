require 'rubygems'
require 'hpricot'
require 'uri'
class FixUrls
  class << self
    def get_absolute_url(u, doc_url)
      u = URI.parse(URI.encode(u))
      return u.to_s unless u.relative?
      p,q,f =  u.select(:path, :query, :fragment)
      a_url = build_absolute_url_from_hash(get_base_url_info(doc_url).merge({:path => p, :query => q, :fragment => f}))
      return a_url.to_s
    end
    def get_base_url_info(url_string)
      scheme, user_info, host, port, registry, path, opaque, query, fragment = URI::split(url_string)
      {:scheme => scheme, user_info => :user_info, :host => host, :port => port, :registry => nil, :path => nil, :opaque => nil, :query => nil, :fragment => nil}
    end
    def build_absolute_url_from_hash(h)
      URI::Generic.new(h[:scheme],
                       h[:user_info],
                       h[:host],
                       h[:port],
                       h[:registry],
                       h[:path],
                       h[:opaque],
                       h[:query],
                       h[:fragment]).to_s
    end
  end
end
