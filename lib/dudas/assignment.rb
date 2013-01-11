require 'nokogiri'
require 'date'

class Array
  def or_nil
    if self.empty?
      return nil
    else
      return self
    end
  end
end

class String

  def or_nil
    if self.empty?
      return nil
    else
      return self
    end
  end

end

module Dudas

  class Assignment

    def initialize(raw)
      if raw.instance_of? Nokogiri::XML::Element
        @raw = raw
      elsif raw.instance_of? String
        @raw = Nokogiri::XML(raw)  
      else
        throw "Unknown input (try using a Nokogiri element or a plain string)"
      end
    end
    
    def id
      reel + "-" + frame
    end

    def reel
      @reel ||= text_at 'reel-no'
    end

    def frame
      @frame ||= text_at 'frame-no'
    end

    def purge_indicator
      @purge_indicator ||= (text_at('purge-indicator') == 'N' ? false : true)
    end

    def page_count
      @page_count ||= text_at('page-count')
    end

    def correspondent_name
      @correspondent_name ||= text_at 'assignment-record correspondent name'
    end

    def correspondent_address
      return @correspondent_address if @correspondent_address

      @correspondent_address = []
      c  = @raw.css('assignment-record correspondent')
      addresses = c.xpath('address-1|address-2|address-3|address-4')

        
      addresses.each do |a|
        @correspondent_address << a.text
      end

      if @correspondent_address.empty?
        @correspondent_address = nil
      end
      
      @correspondent_address
    end

    def assignors
      return @assignors if @assignors
      @assignors = @raw.css('patent-assignor').collect { |a| parse_assignor(a) }
    end

    def assignees
      return @assignees if @assignes
      @assignees = @raw.css('patent-assignee').collect { |a| parse_assignee(a) }
    end

    def assets
      return @assets if @assets
      @assets = @raw.css('patent-property').collect { |a| parse_patent_property(a) }
    end


    def parse_patent_property(node)
      ids = []
      title = node.css('invention-title').text.capitalize.or_nil

      ids = node.css('document-id').collect { |i| parse_document_id(i) }

      {
        ids: ids,
        title: title
      }
    
    end

    def parse_document_id(node)
      country = node.css('country'   ).text
      number  = node.css('doc-number').text
      kind    = node.css('kind'      ).text.or_nil
      name    = node.css('name'      ).text.or_nil
      date    = node.css('date'      ).text.or_nil
      
      {
        country: country,
        number: number,
        kind: kind,
        name: name,
        date: date
      }

    end

    def parse_assignor(node)
      name              = node.css('name'                  ).text
      execution_date    = node.css('execution-date date'   ).text.or_nil
      date_acknowledged = node.css('date_acknowledged date').text.or_nil
     
      {
        :name => name,
        :execution_date => execution_date,
        :date_acknowledged => date_acknowledged
      }

    end

    def parse_assignee(node)
      name      = node.css('name'     ).text             # TODO: legal/natural
      address_1 = node.css('address-1').text.or_nil
      address_2 = node.css('address-2').text.or_nil
      city      = node.css('city'     ).text.or_nil
      state     = node.css('state'    ).text.or_nil
      country   = node.css('country'  ).text.or_nil
      postcode  = node.css('postcode' ).text.or_nil

      address   = [address_1, address_2].compact.or_nil


      {
        :name => name,
        :address => address,
        :city => city,
        :state => state,
        :country => country,
        :postcode => postcode
      }

    end


    def to_hash
      {
        record: {
          reel: reel,
          frame: frame,
          last_updated: last_update_date,
          purge: purge_indicator,
          recorded_on: recorded_date,
          pages: page_count,
          correspondent: {
            name: correspondent_name,
            address: correspondent_address
          },
          conveyance_text: conveyance_text.gsub(' (SEE DOCUMENT FOR DETAILS).', ''),
        },
        assignors: assignors,
        assignees: assignees,
        assets: assets
      }
    end

    def method_missing(meth, *args, &block)
      xml_element_name = meth.to_s.gsub('_', '-')

      already_set_variable = instance_variable_get("@" + meth.to_s)
      
      return already_set_variable if already_set_variable # already set, lets go
      
      extracted_value = text_at(xml_element_name)

      if extracted_value != ''
        instance_variable_set("@" + meth.to_s, extracted_value)
      else
        super
      end
    end


    private

      def text_at(selector)
        @raw.css(selector).text
      end

  end

end