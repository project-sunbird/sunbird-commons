require 'kramdown'

# Takes two properties i.e. {% caution title='Be careful of this!!' icon='fa-coffee' %}

module Jekyll
  class CautionTag < Liquid::Block
    def initialize(tag_name, text, tokens)
      super
      @params = text
    end

    def render(context)
      data = {}

      @params.scan(/(\w+)=["']([^'\\]+(\\.[^'\\]+)*)["']/).each { |m|
        data[m[0]] = Liquid::Template.parse(m[1]).render!(context)
      }

      title = if data['title'] then '<h5 class="caution__title">Caution: ' + data['title'] + '</h5>' else '<h5 class="caution__title">Caution</h5>' end
      contents = Kramdown::Document.new(super).to_html
      '<blockquote class="caution">' + title + contents + '</blockquote>'
    end
  end
end

Liquid::Template.register_tag('caution', Jekyll::CautionTag)
