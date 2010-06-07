# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def display_flash
    out = []
    flash.each_pair do |key, value|
      out << content_tag(:div, value, {:class => 'flash', :id => "#{key}_flash"})
    end
    out.join("\n")
  end
  
  
end
