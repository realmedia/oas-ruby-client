require 'oas/datatypes'
require 'nokogiri'
require 'scrivener'

module OAS
  class Model
    include OAS::DataTypes
    include Scrivener::Validations

    def self.client
      @client ||= OAS.client
    end

    def self.client=(client)
      @client = client
    end

    def self.attribute(name, cast = nil)
      if cast
        define_method(name) do
          cast[@attrs[name]]
        end

        define_method(name.to_s.snakecase) do
          cast[@attrs[name]]
        end
      else
        define_method(name) do
          @attrs[name]
        end

        define_method(name.to_s.snakecase) do
          @attrs[name]
        end
      end

      define_method(:"#{name}=") do |value|
        @attrs[name] = value
      end

      define_method(:"#{name.to_s.snakecase}=") do |value|
        @attrs[name] = value
      end
    end

    def self.identifier(name = nil)
      if name.nil?
        @identifier ||= :Id
      else
        attribute(name) unless name == :Id
        @identifier = name
      end
    end

    def self.[](id)
      new(:Id => id).reload!
    end

    def initialize(attrs = {})
      @attrs = {}
      update_attributes(attrs)
    end

    def id
      @attrs[self.class.identifier]
    end
    alias :Id :id

    def id=(value)
      @attrs[self.class.identifier] = value
    end
    alias :Id= :id=

    def client
      self.class.client
    end

    def attrs
      @attrs
    end
    alias to_hash attrs

    def update_attributes(attrs)
      attrs.each { |att, val| send(:"#{att}=", val) if respond_to?(:"#{att}=") }
    end

    def update(attrs)
      update_attributes(attrs)
      save
    end

    def save
      raise OAS::Error::Invalid.new if not valid?

      if new?
        attrs = client.request(_database(:add)).to_hash[:AdXML][:Response].last[_model_name.to_sym]
        _load(attrs)
      else
        client.request(_database(:update))
      end
    end

    def new?
      !defined?(@created_at)
    end

    def reload!
      attrs = client.request(_database(:read)).to_hash[:AdXML][:Response][_model_name.to_sym]
      _load(attrs)
      return self
    end

    def created_at
      @created_at
    end

    def validate
      assert_present self.class.identifier
    end

  private

    def _created_at_value(attrs)
      attrs[:WhenCreated]
    end

    def _load(attrs)
      update_attributes(attrs)
      @created_at = DateTime.strptime(_created_at_value(attrs), "%m/%d/%Y %H:%M:%S")
    end

    def _database(action = :add)
      Nokogiri::XML::Builder.new(:encoding => "utf-8") do |xml|
        xml.AdXML {
          xml.Request(:type => _model_name) {
            xml.Database(:action => action) {
              xml.send(:"#{_model_name}") {
                if action == :read
                  xml.send(self.class.identifier, id)
                else
                  attrs.each do |k,v|
                    xml.send(k, v)
                  end
                end
              }
            }
          }
          if action == :add
            xml.Request(:Type => _model_name) {
              xml.Database(:action => :read) {
                xml.send(:"#{_model_name}") {
                  xml.send(self.class.identifier, id)
                }
              }
            }
          end
        }
      end.to_xml
    end

    def _model_name
      str = self.class.name.to_s
      if i = str.rindex('::')
        str[(i+2)..-1]
      else
        str
      end
    end
  end
end