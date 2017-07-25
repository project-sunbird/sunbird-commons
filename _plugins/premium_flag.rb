require 'kramdown'

module Jekyll
  class PremiumFlag < Liquid::Block
    def initialize(tag_name, text, tokens)
      super
    end

    def render(context)

      contents = Kramdown::Document.new(super).to_html
      '<img src="/img/premium_star.png" class="premium-flag" />'
    end
  end
end

Liquid::Template.register_tag('premiumflag', Jekyll::PremiumFlag)
