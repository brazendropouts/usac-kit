require 'date'

module Kit
  # Parses dates as they appear in the results table
  class DateParser
    # Creates a new +DateParser+
    def initialize
      @date_format = '%m/%d/%Y'
    end

    # Returns the first date, if any, in the given +element+'s text
    #
    # @param element [#text] an element with text
    #
    # @return [Date] if the given +element+ contains a parseable date
    # @return [nil] if the given +element+ contains no parseable dates
    def parse(element)
      part_with_date = element.text.split(' ').find do |date_string|
        begin
          string_to_date(date_string)
        rescue ArgumentError
        end
      end

      if part_with_date
        string_to_date(part_with_date)
      end
    end

    private

    def string_to_date(string)
      Date.strptime(string, @date_format)
    end
  end
end
