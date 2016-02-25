module ApplicationHelper
	def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def pusher_include_tag(version)
    domain = if request.ssl?
               'https://d3dy5gmtp8yhk7.cloudfront.net'
             else
               'http://js.pusher.com'
             end

    javascript_include_tag "#{domain}/#{version}/pusher.min.js"
  end
end
