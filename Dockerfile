FROM fluent/fluentd:v0.14-onbuild
MAINTAINER Lawrence Wyatt <lawrence.wyatt@vocalink.com>

RUN apk add --update --virtual .build-deps \
        sudo build-base ruby-dev \
 && sudo gem install \
        fluent-plugin-elasticsearch \
 && sudo gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /var/cache/apk/* \
           /home/fluent/.gem/ruby/2.3.0/cache/*.gem \
 && rm -f /bin/entrypoint.sh

COPY fluenttail.conf /fluentd/etc/fluent.conf

ENTRYPOINT ["fluentd", "-c", "/fluentd/etc/fluent.conf"]

EXPOSE 24284
