
require 'kramdown'

# Takes one property i.e. {% getstarted title='Get started with this concept' %}

module Jekyll
    class GetStartedButton < Liquid::Block
    def initialize(tag_name, text, tokens)
      super
      @params = text
    end

    def render(context)
      data = {}
 
      link_path = context.environments.first['page']['current_path']
      section = context.environments.first['page']['section']

      page_title = context.environments.first['page']['title']
      section_index = context.environments.first['page']['sections'].index(section)
      next_section = context.environments.first['page']['sections'][section_index + 1]
      if next_section then
        next_section_formatted = next_section.capitalize.strip.gsub('-', ' ')
      else
        next_section = ''
        next_section_formatted = ''
      end

      @params.scan(/(\w+)=["']([^'\\]+(\\.[^'\\]+)*)["']/).each { |m|
        data[m[0]] = Liquid::Template.parse(m[1]).render!(context)
      }

      button = 
        if data['next'] then
          if data['next'] == 'true' then 
            '<a href="/' + link_path + '/' + next_section + '" class="get-started btn btn-primary btn-lg">Next: &nbsp; <br class="visible-xs"><strong>' + page_title + '&nbsp;-&nbsp;' + next_section_formatted + '&nbsp;</strong><i class="material-icons">chevron_right</i></a>'
          elsif data['title'] then 
            '<a href="/' + data['next'] + '/' + '" class="get-started btn btn-primary btn-lg">Next: &nbsp; <br class="visible-xs"><strong>' + data['title'] + '</strong><i class="material-icons">chevron_right</i></a>' 
          end
        elsif data['title'] then 
          '<a href="/' + link_path + '/' + next_section + '" class="get-started btn btn-primary btn-lg"><strong>' + data['title'] + '</strong>&nbsp;<i class="material-icons">chevron_right</i></a>' 
        else 
          '<a href="/' + link_path + '/' + next_section + '" class="get-started btn btn-primary btn-lg">Get Started: &nbsp; <br class="visible-xs"><strong>' + page_title + '&nbsp;-&nbsp;' + next_section_formatted + '&nbsp;</strong><i class="material-icons">chevron_right</i></a>' 
        end
      button
    end
  end
end

Liquid::Template.register_tag('getstarted', Jekyll::GetStartedButton)
