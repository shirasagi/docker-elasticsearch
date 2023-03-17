elasticsearch container for shirasagi
====

This container is intended to use with shirasagi.
We hope this container could be useful for production.

# BUILD

run these commands:

~~~bash
docker build -t shirasagi/elasticsearch .
~~~

# RUN

run these commands:

~~~bash
docker run -d --name elasticsearch -p 9200:9200 -p 9300:9300 \
  -e discovery.type=single-node \
  shirasagi/elasticsearch
~~~

And then, run below command to check whether elastisearch is avaiable or not.

~~~
curl 'http://127.0.0.1:9200/?pretty'
~~~

You can see these outputs if elastisearch is available.

~~
{
  "name" : "6b32598c95f7",
  "cluster_name" : "docker-cluster",
  "cluster_uuid" : "bFudCoqKRNGwvV30q_sY3Q",
  "version" : {
    "number" : "7.17.4",
    "build_flavor" : "default",
    "build_type" : "docker",
    "build_hash" : "79878662c54c886ae89206c685d9f1051a9d6411",
    "build_date" : "2022-05-18T18:04:20.964345128Z",
    "build_snapshot" : false,
    "lucene_version" : "8.11.1",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
~~

# UPLOAD to GitHub Container Registry

Before you upload your image, you should put a tag to your image.

1. Find the ID for the Docker image you want to tag.
  ~~~
  docker images
  ~~~
2. Tag your Docker image using the image ID and your desired image name and hosting destination.
  ~~~
  docker tag 38f737a91f39 ghcr.io/shirasagi/elasticsearch:latest
  ~~~


Then run these commands to upload the new container image to [GitHub Container Registry](https://github.com/orgs/shirasagi/packages):

~~~bash
export CR_PAT=YOUR_TOKEN
echo $CR_PAT | docker login ghcr.io -u USERNAME --password-stdin
docker push ghcr.io/shirasagi/elasticsearch
~~~

YOUR_TOKEN is a token created on the github your account page with "write:packages" scope, and USERNAME is your github account id.

# SHIRASAGI との統合

## シラサギの設定

### CMS

1. 「サイト設定」 - 「サイト情報」の「サイト内検索設定」に全文検索サーバーを設定する項目があるので、そこに localhost:9200 を設定します。
2. コンソールから次のコマンドを実行します。

~~~shell
$ bin/rake cms:es:ingest:init site=www
$ bin/rake cms:es:create_indexes site=www
$ bin/rake cms:es:feed_all site=www
~~~

### GWS

1. 「設定」 - 「組織情報」の「全文検索」に、CMS と同様に全文検索サーバーを設定する項目があるので、そこに localhost:9200 を設定しします。そして、「組織情報」の「メニュー設定」で全文検索を「表示」に設定します。
2. コンソールから次のコマンドを実行します。

~~~shell
$ bin/rake gws:es:ingest:init site=シラサギ市
$ bin/rake gws:es:create_indexes site=シラサギ市
$ bin/rake gws:es:feed_all site=シラサギ市
~~~

詳しくは[SHIRASAGI 開発マニュアルの Elasticsearch & Fess のインストール](https://shirasagi.github.io/installation/elasticsearch_and_fess.html)を参照してください。
