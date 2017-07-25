require 'kramdown'

# Takes two properties i.e. {% protip title='Check out this Protip!' icon='fa-coffee' %}

module Jekyll
  class ProtipTag < Liquid::Block
    def initialize(tag_name, text, tokens)
      super
      @params = text
    end

    def render(context)
      data = {}

      @params.scan(/(\w+)=["']([^'\\]+(\\.[^'\\]+)*)["']/).each { |m|
        data[m[0]] = Liquid::Template.parse(m[1]).render!(context)
      }

      title = if data['title'] then '<h5 class="protip__title">' + data['title'] + '</h5>' else '' end
      contents = Kramdown::Document.new(super).to_html
      '<blockquote class="protip">' + title + contents + '</blockquote>'
    end
  end
end

Liquid::Template.register_tag('protip', Jekyll::ProtipTag)
