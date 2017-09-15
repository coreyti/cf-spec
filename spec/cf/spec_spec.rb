require "spec_helper"

RSpec.describe CF::Spec do
  it "has a version number" do
    expect(CF::Spec::VERSION).not_to be nil
  end
end
