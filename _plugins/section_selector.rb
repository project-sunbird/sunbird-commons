require 'open3'
require_relative '_utils.rb'

module Jekyll

  class SectionSelectorTag < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      @markup = markup.gsub(/[^a-z_0-9\-]/, "")
    end

    def render(context)
      if context.environments.first['page']['sections'] != nil then
        sections = Array.new
        for section in context.environments.first['page']['sections']
          new_section = Hash.new
          new_section['key'] = section
          new_section['name'] = section.capitalize.strip.gsub('-', ' ')
          sections.push(new_section)
        end
      else
        sections = context.registers[:site].data['sections']
      end

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
        platforms = {}
      end

      current_path = context.environments.first['page']['current_path'] || '/'
      site_map = context.registers[:site].data['site_map']
      url_section = context.environments.first['page']['section'] || ''

      return BranchUtils.instance.react(
        '<SectionSelector
          current_path="' + current_path + '"
          site_map=' + BranchUtils.instance.json_property(site_map) + '
          sections=' + BranchUtils.instance.json_property(sections) + '
          platforms=' + BranchUtils.instance.json_property(platforms) + '
          url_section="' + url_section + '" />')
    end
  end

end

Liquid::Template.register_tag('section_selector', Jekyll::SectionSelectorTag)
