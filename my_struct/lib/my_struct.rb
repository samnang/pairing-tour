class MyStruct
  def self.new(*names, &block)
    raise ArgumentError, "wrong number of arguments (0 for 1+)" if names.empty?
    raise TypeError unless names.all?{ |name| name.is_a? Symbol }

    Class.new do
      include Enumerable

      class_eval(&block) if block_given?

      define_method(:initialize) { |*values| @attributes = Hash[names.zip(values)] }

      names.each do |name|
        define_method(name) { attributes[name] }
        define_method("#{name}=") { |value| attributes[name] = value }
      end

      def [](name)
        attributes.fetch(name.to_sym) { raise NameError, "no member '#{name}' in struct" }
      end

      def []=(name, value)
        name = name.to_sym
        raise NameError, "no member '#{name}' in struct" unless attributes.has_key?(name)

        attributes[name] = value
      end

      def members
        attributes.keys
      end

      def values
        attributes.values
      end

      def size
        members.size
      end

      def select(&block)
        values.select(&block)
      end

      def each(&block)
        values.each(&block)
      end

      def inspect
        attribute_pairs = attributes.map{|k, v| "#{k}=#{v.inspect}"}.join(", ")

        "#<struct #{attribute_pairs}>"
      end

      private
      
      attr_accessor :attributes
    end
  end
end
