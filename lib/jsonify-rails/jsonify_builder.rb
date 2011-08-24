require 'action_view'
module ActionView
  module Template::Handlers
    if ::Rails::VERSION::MAJOR == 3 && ::Rails::VERSION::MINOR < 1
      class JsonifyBuilder < Template::Handler
        include Compilable

        self.default_format = Mime::JSON

        def format
          Rails.application.config.respond_to?(:jsonify_format) ? Rails.application.config.jsonify_format : 'plain'
        end

        def compile(template)
          "json = ::Jsonify::Builder.new(:format => :#{format});" +
            template.source +
          ";json.compile!;"
        end
      end
    else
      class JsonifyBuilder
        def default_format
          Mime::JSON
        end
        
        def self.format
          Rails.application.config.respond_to?(:jsonify_format) ? Rails.application.config.jsonify_format : 'plain'
        end

        def self.call(template)
          "json = ::Jsonify::Builder.new(:format => :#{format});" +
            template.source +
          ";json.compile!;"
        end
      end
    end
  end
end

ActionView::Template.register_template_handler :jsonify, ActionView::Template::Handlers::JsonifyBuilder
