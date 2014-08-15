require_relative '../lib/list'

describe List do
  describe '::[]' do
    it 'creates a new list' do
      list = List[1, 2, 3]
      expect(list[0]).to eq(1)
      expect(list[1]).to eq(2)
      expect(list[2]).to eq(3)
    end
  end

  describe '#==' do
    it 'returns true for equivalent lists' do
      expect(List['a', 'b', 'c'] == List['a', 'b', 'c']).to be(true)
    end

    it 'returns false for unequivalent lists' do
      expect(List['a', 'b', 'c'] == List['a', 'b', 'x']).to be(false)
    end
  end

  describe '#<<' do
    subject(:list) { List.allocate }

    it 'pushes the object onto the end of the array' do
      expect(List[1, 2] << "c" << "d" << List[3, 4]).to eq(List[1, 2, "c", "d", List[3, 4]])
    end

    it 'pushes elements into the list' do
      list << 1
      expect(list[0]).to eq(1)
    end

    it 'returns self to allow chaining' do
      a = List.allocate
      b = a
      expect(a << 1).to equal(b)
      expect(a << 2 << 3).to equal(b)
    end

    it "correctly resizes the Array" do
      a = List.allocate
      expect(a.size).to eq(0)
      a << :foo
      expect(a.size).to eq(1)
      a << :bar << :baz
      expect(a.size).to eq(3)

      a = List[1, 2, 3]
      a.shift
      a.shift
      a.shift
      a << :foo
      expect(a).to eq(List[:foo])
    end
  end

  describe '#[]' do
    subject(:list) { List['a', 'b', 'c', 'd'] }

    context 'with [index]' do
      it 'returns the element at index' do
        expect(list[0]).to eq('a')
        expect(list[1]).to eq('b')
        expect(list[2]).to eq('c')
        expect(list[3]).to eq('d')
        expect(list[4]).to eq(nil)
        expect(list[100]).to eq(nil)
      end
    end

    context 'with [-index]' do
      it 'returns the element at index from the end of the list' do
        expect(list[-1]).to eq('d')
        expect(list[-2]).to eq('c')
        expect(list[-3]).to eq('b')
        expect(list[-4]).to eq('a')
        expect(list[-5]).to eq(nil)
        expect(list[-100]).to eq(nil)
      end
    end
  end

  describe '#[]=' do
    subject(:list) { List['a', 'b', 'c'] }

    context 'with [index]' do
      it 'sets the value of the element at index' do
        list[0] = 'x'
        expect(list).to eq(List['x', 'b', 'c'])
        list[1] = 'y'
        expect(list).to eq(List['x', 'y', 'c'])
        list[2] = 'z'
        expect(list).to eq(List['x', 'y', 'z'])
        list[4] = 'z'
        expect(list).to eq(List['x', 'y', 'z', nil, 'z'])
      end
    end

    context 'with [-index]' do
      it 'sets the value of the element at index from the end of the list' do
        list[-1] = 'z'
        expect(list).to eq(List['a', 'b', 'z'])
        list[-2] = 'y'
        expect(list).to eq(List['a', 'y', 'z'])
        list[-3] = 'x'
        expect(list).to eq(List['x', 'y', 'z'])
      end

      context 'where index is greater than the length of the list' do
        it 'raises an exception' do
          expect { list[-4] = 'w' }.to raise_error(IndexError)
        end
      end
    end
  end
end
