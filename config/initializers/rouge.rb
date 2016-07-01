
module Rouge
  module Formatters
    # Transforms a token stream into HTML output.
    class CustomLinewise < Formatter
      tag 'html'

      def initialize(opts={})
        @css_class = opts.fetch(:css_class, "hightlight")
        @line_class = opts.fetch(:line_class, "line-%i")
      end

      # @yield the html output.
      def stream(tokens, &b)
        yield "<pre class=#{@css_class}>"
        token_lines(tokens) do |line|
          yield "<code class=#{next_line_class}>"
          line.each do |tok, val|
            yield span(tok, val)
          end
          yield '</code>'
        end
        yield "</pre>"
      end

      def span(tok, val)
        safe_span(tok, val.gsub(/[&<>]/, TABLE_FOR_ESCAPE_HTML))
      end

      def safe_span(tok, safe_val)
        if tok == Token::Tokens::Text
          safe_val
        else
          shortname = tok.shortname \
          or raise "unknown token: #{tok.inspect} for #{safe_val.inspect}"

          "<span class=\"#{shortname}\">#{safe_val}</span>"
        end
      end

      def next_line_class
        @lineno ||= 0
        sprintf(@line_class, @lineno += 1).inspect
      end

      private
      TABLE_FOR_ESCAPE_HTML = {
        '&' => '&amp;',
        '<' => '&lt;',
        '>' => '&gt;',
      }
    end
  end
end

module Rouge
  module Plugins
    module MyRedcarpet
      def block_code(code, language)
        lexer = Lexer.find_fancy(language, code) || Lexers::PlainText

        # XXX HACK: Redcarpet strips hard tabs out of code blocks,
        # so we assume you're not using leading spaces that aren't tabs,
        # and just replace them here.
        if lexer.tag == 'make'
          code.gsub! /^    /, "\t"
        end

        formatter = rouge_formatter(lexer)
        formatter.format(lexer.lex(code))
      end

      # override this method for custom formatting behavior
      def rouge_formatter(lexer)
        Formatters::CustomLinewise.new(:css_class => "highlight #{lexer.tag}",
                                       :line_class => "l l-%i")
      end
    end
  end
end
