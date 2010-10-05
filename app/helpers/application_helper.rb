# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def display_flash
    out = []
    flash.each_pair do |key, value|
      out << content_tag(:div, value, {:class => 'flash', :id => "#{key}_flash"})
    end
    out.join("\n")
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
end
