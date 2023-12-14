# 音乐播放器

https://www.himiku.com/archives/navidrome.html

``` xml
version: "3"
services:
  navidrome:
    image: deluan/navidrome:latest
    container_name: navidrome
    user: 1000:100 #用户id，详细解释见后文
    ports:
      - 4533:4533 #左侧端口如有冲突，可随意修改
    volumes:
      - /DATA/AppData/navidrome/data:/data #数据路径
      - /DATA/Music:/music:ro #音乐路径
    environment:
      #程序默认语言
      - ND_DEFAULTLANGUAGE=zh-Hans
      #启用GRAVATAR头像
      - ND_ENABLEGRAVATAR=true
      #关闭转码，如需要转码请设置为true
      - ND_ENABLETRANSCODINGCONFIG=false
      #SPOTIFY相关
      # - ND_SPOTIFY_ID=
      # - ND_SPOTIFY_SECRET=
      #LAST.FM相关
      # - ND_LASTFM_LANGUAGE=zh
      # - ND_LASTFM_APIKEY=
      # - ND_LASTFM_SECRET=
      #PROXY相关
      # - HTTP_PROXY=http://proxy:port
      # - HTTPS_PROXY=http://proxy:port
    restart: unless-stopped
    ```