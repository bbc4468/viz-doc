def stylesheets
  # Load the existing stylesheets while appending the custom one
  super + %w(css/viz_doc.css)
end

def javascripts
  # Load the existing javascripts while appending the custom one
  super + %w(js/vis.js js/underscore-min.js js/viz_doc.js)
end
