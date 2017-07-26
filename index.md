---
layout: default
pagination:
    enabled: true
---

<section id="post-list">
    <div class="container">
        {% for post in paginator.posts %}	
            <div class="item flex-100">
                {% include post_preview_left.html %}
            </div>
        {% endfor %}
    </div>
</section>
{% if paginator.total_pages > 1 %}
    <section id="pagination" class="is-center-aligned">
        <div class="container">
            <div class="item flex-100">
                <ul class="is-pagination-list">
                {% if paginator.page_trail %}
                    {% if paginator.previous_page %}
                        <li><a href="{{ paginator.previous_page_path | prepend: site.baseurl }}">&lt;</a></li>
                    {% endif %}
                    {% for trail in paginator.page_trail %}
                        <li>
                            {% assign page_url = page.url | remove: ".html" | remove: "index" %}
                            {% assign trail_path = trail.path | remove: 'index.html' %}
                            {% if page_url == trail_path %}
                                <a href="#" class="curr-page">{{ trail.num }}</a>
                            {% else %}
                                <a href="{{ trail.path | prepend: site.baseurl | remove: 'index.html' }}">{{ trail.num }}</a>
                            {% endif %}
                        </li>
                    {% endfor %}
                    {% if paginator.next_page %}
                        <li><a href="{{ paginator.next_page_path | prepend: site.baseurl }}">&gt;</a></li>
                    {% endif %}
                {% endif %}
                </ul>
            </div>
        </div>
    </section>
{% endif %}
