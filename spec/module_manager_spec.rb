RSpec.describe VizDoc::ModuleManager do
  before(:each) do
    $LOAD_PATH.unshift File.expand_path('../abc', __FILE__)
    require 'def'
    require 'xyz'
    @mm = VizDoc::ModuleManager.new(Abc)
  end

  it 'read get classes correctly' do
    expect(@mm.classes).to eq([Abc::Def, Abc::Xyz])
  end

  it 'should allow bindings properly' do
    expect(@mm.binding_allowed?(Abc::Def, :lol)).to eq(true)
    expect(@mm.binding_allowed?(Abc::Def, :abc)).to eq(false)
    expect(@mm.binding_allowed?(Abc::Xyz, :lol)).to eq(false)
  end


end
