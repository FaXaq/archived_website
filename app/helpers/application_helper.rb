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

  # def meta_keywords(tags = nil)
  #   if tags.present?
  #     content_for :meta_keywords, tags
  #   else
  #     content_for?(:meta_keywords) ? [content_for(:meta_keywords), APP_CONFIG['meta_keywords']].join(', ') : APP_CONFIG['meta_keywords']
  #   end
  # end

  # def meta_description(desc = nil)
  #   if desc.present?
  #     content_for :meta_description, desc
  #   else
  #     content_for?(:meta_description) ? content_for(:meta_description) : APP_CONFIG['meta_description']
  #   end
  # end
end
