# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format
# (all these examples are active by default):
ActiveSupport::Inflector.inflections do |inflect|
  inflect.irregular 'ItemCache', 'ItemCaches'
  inflect.singular /^(ItemCache)s$/i, '\1'
  inflect.plural /^(ItemCache)$/i, '\1s'
  inflect.irregular 'item_cache', 'item_caches'
end
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end
