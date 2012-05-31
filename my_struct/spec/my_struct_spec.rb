require 'my_struct'

describe MyStruct, '.new' do
  it 'returns an anonymous class' do
    described_class.new(:abc).should be_a_kind_of Class
    described_class.new(:abc).name.should be_nil
  end

  it 'raises an ArgumentError if not given at least one argument' do
    expect { described_class.new }.to raise_error ArgumentError, "wrong number of arguments (0 for 1+)"
  end

  it 'raises a TypeError for arguments which are not symbols' do
    expect { described_class.new 123 }.to raise_error TypeError
  end

  specify 'the arguments define methods for instances of the returned class' do
    instance = described_class.new(:foo, :bar).new
    instance.should respond_to :foo
    instance.should respond_to :bar
  end

  it 'takes a block which is class_evaled' do
    klass = described_class.new(:abc) do
      @some_ivar = :whatever
      def instance_meth() 'instance value' end
      def self.class_meth() 'class value' end
    end
    klass.instance_variable_get(:@some_ivar).should == :whatever
    klass.new.instance_meth.should == 'instance value'
    klass.class_meth.should == 'class value'
  end

  describe 'the returned class' do
    describe 'methods defined by the struct' do
      specify 'they define a getter which returns the value they are initialized with' do
        instance = described_class.new(:foo, :bar).new 1, 'two'
        instance.foo.should == 1
        instance.bar.should == 'two'
      end

      specify 'they return nil if they were not initialized' do
        instance = described_class.new(:foo, :bar).new 1
        instance.foo.should == 1
        instance.bar.should == nil
      end

      specify 'they define a setter which can override the value' do
        instance = described_class.new(:baz, :quux).new 1, 2
        instance.baz = 3
        instance.quux = 4
        instance.baz.should == 3
        instance.quux.should == 4
      end
    end

    describe '#[]' do
      it 'accepts string/symbol keys that match the specified attributes' do
        instance = described_class.new(:foo).new
        instance[:foo]
        instance['foo']
      end

      it 'raises a NameError for keys that do not match the specified attributes' do
        instance = described_class.new(:foo).new
        expect { instance[:bar] }.to raise_error NameError, "no member 'bar' in struct"
      end

      it 'returns the value set into the attributes' do
        instance = described_class.new(:foo).new 1
        instance[:foo].should == 1
        instance['foo'].should == 1
        instance.foo = 2
        instance[:foo].should == 2
      end

      it 'is equivalent to the getter attributes' do
        instance = described_class.new(:foo).new 1
        instance.foo = 2
        instance.foo.should == 2
        instance[:foo].should == 2
      end
    end

    describe '#[]=' do
      it 'accepts symbol/string keys that match the specified attributes' do
        instance = described_class.new(:foo).new 1
        instance[:foo] = 2
      end

      it 'raises a NameError for keys that do not match the specified attributes' do
        expect { described_class.new(:foo).new[:bar] = 1 }.to raise_error NameError, "no member 'bar' in struct"
      end

      it 'sets the value that will be returned by the getter and by #[]' do
        instance = described_class.new(:foo).new 1
        instance[:foo] = 2
        instance.foo.should == 2
        instance['foo'] = 3
        instance.foo.should == 3
      end
    end

    describe '#inspect' do
      it 'identifies its type, keys, and inspected values' do
        instance = described_class.new(:foo, :bar).new :abc
        instance.inspect.should == "#<struct foo=:abc, bar=nil>"
      end
    end

    describe '#members' do
      it 'returns an array of symbols representing the names of its struct attributes' do
        described_class.new(:foo, :bar).new.members.should == [:foo, :bar]
      end
    end

    describe '#select' do
      it 'invokes the block passing in successive elements from struct, returning an array containing those elements for which the block returns a true value (equivalent to Enumerable#select)' do
        lots = described_class.new(:a, :b, :c, :d, :e, :f)
        l = lots.new(11, 22, 33, 44, 55, 66)
        l.select { |v| (v % 2).zero? }.should == [22, 44, 66]
      end
    end

    describe '#size' do
      it 'returns the number of its struct attributes' do
        described_class.new(:a,:b,:c).new.size.should == 3
      end
    end

    describe '#values' do
      it 'returns the values of its attributes, in the order they were defined' do
        described_class.new(:foo, :bar).new('foo value', 'bar value').values.should == ['foo value', 'bar value']
      end
    end

    describe 'enumerability' do
      it 'defines each, which yields each of its attributes, in the order they were defined' do
        names = []
        described_class.new(:foo, :bar).new(:baz, 123).each { |name| names << name }
        names.should == [:baz, 123]
      end

      it 'returns an enumerator if not given a block' do
        described_class.new(:foo, :bar).new.each.should be_a_kind_of Enumerator
        described_class.new(:foo, :bar).new(/a/, /b/).each.to_a.should == [/a/, /b/]
      end

      it 'mixes in Enumerable, giving it access to all the enumerable methods' do
        described_class.new(:foo, :bar).new("abc", "def").each_with_index.to_a.should == [["abc", 0], ["def", 1]]
        described_class.new(:a, :b, :c, :d, :e, :f).new(:ab, :ac, :bc, :ad, :cd, 'ae').grep(/a/).should == [:ab, :ac, :ad, 'ae']
      end
    end
  end
end
