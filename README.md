# Jsonify-Rails &mdash; Jsonify templates for Rails views [![Build Status](https://secure.travis-ci.org/bsiggelkow/jsonify-rails.png)](http://travis-ci.org/bsiggelkow/jsonify-rails)

[Jsonify](https://github.com/bsiggelkow/jsonify) is to JSON as [Builder](https://github.com/jimweirich/builder) is to XML.

## Installation

`gem install jsonify-rails`

## Usage

Jsonify-Rails provides a Rails 3 template handler allowing you to create 
view templates using Jsonify. Any template with a `.jsonify` will be handled by Rails.

The Jsonify template handler exposes a `Jsonify::Builder` instance to your template with the `json` variable:

    json.hello do
      json.world "Jsonify is Working!"
    end
    
Just like with any other template, your Jsonify template will have access to
any instance variables that are exposed through the controller.

For optimum performance, Jsonify outputs the generated JSON string in plain format -- no newlines, or spaces -- this is best for production. However, if you want "pretty" output, you can configure Jsonify by adding the following configuration line to `application.rb`.

    config.jsonify_format = :pretty

#### Partials

You can use partials from Jsonify views, and you can create Jsonify partials.  How your Jsonify template uses a partial depends on how the information the partial returns is structured. Keep in mind that any paritial, be it a Jsonify template, erb, or anything else, always a returns its result as a string.

##### Jsonify partials

Any Jsonify partial &mdash; that is, the file has a `.jsonify` extension &mdash;
will return, by design, a string that is valid JSON. It will represent either a JSON object,wrapped in curly braces ( {} ), or a JSON array, wrapped in square brackets ( [] ).

To incorporate such a value into a Jsonify template, use the `ingest!` method. 

`ingest!` assumes that the value it receives is valid JSON representation. It parses the JSON into a Jsonify object graph, and then adds it to the current Jsonify builder.

Let's assume this this is your main template, `index.jsonify`:

    json << 1
    json.ingest! (render :partial=>'my_partial')

From the first line, you can tell that an array will be created as this line uses the append operator.
On the second line, a partial is being added to the builder. Note that you cannot simply place `render :partial ...` on a line by itself as you can do with other templates like `erb` and `haml`. You have to explicitly tell Jsonify to add it to the builder.

Let's say that the partial file, `_my_partial.jsonify`, is as follows:

    json << 3
    json << 4

This `json` variable in this partial is a separate distinct `Jsonify::Builder` instance from the `json` variable in the main template.

> Note: Figure out if a the `json` instance can be passed to the Jsonify partial.
> It would make things easier and we wouldn't have to ingest the result.

This partial results in the following string:

    "[3,4]"

The `ingest!` method will actually parse this string back into a Jsonify-based object, and adds it to the builder's current state. The resulting output will be:

    "[1,[3,4]]"

##### Other partials

You can also use output from non-Jsonify templates (e.g. erb); just remember that the output from a template is always a string and that you have to tell the builder how to include the result of the partial.

For example, suppose you have the partial `_today.erb` with the following content:

    <%= Date.today %>

You can then incorporate this partial into your Jsonify template just as you would any other string value:

    json << 1
    json << {:date => (render :partial => 'today')}

  renders ...
  
    [1,{"date":"2011-07-30"}]


## Related Projects
- [Argonaut](https://github.com/jbr/argonaut)
- [JSON Builder](https://github.com/dewski/json_builder)
- [RABL](https://github.com/nesquena/rabl)
- [Representative](https://github.com/mdub/representative)
- [Tokamak](https://github.com/abril/tokamak)

## License

This project is released under the MIT license.

## Authors

* [Bill Siggelkow](https://github.com/bsiggelkow)

## Contributors

* [Trym Skaar](https://github.com/trym)
