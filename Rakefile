# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'


namespace :custom do
  task :clean_up => :environment do
    regex = Regexp.new("\s(#{AuctionParser::COMMON_BAD_WORDS.join('|')})\s")
    puts regex
    Item.all.each do |i|
      if i.name.scan(regex).size > 0
        puts "cleaning #{i.name}"
        i.hidden = true;
        i.save
      end
    end
  end
  
  task :load_item_cache => :environment do
    pipe = <<-EOS
    itemclass|name|lore|lorefile|idfile|id|weight|norent|nodrop|size|slots|price|icon|UNK013|UNK014|benefitflag|tradeskills|cr|dr|pr|mr|fr|svcorruption|astr|asta|aagi|adex|acha|aint|awis|hp|mana|endur|ac|classes|races|deity|skillmodvalue|UNK038|skillmodtype|banedmgrace|banedmgbody|banedmgraceamt|banedmgamt|magic|casttime_|reqlevel|reclevel|recskill|bardtype|bardvalue|light|delay|elemdmgtype|elemdmgamt|range|damage|color|itemtype|material|UNK060|elitematerial|sellrate|combateffects|shielding|stunresist|strikethrough|extradmgskill|extradmgamt|spellshield|avoidance|accuracy|charmfileid|factionmod1|factionamt1|factionmod2|factionamt2|factionmod3|factionamt3|factionmod4|factionamt4|charmfile|augtype|augrestrict|augdistiller|augslot1type|augslot1visible|augslot1unk2|augslot2type|augslot2visible|augslot2unk2|augslot3type|augslot3visible|augslot3unk2|augslot4type|augslot4visible|augslot4unk2|augslot5type|augslot5visible|augslot5unk2|pointtype|ldontheme|ldonprice|ldonsellbackrate|ldonsold|bagtype|bagslots|bagsize|bagwr|book|booktype|filename|loregroup|artifactflag|UNK109|favor|guildfavor|fvnodrop|dotshielding|attack|regen|manaregen|enduranceregen|haste|damageshield|UNK120|UNK121|attuneable|nopet|UNK124|potionbelt|potionbeltslots|stacksize|notransfer|scriptfileid|questitemflag|expendablearrow|UNK132|clickeffect|clicktype|clicklevel2|clicklevel|maxcharges|casttime|recastdelay|recasttype|clickunk5|clickname|clickunk7|proceffect|proctype|proclevel2|proclevel|procunk1|procunk2|procunk3|procunk4|procrate|procname|procunk7|worneffect|worntype|wornlevel2|wornlevel|wornunk1|wornunk2|wornunk3|wornunk4|wornunk5|wornname|wornunk7|focuseffect|focustype|focuslevel2|focuslevel|focusunk1|focusunk2|focusunk3|focusunk4|focusunk5|focusname|focusunk7|scrolleffect|scrolltype|scrolllevel2|scrolllevel|scrollunk1|scrollunk2|scrollunk3|scrollunk4|scrollunk5|scrollname|scrollunk7|powersourcecapacity|purity|dsmitigation|heroic_str|heroic_int|heroic_wis|heroic_agi|heroic_dex|heroic_sta|heroic_cha|healamt|spelldmg|clairvoyance|backstabdmg|bardeffect|bardeffecttype|bardlevel2|bardlevel|bardunk1|bardunk2|bardunk3|bardunk4|bardunk5|bardname|bardunk7|UNK214|evolvinglevel|verified|created
    EOS
    keys = pipe.split('|')
    lines = File.readlines('/Users/sdavis/Desktop/items.txt')
    lines.each do |line|
      hash = Hash[keys.zip(line.split('|'))]
      item = ItemCache.create(:name => hash['name'], :meta => line)
      hash = nil
      item = nil
    end
  end
  
  task :map_current_items_to_cache => :environment do
    #Items.update_all(:hidden => true)
    AuctionParser.clean_items
  end
  
  task :load_alla_ids => :environment do
    require 'yaml'
    data = YAML.load_file('/Users/sdavis/Desktop/items2.yml')
    data.each do |item|
      if AuctionParser.is_item?(item[:name])
        c = AuctionParser.get_item(item[:name])
        id = item[:id].gsub('/db/item.html?item=', '')
        c.alla_id = id
        c.save
      end
    end
  end
end

