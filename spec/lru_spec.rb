require 'lru'

describe LRU do
  describe "を初期化する場合" do
    it "はキャッシュサイズを設定できるべき" do
      lru = LRU.new(2)
      lru.size.should == 2

      lru = LRU.new(3)
      lru.size.should == 3
    end

    it "は0以下のサイズを渡された場合、ArgumentErrorを上げる" do
      lambda {
        lru = LRU.new(0)
      }.should raise_error(ArgumentError)
      lambda {
        lru = LRU.new(-1)
      }.should raise_error(ArgumentError)
    end
  end

  describe '' do
    before :each do
      @lru = LRU.new(3)
      @lru.put("a", "aaa")
      @lru.put("b", "bbb")
      @lru.put("c", "ccc")
    end

    it "はputした値をgetできるべき" do

      @lru.put("x", "aaaa")
      @lru.get("x").should == "aaaa"

      @lru.put("y", "bbbb")
      @lru.get("y").should == "bbbb"
    end

    it "はgetにnilを渡された場合、nil を返す" do
      @lru.put("a", "aaa")
      @lru.get(nil).should == nil
    end

    it "はputのkeyにnilを渡された場合、ArgumentError を上げる" do
      lambda {
        @lru.put(nil, "aaa")
      }.should raise_error(ArgumentError)
    end

    it "は登録順がわかる" do
      @lru.order("a").should == 0
      @lru.order("b").should == 1
      @lru.order("c").should == 2
    end

    it "は最初に登録したkeyがわかる" do
      @lru.first.should == "a"
    end

    it "は登録数を超える場合、最初に登録したデータを削除する" do
      @lru.put("d", "ddd")

      @lru.get("a").should be_nil
      @lru.get("b").should_not be_nil
    end

    it "は参照されたデータを最新登録にする" do
      @lru.get("a")
      @lru.first.should == "b"
      @lru.order("a").should == 2
    end
    it "登録順が変わった後で最も古いデータを削除する" do
      @lru.get("a")
      @lru.put("d", "ddd")
      @lru.get("b").should be_nil
      @lru.get("a").should_not be_nil

    end

    it "は0以下のキャッシュサイズを設定できない" do
      lambda {
        @lru.resize(0)
      }.should raise_error(ArgumentError)

      lambda {
        @lru.resize(-1)
      }.should raise_error(ArgumentError)
    end

    it "はキャッシュサイズを増やせる" do
      @lru.resize(4)
      @lru.size.should == 4
    end

    describe "キャッシュサイズを減らした場合" do
      it "はキャッシュサイズが変更される" do
        @lru.resize(2)
        @lru.size.should == 2
      end

      it "は溢れた分が参照されないデータから削除される" do
        @lru.resize(2)
        @lru.first.should == "b"
        @lru.order("c").should_not be_nil
        @lru.order("a").should be_nil
      end
    end

    it "は元のサイズと同じサイズへの変更を指示された場合、何も変更しない" do
      @lru.resize(3)

      @lru.order("a").should_not be_nil
      @lru.order("b").should_not be_nil
      @lru.order("c").should_not be_nil
      @lru.order("d").should be_nil
    end
  end
end
