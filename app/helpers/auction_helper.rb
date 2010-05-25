module AuctionHelper
  
  def letter_pagination(param)
    out = []
    ('a'..'z').to_a.each do |letter|
		  if param == letter
			  out << letter
			else
			  out << link_to(letter, auction_index_path(:letter=>letter))
		  end
	  end
	  out.join("\n")
  end
  
end
