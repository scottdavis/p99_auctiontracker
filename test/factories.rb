Factory.define(:item) do |f|
  f.sequence(:name) {|n| "Item #{n}"}
end