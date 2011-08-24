require 'spec_helper'

describe 'Rails integration' do
  it("template class") do 
    ActionView::Template::Handlers::JsonifyBuilder.should_not be_nil
  end

  describe 'rendering' do
    it 'should work'
  end

end