require "spec_helper"

RSpec.describe Burger do
  describe "#yum?" do
    it "is yummy" do
      expect(Burger.new).to be_yum
    end
  end
end
