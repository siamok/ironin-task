class Serializer
  attr_reader :object

  def self.attribute key, &block
    @attributes ||= {}
    @attributes[key] = block
  end

  def self.attributes
    @attributes
  end

  def initialize arg
    @object = arg
  end

  def serialize
    attrs = self.class.attributes
    attrs.inject({}) do |hash, (name, block) |
      param = block ? instance_exec(&block) : @object[name]
      
      hash[name] = param
      hash
    end
  end
end
