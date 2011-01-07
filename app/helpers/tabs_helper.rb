module TabsHelper
  
  def tabs_for( *options, &block )
    raise ArgumentError, "Missing block" unless block_given?

    tabs = TabsHelper::TabsRenderer.new( *options, &block )
    tabs_html = tabs.render
    puts tabs_html
    concat(tabs_html).html_safe
  end
  
  class TabsRenderer
    
    def initialize( options={}, &block )
      raise ArgumentError, "Missing block" unless block_given?

      @template = eval( 'self', block.binding )
      @options = options
      @tabs = []

      yield self
    end
    
    def create( tab_id, tab_text, options={}, &block )
      raise "Block needed for TabsRenderer#CREATE" unless block_given?
      @tabs << [ tab_id, tab_text, options, block ]
    end
    
    def render
      content_tag( :div, [render_tabs, render_bodies], { :id => :tabs }.merge( @options ) ).html_safe
    end
    
    private #  ---------------------------------------------------------------------------
    
    def render_tabs
      content_tag :ul do
        @tabs.collect do |tab|
          content_tag( :li, link_to( content_tag( :span, tab[1] ).html_safe, "##{tab[0]}" ) ).html_safe
        end.join.html_safe
      end.html_safe
    end
    
    def  render_bodies
      @tabs.collect do |tab| 
        content_tag( :div, capture( &tab[3] ).html_safe, tab[2].merge( :id => tab[0] ) ).html_safe
      end.join.to_s.html_safe
    end
    
    def method_missing( *args, &block )
      @template.send( *args, &block )
    end
    
  end

end
