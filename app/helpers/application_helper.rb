require 'redcarpet'
require 'rouge'

# create a custom renderer that allows highlighting of code blocks
class HTMLWithRouge < Redcarpet::Render::HTML
  include Rouge::Plugins::MyRedcarpet
end

module ApplicationHelper

  def markdown(text)
    options = {
        filter_html: true,
        hard_wrap: true,
        link_attributes: { rel: 'nofollow' }
    }

    extensions = {
        autolink: true,
        fenced_code_blocks: true,
        lax_spacing: true,
        no_intra_emphasis: true,
        strikethrough: true,
        superscript: true,
        tables: true
    }


    renderer = HTMLWithRouge.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end
end
