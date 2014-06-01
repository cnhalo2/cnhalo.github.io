# encoding: utf-8

module More
    def more(input, type, post_url)
        if input.include? "<!-- more -->"
            if type == "excerpt"
                input.split("<!-- more -->").first + "<a href='" + post_url + "' class='btn btn-primary'>继续阅读</a>"
            elsif type == "remaining"
                input.split("<!-- more -->").last
            else
                input
            end
        else
            input
        end
    end
end

Liquid::Template.register_filter(More)