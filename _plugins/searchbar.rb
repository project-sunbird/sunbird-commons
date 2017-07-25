require 'open3'
require_relative '_utils.rb'

module Jekyll

  class SearchbarTag < Liquid::Tag
    def initialize(tag_name, markup, tokens)
    end

    def render(context)
      return BranchUtils.instance.react('<SearchBar />')
    end
  end

end

Liquid::Template.register_tag('searchbar', Jekyll::SearchbarTag)
