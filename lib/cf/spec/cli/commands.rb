module CF::Spec
  module CLI::Commands ; end
end

Dir[File.expand_path('../commands/*.rb', __FILE__)].each { |f| require(f) }
