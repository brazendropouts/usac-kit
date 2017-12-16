require 'addressable/template'
require 'http'
require 'kit/member'
require 'kit/table'

module Kit
  class Client
    # Creates a new +Client+
    def initialize
      @template = Addressable::Template.new(
        'https://legacy.usacycling.org/results/{?compid}'
      )
    end

    # Builds a Table for the given license-holder
    #
    # @param license_number [Fixnum] a valid USAC License Number
    #
    # @return [Member] the member with the given license number
    def find(license_number)
      Kit::Member.from_table(table_for(license_number))
    end

    private

    def table_for(license_number)
      begin
        license_number = Integer(license_number)
      rescue ArgumentError
        Kit::Table.new(BLANK_PAGE)
      else
        Kit::Table.new(raw(license_number))
      end
    end

    def raw(license_number)
      url = @template.expand(compid: Integer(license_number))

      HTTP.get(url).to_s
    end

    BLANK_PAGE = '<!doctype html><html></html>'.freeze
    private_constant :BLANK_PAGE
  end
end
