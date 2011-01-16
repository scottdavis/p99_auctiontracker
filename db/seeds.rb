# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)


aliases = YAML.load_file(Rails.root.join('db', 'dups.yaml'))


aliases.each do |k,v|
  i = Item.find_by_name(k.strip)
  next if i.blank?
  v.each do |a|
    ItemAlias.create!(:item => i, :alias => a)
  end
end