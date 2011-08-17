require 'action_view'
module ActionView
  module Template::Handlers
    if ::Rails::VERSION::MAJOR == 3 && ::Rails::VERSION::MINOR < 1
      class JsonifyBuilder < Template::Handler
        include Compilable

        self.default_format = Mime::JSON

        def compile(template)
          "json = ::Jsonify::Builder.new(:format => :#{(Rails.application.config.jsonify_format || 'plain')});" +
            template.source +
          ";json.compile!;"
        end
      end
    else
      class JsonifyBuilder
        def default_format
          Mime::JSON
        end

        def self.call(template)
          "json = ::Jsonify::Builder.new(:format => :#{(Rails.application.config.jsonify_format || 'plain')});" +
            template.source +
          ";json.compile!;"
        end
      end
    end
  end
end

ActionView::Template.register_template_handler :jsonify, ActionView::Template::Handlers::JsonifyBuilder
