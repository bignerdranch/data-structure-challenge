require_relative '../lib/list'
require_relative '../lib/dict'

describe Dict do
  describe '::[]' do
    context 'with a list of 2-element lists' do
      let(:pairs) { List[List[:a, 1], List[:b, 2], List[:c, 3]] }

      it 'returns a dict' do
        expect(Dict[pairs]).to be_a(Dict)
      end

      it 'uses each element as a key/value pair to create a dict' do
        dict = Dict[pairs]

        pairs.each do |key, value|
          expect(dict[key]).to eq(value)
        end
      end
    end
  end

  describe '::allocate' do
    it 'creates a new, empty dict' do
      dict = Dict.allocate
      expect(dict).to eq(Dict[])
    end
  end

  describe '#==' do
    it 'returns true for equivalent dicts' do
      list1 = Dict[List[List['a', 'b'], List['c', 'd']]]
      list2 = Dict[List[List['c', 'd'], List['a', 'b']]]
      expect(list1 == list2).to be(true)
    end

    it 'returns false for unequivalent dicts' do
      list1 = Dict[List[List['a', 'b'], List['c', 'd']]]
      list2 = Dict[List[List['c', 'd'], List['e', 'f']]]
      expect(list1 == list2).to be(false)
    end
  end

  describe '#[]' do
    let(:object) { Object.new }

    it 'returns the value for key' do
      dict = Dict[List[
        List[:a, 1],
        List['b', 'two'],
        List[object, 'object'],
        List[List[], object]
      ]]
      expect(dict[:a]).to eq(1)
      expect(dict['b']).to eq('two')
      expect(dict[object]).to eq('object')
      expect(dict[List[]]).to eq(object)
    end
  end

  describe '#[]=' do
    let(:object) { Object.new }

    it 'it stores the value at key' do
      dict = Dict.allocate
      dict[:a] = 1
      dict['b'] = 'two'
      dict[object] = 'object'
      dict[List[]] = object

      expect(dict[:a]).to eq(1)
      expect(dict['b']).to eq('two')
      expect(dict[object]).to eq('object')
      expect(dict[List[]]).to eq(object)
    end

    it 'returns the value' do
      dict = Dict.allocate
      expect(dict['foo'] = 'bar').to eq('bar')
    end

    context 'twice with the same key' do
      it 'overwrites the first assignment' do
        dict = Dict.allocate
        dict['foo'] = 'bar'
        dict['foo'] = 'baz'

        expect(dict['foo']).to eq('baz')
      end
    end
  end
end
