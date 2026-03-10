FROM elasticsearch:9.3.1
LABEL maintainer="NAKANO Hideo <nakano@web-tips.co.jp>"

# install prerequisities
RUN elasticsearch-plugin install --batch analysis-icu
RUN elasticsearch-plugin install --batch analysis-kuromoji
RUN elasticsearch-plugin install --batch ingest-attachment
#Fess プラグインは Elastcisearch 9 をサポートしない
#RUN elasticsearch-plugin install --batch org.codelibs:elasticsearch-analysis-fess:8.14.1.0
#RUN elasticsearch-plugin install --batch org.codelibs:elasticsearch-analysis-extension:8.14.1.0
#RUN elasticsearch-plugin install --batch org.codelibs:elasticsearch-minhash:8.14.1.0
