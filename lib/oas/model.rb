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
      else
        define_method(name) do
          @attrs[name]
        end
      end

      define_method(:"#{name}=") do |value|
        @attrs[name] = value
      end

      alias_attribute(name.to_s.snakecase, name)
    end

    def self.alias_attribute(name, original)
      class_eval <<-RUBY
        alias #{name}  #{original}
        alias #{name}= #{original}=
      RUBY
    end

    def self.reference(name)
      reader = :"#{name}Id"
      writer = :"#{name}Id="

      define_method(reader) do
        @attrs[reader]
      end

      define_method(writer) do |value|
        @_memo.delete(name)
        @attrs[reader] = value
      end

      define_method(:"#{name}=") do |value|
        send(writer, value ? value.id : nil)
        @_memo[name] = value
      end

      define_method(name) do
        @_memo[name] ||= begin
          model = self.class.const_get(name)
          model[send(reader)]
        end
      end

      alias_attribute(reader.to_s.snakecase, reader)
      alias_attribute(name.to_s.snakecase, name)
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
      @_memo = {}
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

    def valid?
      errors.clear
      assert_present self.class.identifier
      validate
      errors.empty?
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

  private
    def attribute_present?(att)
      !send(att).to_s.empty?
    end

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
                  _attrs_to_xml(attrs, xml)
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

    def _attrs_to_xml(attrs = {}, builder = Nokogiri::XML::Builder.new(:encoding => "utf-8"))
      attrs.each do |k,v|
        if v.kind_of?(::Hash)
          builder.send(k) {
            _attrs_to_xml(v, builder)
          }
        else
          builder.send(k, v)
        end
      end
      builder
    end

    def _model_name
      self.class.name.to_s.gsub(/^.*::/, '')
    end
  end
end