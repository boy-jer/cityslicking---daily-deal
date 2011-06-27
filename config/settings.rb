# Set the default encoding (also works around a bug in Rack)
  Encoding.default_external = 'utf-8'


# Enable sessions

  set :sessions, true


# Render .html with embedded Ruby
  
  Tilt.register :html, Tilt[:erb]
