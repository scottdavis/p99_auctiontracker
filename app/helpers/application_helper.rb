module ApplicationHelper
  include AccordionsHelper
  include TabsHelper
  
  def alla_link(item)
    return '' if item.item_cache.blank?
    link_to("#{item.name} on allakhazam", "http://everquest.allakhazam.com/db/item.html?item=#{item.item_cache.alla_id}", :target => '_blank')
  end
  
  def display_flash
    out = []
    flash.each_pair do |key, value|
      out << content_tag(:div, value, {:class => 'flash', :id => "#{key}_flash"})
    end
    out.join("\n").html_safe
  end
  
  def variance(population)
      n = 0
      mean = 0.0
      s = 0.0
      population.each { |x|
        n = n + 1
        delta = x - mean
        mean = mean + (delta / n)
        s = s + delta * (x - mean)
      }
      return s / n
    end

    def standard_deviation(population)
      Math.sqrt(variance(population))
    end
    
    def median(collection)
      collection.sort!
      middle = collection.size.to_f / 2
      return collection.first if collection.size == 1;
      a = middle.ceil
      return (collection[a-1.to_i] + collection[a.to_i]) / 2 if middle % 2
      collection[middle.to_i]
    end
end
