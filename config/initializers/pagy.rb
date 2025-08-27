# Optionally override some pagy default with your own in the pagy initializer
Pagy::DEFAULT[:limit] = 15
Pagy::DEFAULT[:size]  = 10
# Better user experience handled automatically
require 'pagy/extras/overflow'
Pagy::DEFAULT[:overflow] = :last_page

# Debug: Force page calculation
Pagy::DEFAULT[:max_pages] = nil
