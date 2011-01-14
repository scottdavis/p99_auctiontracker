# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Auctioneer::Application.initialize!
::GEO_API_KEY = '3bdd98f47048717f83099c7a4d529e904512b23df3bfe4ee17fdaa73ba611546'