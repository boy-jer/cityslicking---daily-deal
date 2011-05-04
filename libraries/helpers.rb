# Helpers can be used anywhere in the site


  helpers do
    
  
  # Inserts p#flash containing session[:flash], provided it isn't nil
  # Then nils session[:flash] so it doesn't show up on the next request
  # Useful for user notifications
  # To use it, just set session[:flash] before rendering or redirecting
  
    def flash
      unless session[:flash].nil?
        msg = session[:flash]
        session[:flash] = nil
        "<p id='flash'>#{msg}</p>"
      end
    end
  
  
  # Adds a class of 'sticky' to an element
  
    def sticky(path)
      'class="sticky"' if request.path_info.include? "/#{path}"
    end
    
    
  # Used as inline html to hide elements
  # Useful alongside a conditional
  # Example: <img <%= hidden if x == y %> src="..." />

    def hidden
      'style="display: none;"'
    end
    
  
  # Formats text as Markdown
  
    def markdown(text)
      RDiscount.new(text).to_html
    end
    
    
  # Capitalizes the first letter of each word
    
    def titleize(string)
      title = '' 
      string.split(' ').each do |s|
        title << s.capitalize + ' '
      end
      title
    end
    
    
  # Converts an integer or a float into a '$' string
  # Example: dollarize(4.3) will return '$4.30'  
    
    def dollarize(num)
      num = "$%.2f" % num.to_f
    end
  
  
  # Formats an integer or a float
  # Leaves either 1 decimal, or none if the decimal is 0
  # Useful for weights and sizes
  
    def truncate_number(num)
      rounded = ''
      num = num.to_f
      if num > 0
        rounded = "%.1f" % num.to_f
        rounded = rounded.to_s.split('.').first if rounded.to_s.end_with?('0')
      end
      rounded
    end
    
    
  # Formats a full date
    
    def format_date(date)
      date.strftime("%A %b %d, %Y")
    end
    
    
  # Formats a simple date

    def format_day(date)
      date.strftime("%b %d, %Y")
    end
    
    
  # Converts a date into three select form elements
  # One for month, day and year
  # Each element is named after the field argument and appended with a date part
  # Example: myField_month, myField_day, myField_year

    def date_to_field(field, date)
      date_field = ""

      date_field << "<select name='#{field}_month' id='#{field}_month'>"
      (1..12).each do |m|
        date_field << "<option value='#{m}' #{'selected' if m == date.strftime('%m').to_i}>#{m}</option>"
      end
      date_field << "</select>"

      date_field << "<select name='#{field}_day' id='#{field}_day'>"
      (1..31).each do |d|
        date_field << "<option value='#{d}' #{'selected' if d == date.strftime('%d').to_i}>#{d}</option>"
      end
      date_field << "</select>"

      date_field << "<select name='#{field}_year' id='#{field}_year'>"
      (2007..Chronic.parse('3 years from now').strftime('%Y').to_i).each do |y|
        date_field << "<option value='#{y}' #{'selected' if y == date.strftime('%Y').to_i}>#{y}</option>"
      end
      date_field << "</select>"

      date_field
    end
    
    
  end