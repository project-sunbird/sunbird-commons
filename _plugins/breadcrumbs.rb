require 'open3'
require_relative '_utils.rb'

module Jekyll

  class BreadcrumbsTag < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      @markup = markup.gsub(/[^a-z_0-9\-]/, "")
    end

    def render(context)
      site_map = context.registers[:site].data['site_map']
      layout = context.registers[:site].data['sidebar']
      current_path = context.environments.first['page']['current_path'] || '/'
      page_title = context.environments.first['page']['title']

      return BranchUtils.instance.react(
        '<Breadcrumbs
          current_path="' + current_path + '"
          page_title="' + page_title + '"
          site_map=' + BranchUtils.instance.json_property(site_map) + '
          layout=' + BranchUtils.instance.json_property(layout) + '/>')
    end
  end

end

Liquid::Template.register_tag('breadcrumbs', Jekyll::BreadcrumbsTag)
