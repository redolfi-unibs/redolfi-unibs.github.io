{% assign downcase_tag = include.content_tag | downcase %}
{% assign upcase_tag = include.content_tag | upcase %}

{% for static_file in site.static_files reversed %}
    {% if static_file.basename contains upcase_tag or static_file.basename contains downcase_tag %}
        {% assign splittedDate = static_file.basename | split: "-" %}
        {% assign month = splittedDate[3] | plus: 0  %}
        {% assign year = splittedDate[2] | plus: 0  %}
        {% assign day = splittedDate[4] | plus: 0  %}
[appello del {{ day }} {{ site.data.months[month] }} {{ year }}]({{ static_file.path }})
    {% endif %}
{% endfor %}
