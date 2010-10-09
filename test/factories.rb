Factory.define(:item) do |f|
  f.sequence(:name) {|n| "Item #{n}"}
end

Factory.define(:auction) do |f|
  f.sequence(:player) {|n| "player #{n}"}
  f.time Time.now + rand
  f.price rand(1000)
end