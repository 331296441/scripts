# PT签到脚本

采用python编写，如果使用青龙，则需要安装依赖包,对于玩客云，需要在容器中安装系统软件包，并经过长时间编译


- alpine:
``` shell
apk update && apk add build-base libxml2-dev libxslt-dev musl-dev gcc libxml2
```

- debian:
``` shell
pt-get install libxml2 zlib1g libxml2-dev libxslt-dev gcc zlib1g-dev sudo -y
```

- python
    1. requests
    2. lxml

https://blog.csdn.net/dotastar00/article/details/128869568


``` python
# -- coding: utf-8 --
# @Time    : 2022/10/7 23:28
import requests
from lxml import etree
import time
from random import randint

requests.packages.urllib3.disable_warnings()


def pt_signin(cookie, signin_url):
    session = requests.Session()
    headers = {'cookie': cookie,
               'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36'}
    signin_url = signin_url
    res = session.get(signin_url, headers=headers).text
    html = etree.HTML(res)
    msg = html.xpath(
        '//td[@class="embedded"]/h2/text()|//td[@class="embedded"]//p//text()|//*[@class="embedded"]//*[@class="text"]//text()')
    msg = msg[0] + ',' + ''.join(msg[1:]) + '\n'
    try:
        msg1 = ''.join(html.xpath('//*[@id="outer"]//a/font/text()|//*[@id="outer"]//a/font/span/text()'))
        if "未" in msg1:
            msg += msg1
    except:
        pass
    return msg


if __name__ == '__main__':
    site_ob = [
        {
            # 站点名称，随意
            'website': '',
            # 签到链接，就是那个php地址
            'signin_url': '',
            # 浏览器开发工具寻找
            'cookie': ''
        },
       
    ]
    t = randint(0, 600)
    print(f'延迟{int(t/60)}分{t%60}秒执行任务')
    time.sleep(t)
    for i in site_ob:
        try:
            msg = i['website'] + '\n' + pt_signin(i['cookie'], i['signin_url'])
            if ('签到成功' or '重复') not in msg:
                print(i['website']+' 签到失败')
        except Exception as e:
            print(e)

```
