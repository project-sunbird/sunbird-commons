require 'open3'
require_relative '_utils.rb'

module Jekyll

  class SidebarTag < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      @markup = markup.gsub(/[^a-z_0-9\-]/, "")
    end

    def render(context)
      site_map = context.registers[:site].data['site_map']
      layout = context.registers[:site].data['sidebar']
      current_path = context.environments.first['page']['current_path'] || '/'

      return BranchUtils.instance.react(
        '<Sidebar
          current_path="' + current_path + '"
          site_map=' + BranchUtils.instance.json_property(site_map) + '
          layout=' + BranchUtils.instance.json_property(layout) + '
          current_url=' + BranchUtils.instance.json_property(layout) + '/>')
    end
  end

end

Liquid::Template.register_tag('sidebar', Jekyll::SidebarTag)
