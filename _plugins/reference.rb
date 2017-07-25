require 'faraday'

module Jekyll
  class ReferenceTag < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @asset = text.strip
    end

    def render(context)
      page = context.environments.first['page']
      @github_base = 'https://raw.githubusercontent.com'
      @github_repo_path = '/BranchMetrics/' + page['repo'] + '/master'
      file = ''

      if context.environments.first['site']['environment'] == 'production' then
        conn = Faraday.new(:url => @github_base)

        response = conn.get @github_repo_path + '/README.md'
        file = response.body.force_encoding('utf-8')

        # replace start of comment with highlight liquid tag
        file = file.gsub(/```\s*(?<lang>[a-z0-9]+)\n/, '{% highlight \k<lang> %}')
        # replace end of code comment with highlight liquid tag
        file = file.gsub(/```\n/, '{% endhighlight %}')
        # remove Title from readme (i.e. # Web SDK)
        file = file.gsub(/(^|\n)#\s.*/, '')
        # convert relative paths images to absolute paths
        file = file.gsub(/\!\[(?<alt>[^(]+)\]\((?!http)(?<url>\S+)\)/, '![\k<alt>](' + @github_base + @github_repo_path + '/' + '\k<url>' + ')')
      else
        file = "Reference guides don't compile in `development`. Change the enviornment variable in _config.yml to `production` to test reference guides"
      end


      Liquid::Template.parse(file).render!(context)

    end
  end
end

Liquid::Template.register_tag('reference', Jekyll::ReferenceTag)
