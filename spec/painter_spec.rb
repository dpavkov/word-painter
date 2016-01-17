require_relative '../lib/painter'

RSpec.describe "#pick_color" do
  context "with all black" do
    let (:colors) { Array.new(100) { pick_color(false) } }
    it "not random? black" do
      colors.each do |color|
        expect(color).to eq "black"
      end
    end
  end
  context "with random colors" do
    let (:colors) { Array.new(100) { pick_color(true) } }
    it "should contain red, green and blue" do
      expect(colors).to include "red"
      expect(colors).to include "black"
      expect(colors).to include "green"
    end

  end
end

RSpec.describe "#validate" do
  context "with valid input" do
    let (:input) { { "word" => "word", "random_color" => true} }
    it "should return nil" do
      validation_result = validate(input)
      expect(validation_result).to eq nil
    end
  end
  context "without word" do
    let (:input) { { "word" => "", "random_color" => true} }
    it "should return nil" do
      validation_result = validate(input)
      expect(validation_result).to eq "no streaming without the word"
    end
  end
  context "without color" do
    let (:input) { { "word" => "word"} }
    it "should return nil" do
      validation_result = validate(input)
      expect(validation_result).to eq "no streaming without random color"
    end
  end
  context "with improper color" do
    let (:input) { { "word" => "word", "random_color" => "true" } }
    it "should return nil" do
      validation_result = validate(input)
      expect(validation_result).to eq "color is random or it isn't no other option"
    end
  end
end
