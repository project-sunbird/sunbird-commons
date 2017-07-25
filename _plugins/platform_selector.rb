require 'open3'
require_relative '_utils.rb'

module Jekyll

  class PlatformSelectorTag < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      @markup = markup.gsub(/[^a-z_0-9\-]/, "")
    end

    def render(context)
      if context.environments.first['page']['platforms'] != nil then
        platforms = Array.new
        for platform in context.environments.first['page']['platforms']
          for base_platform in context.registers[:site].data['platforms']
            if base_platform['key'] == platform then
              platforms.push(base_platform)
            end
          end
        end
      else
        platforms = context.registers[:site].data['platforms']
      end
      current_path = context.environments.first['page']['current_path'] || '/'
      site_map = context.registers[:site].data['site_map']
      url_section = context.environments.first['page']['section'] || ''
      url_platform = context.environments.first['page']['platform'] || ''

      return BranchUtils.instance.react(
        '<PlatformSelector
          current_path="' + current_path + '"
          site_map=' + BranchUtils.instance.json_property(site_map) + '
          platforms=' + BranchUtils.instance.json_property(platforms) + '
          url_section="' + url_section + '"
          url_platform="' + url_platform + '" />')
    end
  end

end

Liquid::Template.register_tag('platform_selector', Jekyll::PlatformSelectorTag)
