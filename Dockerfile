FROM elasticsearch:7.17.4
LABEL maintainer="NAKANO Hideo <nakano@web-tips.co.jp>"

# install prerequisities
RUN elasticsearch-plugin install --batch analysis-icu
RUN elasticsearch-plugin install --batch analysis-kuromoji
RUN elasticsearch-plugin install --batch ingest-attachment
RUN elasticsearch-plugin install --batch org.codelibs:elasticsearch-analysis-fess:7.17.0
RUN elasticsearch-plugin install --batch org.codelibs:elasticsearch-analysis-extension:7.17.0
RUN elasticsearch-plugin install --batch org.codelibs:elasticsearch-minhash:7.17.0
