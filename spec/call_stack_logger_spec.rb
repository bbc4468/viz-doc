RSpec.describe VizDoc::CallStackLogger do
  before(:each) do
    $LOAD_PATH.unshift File.expand_path('../abc', __FILE__)
    require 'def'
    require 'xyz'
    @mm = VizDoc::ModuleManager.new(Abc)
  end

  it "should pass" do
  end
end
