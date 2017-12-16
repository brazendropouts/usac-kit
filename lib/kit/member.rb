require 'csv'
require 'kit/date_parser'
require 'kit/race'

module Kit
  # An individual USA Cycling member
  class Member
    # Given an HTML table of races, return a +Member+ with that
    # collection of races
    #
    # @param table [Kit::Table]
    # @return [Kit::Member]
    def self.from_table(table)
      date_parser = DateParser.new
      maybe_content = -> (element) { element.nil? ? nil : element.content }

      races = table.map do |race_row, result_row|
        [
          result_row.css('td')[2].content,
          [
            race_row.css('a').first.content,
            maybe_content.call(race_row.css('[title=age]').first)
          ].compact.join(' '),
          result_row.css('td')[0].content,
          date_parser.parse(race_row),
          result_row.css('td').last.content
        ]
      end.map do |args|
        Kit::Race.new(*args)
      end

      new(races)
    end

    include Enumerable
    extend Forwardable

    attr_reader :races

    def self.preserve_container_for(*enumerable_methods)
      enumerable_methods.each do |method_name|
        define_method(method_name) do |*args, &block|
          Member.new(races.method(method_name).call(*args, &block))
        end
      end
    end

    private_class_method :preserve_container_for

    def_delegator :@races, :each
    preserve_container_for :sort_by, :reverse

    # @param races [Array<Kit::Race>]
    def initialize(races = [])
      @races = races
    end

    # Returns a +Member+ with a collection of races limited to the
    # given list of years.
    #
    # @param years [Array<Fixnum>] a list of one or more years (e.g. 2010)
    # @return [Kit::Member]
    def limited_to(years)
      selected_races = years.reduce([]) do |races, year|
        lower = Date.strptime("#{year}-01-01")
        upper = Date.strptime("#{Integer(year) + 1}-01-01")

        races | @races.select do |race|
          race.date >= lower && race.date < upper
        end
      end

      self.class.new(selected_races)
    end
  end
end
