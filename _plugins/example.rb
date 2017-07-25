require 'kramdown'

# Takes one property i.e. {% example title='Here's how you can use this' %}

module Jekyll
    class ExampleTag < Liquid::Block
    def initialize(tag_name, text, tokens)
      super
      @params = text
    end

    def render(context)
      data = {}

      @params.scan(/(\w+)=["']([^'\\]+(\\.[^'\\]+)*)["']/).each { |m|
        data[m[0]] = Liquid::Template.parse(m[1]).render!(context)
      }

      title = if data['title'] then '<h5 class="example__title">Example: ' + data['title'] + '</h5>' else '<h5 class="example__title">Example</h5>' end
      contents = Kramdown::Document.new(super).to_html
      '<blockquote class="example">' + title + contents + '</blockquote>'
    end
  end
end

Liquid::Template.register_tag('example', Jekyll::ExampleTag)
