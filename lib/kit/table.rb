require 'kit/date_parser'
require 'nokogiri'

module Kit
  # Wraps the results table HTML. It iterates over each race-result
  # pair, and exposes the table's column headings.
  class Table
    include Enumerable

    # Creates a new +Table+
    #
    # @param html [String] the raw HTML which contains a results table
    def initialize(html)
      @html = Nokogiri::HTML(html)
      @date_parser = DateParser.new
    end

    # Yields each race-result pair from the table
    #
    # @yieldparam race_row [Nokogiri::XML::Element] the row which has the race
    #   data
    # @yieldparam result_row [Nokogiri::XML::Element] the row which has the
    #   result data
    def each(&block)
      race_rows.each { |race_row, result_row| block.call(race_row, result_row) }
    end

    # Returns a lightly-sanitized list of column headings
    #
    # @return [Array<String>]
    def headings
      headings_row.css('th').map { |th| th.text.scan(/\w|\s|#/).join }
    end

    # Returns an HTML document which only contains the table of race data
    #
    # @return [String]
    def to_html
      if race_rows.any?
        content = headings_row.to_html + race_rows.flatten.map(&:to_html).join
      else
        content = nil
      end

      Nokogiri::HTML("<table>#{content}</table>").to_html
    end

    private

    def race_rows
      @_race_rows ||= @html.css('tr').select(&method(:has_date?)).map do |tr|
        sibling = tr.next_sibling

        until sibling.name == 'tr'
          sibling = sibling.next_sibling
        end

        [tr, sibling]
      end
    end

    def headings_row
      @_headings_row ||= @html.css('th').first.parent
    end

    def has_date?(tr)
      @date_parser.parse(tr)
    end
  end
end
