require 'spec_helper'

describe 'Jsonify template handler' do
  
  Handler = ActionView::Template::Handlers::JsonifyBuilder
  ViewTemplate = Struct.new(:source)

  let( :handler ) { Handler.new }

  let( :template ) do
    ViewTemplate.new("json.hello 'world'")
  end

  context "#{Rails.version}" do
    before do
      Rails.stub_chain(:application, :config, :jsonify_format).and_return( :plain )
    end

    it 'should use JSON as its default output format' do
      handler.default_format.should == Mime::JSON
    end

    it 'should compile to JSON' do
      result = eval( Handler.call template )
      result.should == '{"hello":"world"}'
    end

    describe 'when configured with ' do
      def expect_format(format)
        Jsonify::Builder.should_receive(:new).with({:format => format}).and_return( double("json").as_null_object )
      end
    
      describe 'pretty' do
        before do
          Rails.stub_chain(:application, :config, :jsonify_format).and_return( :pretty )
        end
    
        it 'should pass pretty to the builder' do
          expect_format :pretty
          eval( Handler.call template )
        end
      end

      describe 'plain' do
        before do
          Rails.stub_chain(:application, :config, :jsonify_format).and_return( :plain )
        end
    
        it 'should pass plain to the builder' do
          expect_format :plain
          eval( Handler.call template )
        end
      end

      describe 'nothing' do
        before do
          Rails.stub_chain(:application, :config)
        end
    
        it 'should pass plain to the builder' do
          expect_format :plain
          eval( Handler.call template )
        end
      end
    
    end
  end

end