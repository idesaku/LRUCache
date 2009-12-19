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
    end

    it "はputした値をgetできるべき" do

      @lru.put("a", "aaaa")
      @lru.get("a").should == "aaaa"

      @lru.put("b", "bbbb")
      @lru.get("b").should == "bbbb"
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
      @lru.put("a", "aaa")
      @lru.put("b", "bbb")
      @lru.put("c", "ccc")

      @lru.order("a").should == 0
      @lru.order("b").should == 1
      @lru.order("c").should == 2
    end

    it "は最初に登録したkeyがわかる" do
      @lru.put("a", "aaa")
      @lru.put("b", "bbb")
      @lru.put("c", "ccc")

      @lru.first.should == "a"
    end

    it "は登録数を超える場合、最初に登録したデータを削除する" do
      @lru.put("a", "aaa")
      @lru.put("b", "bbb")
      @lru.put("c", "ccc")
      @lru.put("d", "ddd")
    end
  end
end
