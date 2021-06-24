{% assign pdfs_pajc = site.static_files | where: include.content_tag, true %}
{% for pajc_pdf in pdfs_pajc reversed %}
{% assign splittedDate = pajc_pdf.basename | split: "-" %}
{% assign month = splittedDate[3] | plus: 0  %}
{% assign year = splittedDate[2] | plus: 0  %}
{% assign day = splittedDate[4] | plus: 0  %}
[appello del {{ day }} {{ site.data.months[month] }} {{ year }}]({{ pajc_pdf.path }})
{% endfor %}