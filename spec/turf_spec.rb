require 'spec_helper'

class Turf::Test
  def mike
    "mike"
  end

  def laura
    "laura"
  end
end

describe Turf do

  context ".find" do
    it "finds the corresponding method with explicit syntax" do
      expect(Turf.find(:mike)).to eq("mike")
    end

    it "finds the corresponding method with method_missing" do
      expect(Turf.mike).to eq("mike")
    end

    it "raises and exception with the explicit syntax if the method isn't found" do
      expect{ Turf.find(:crazy) }.to raise_error(NoMethodError)
    end

    it "raises and exception with the method_missing syntax if the method isn't found" do
      expect{ Turf.crazy }.to raise_error(NoMethodError)
    end
  end

end
