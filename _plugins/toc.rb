
module Jekyll
    module TOC
        def toc_generate(html, title)
            counter = false
            first = true
            toc = []
            levels = [2]
            html.gsub!(/<h([0-9]) id="(.*?)(?:-img-srcimgpremiumstarpng-classpremium-flag-)?">(.*)<\/h\d>/) { |m, tag, header| # This is a yucky regex to work around a Kramdown limitation in rendering anchor tags
                level = Regexp.last_match[1].to_i
                id = Regexp.last_match[2]
                text = Regexp.last_match[3]

                if levels.find_index(level) then toc.push({ :level => level, :id => id, :text => text, :children => [] }) end

                if level.to_s == '2'

                    counter ^= true
                    if counter == true
                        panel_class = 'panel'
                    else
                        panel_class = 'panel panel-dark'
                    end

                    if first == true
                        panel_html = '<div class="' + panel_class + '">'
                        first = false
                    else
                        panel_html = '</div><div class="' + panel_class + '">'
                    end

                    panel_html + '<h' + level.to_s + '><a class="anchor" name="' + id + '"></a><a class="link" href="#' + id + '"><i class="material-icons">link</i>' + text + '</a></h' + level.to_s + '>'
                else
                    '<h' + level.to_s + '><a class="anchor" name="' + id + '"></a><a class="link" href="#' + id + '"><i class="material-icons">link</i>' + text + '</a></h' + level.to_s + '>'
                end
            }
            nested_toc = _nested_toc(toc)
            toc_title = title.length > 0 ? '<h4 class="toc-title">Contents</h4>' : ''
            toc_title + _render_toc(nested_toc, 1, title) + html + "</div>"

        end
        def _render_toc(toc, level, title)
            if toc.length > 0 and title == 'number' then
                "<ol class='toc-number'" + (level == 2 ? ' type="a"' : "") + ">\n" +
                    toc.map { |item| '<li><a href="#' + item[:id] + '">' + item[:text] + _render_toc(item[:children], level + 1, title) + "</a></li>" }.join("\n") +
                    "</ol>\n"
            elsif toc.length > 0 and title == 'list' then
                "<div class='toc-list'" + (level == 2 ? ' type="a"' : "") + ">\n" +
                    toc.map { |item| '<li><a href="#' + item[:id] + '">' + item[:text] + _render_toc(item[:children], level + 1, title) + "</a></li>" }.join("\n") +
                    "</div>\n"
            else
                ""
            end
        end
        def _nested_toc(toc)
            new_toc = []
            current_h2 = nil
            # This is a really janky way to do this. Eventually we can do something better
            while toc.length > 0
                item = toc.shift
                if item[:level] == 2
                    if current_h2 then new_toc.push current_h2 end
                    current_h2 = item
                elsif current_h2
                    current_h2[:children].push item
                end
            end
            new_toc.push current_h2 if current_h2
            new_toc
        end
    end
end

Liquid::Template.register_filter(Jekyll::TOC)