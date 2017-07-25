require 'kramdown'

# Takes one property i.e. {% prerequisite title='Here's how you can use this' %}

module Jekyll
    class PrerequisiteTag < Liquid::Block
    def initialize(tag_name, text, tokens)
      super
      @params = text
    end

    def render(context)
      data = {}

      @params.scan(/(\w+)=["']([^'\\]+(\\.[^'\\]+)*)["']/).each { |m|
        data[m[0]] = Liquid::Template.parse(m[1]).render!(context)
      }

      title = if data['title'] then '<h5 class="prerequisite__title">Prerequisite: ' + data['title'] + '</h5>' else '<h5 class="prerequisite__title">Prerequisites</h5>' end
      contents = Kramdown::Document.new(super).to_html
      '<blockquote class="prerequisite">' + title + contents + '</blockquote>'
    end
  end
end

Liquid::Template.register_tag('prerequisite', Jekyll::PrerequisiteTag)
