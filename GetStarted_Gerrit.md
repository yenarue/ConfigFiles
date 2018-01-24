Gerrit 설치하기
=======
* OS : Linux (Ubuntu)
* SSH : ssh (open-ssh아님)

# 사전준비

## JDK7 이상

## Database
* Default : `H2`

## Apache2 설치
```bash
$ sudo apt-get install apache2
$ sudo apt-get install apache2-bin
$ sudo apt-get install apache2-utils
$ sudo a2enmod proxy
$ sudo a2enmod proxy_http
$ sudo service apache2 restart
```
기존 블로그에서 소개하는 대로 `libapache2-mod-proxy-html`을 설치하려고하면 `not found` 에러가 발생한다. 그러하다. 변경되었다. 라이브러리에서 정식 `apache2-bin`으로 변경되었으니 참고하도록 하자.
~~내 삽질의 시간들은...ㅠㅠ~~

## User 추가
Gerrit 설치를 위해 새로운 계정을 추가한다.

```bash
$ sudo adduser gerrit
$ su gerrit
$ mkdir ~/Downloads
$ cd ~/Downloads
```

# Gerrit

## 설치
[Gerrit Release Index Page](https://gerrit-releases.storage.googleapis.com/index.html) 에서 최신버전 찾아 설치

```bash
$ wget https://www.gerritcodereview.com/download/gerrit-2.15-rc2.war

# gerrit 초기화
$ java -jar gerrit-2.15-rc2.war init -d ~/opt/gerrit

Using secure store: com.google.gerrit.server.securestore.DefaultSecureStore

*** Gerrit Code Review 2.15-rc2 ***


*** Git Repositories ***

Location of Git repositories   [/home/gerrit/repository]:

*** SQL Database ***

Database server type           [h2]:

*** Index ***

Type                           [lucene/?]:

The index must be rebuilt before starting Gerrit:
  java -jar gerrit.war reindex -d site_path

*** User Authentication ***

Authentication method          [http/?]:
Get username from custom HTTP header [Y/n]?
Username HTTP header           [SM_USER]:
SSO logout URL                 [http://aa:aa@gerrit.appbee.com/login/]:
Enable signed push support     [y/N]?

*** Review Labels ***

Install Verified label         [y/N]?

*** Email Delivery ***

SMTP server hostname           [smtp.gmail.com]:
SMTP server port               [465]:
SMTP encryption                [ssl/?]:
SMTP username                  [계정@gmail.com]:
계정@gmail.com s password  :
              confirm password :

*** Container Process ***

Run as                         [gerrit]:
Java runtime                   [/usr/lib/jvm/java-8-oracle/jre]:
Upgrade /home/gerrit/opt/gerrit/bin/gerrit.war [Y/n]?
Copying gerrit-2.15-rc2.war to /home/gerrit/opt/gerrit/bin/gerrit.war

*** SSH Daemon ***

Listen on address              [*]:
Listen on port                 [29418]:

*** HTTP Daemon ***

Behind reverse proxy           [Y/n]?
Proxy uses SSL (https://)      [y/N]?
Subdirectory on proxy server   [/]:
Listen on address              [gerrit.appbee.com]:
Listen on port                 [8081]:
Canonical URL                  [http://gerrit.appbee.com]:

*** Cache ***

Delete cache file /home/gerrit/opt/gerrit/cache/diff_summary.lock.db [y/N]?
Delete cache file /home/gerrit/opt/gerrit/cache/web_sessions.lock.db [y/N]?
Delete cache file /home/gerrit/opt/gerrit/cache/conflicts.lock.db [y/N]?
Delete cache file /home/gerrit/opt/gerrit/cache/mergeability.lock.db [y/N]?
Delete cache file /home/gerrit/opt/gerrit/cache/oauth_tokens.lock.db [y/N]?
Delete cache file /home/gerrit/opt/gerrit/cache/diff_intraline.lock.db [y/N]?
Delete cache file /home/gerrit/opt/gerrit/cache/change_kind.lock.db [y/N]?
Delete cache file /home/gerrit/opt/gerrit/cache/diff.lock.db [y/N]?
Delete cache file /home/gerrit/opt/gerrit/cache/git_tags.lock.db [y/N]?

*** Plugins ***

Installing plugins.
Install plugin commit-message-length-validator version v2.15-rc2 [y/N]?
Install plugin download-commands version v2.15-rc2 [y/N]?
Install plugin hooks version v2.15-rc2 [y/N]?
Install plugin replication version v2.15-rc2 [y/N]?
Install plugin reviewnotes version v2.15-rc2 [y/N]?
Install plugin singleusergroup version v2.15-rc2 [y/N]?
Initializing plugins.
No plugins found with init steps.

*** Experimental features ***

Enable any experimental features [y/N]?
```

## 설정
게릿쪽 `gerrit.config` 파일 내용

`logoutUrl`은 로그아웃 버그로 인해 로그인 불가능한 계정으로 아래와 같이 강제 설정해줘야 함. [참고자료](http://lazyrodi.github.io/2016/08/14/2016-08-14-etc-gerrit-installation/)
```bash
[gerrit]
        basePath = /home/gerrit/repository
        serverId = 7482b462-2e32-49f5-9bf6-23dda94e2071
        canonicalWebUrl = http://gerrit.appbee.com
[database]
        type = h2
        database = /home/gerrit/opt/gerrit/db/ReviewDB
[index]
        type = LUCENE
[auth]
        type = HTTP
        logoutUrl = http://aa:aa@gerrit.appbee.com/login/
[receive]
        enableSignedPush = false
[sendemail]
        smtpServer = smtp.gmail.com
        smtpServerPort = 587
        smtpEncryption = SSL
        smtpUser = [smtpUserEmail]
        smtpPass = [password]
        sslVerify = false
[container]
        user = gerrit
        javaHome = /usr/lib/jvm/java-8-oracle/jre
[sshd]
        listenAddress = *:29418
[httpd]
        listenUrl = proxy-http://gerrit.appbee.com:8081/
[cache]
        directory = cache
```

아파치쪽 게릿 설정
`gerrit.conf`
```xml
<VirtualHost gerrit.appbee.com:80>
    ServerName localhost

    ProxyRequests Off 
    ProxyVia Off 
    ProxyPreserveHost On
    <Proxy *>
        Order deny,allow
        Allow from all
    </Proxy>
    <Location /login/>
        AuthType Basic
        AuthName "Gerrit Code Review"
        Require valid-user
        AuthUserFile /home/gerrit/opt/gerrit/etc/passwords
    </Location>

    AllowEncodedSlashes On
    ProxyPass / http://gerrit.appbee.com:8081/
#    ProxyPassReverese / http://gerrit.appbee.com:8081/
</VirtualHost>
```
## 사용자 추가
```bash
$ htpasswd /home/gerrit/opt/gerrit/etc/passwords "admin"
$ htpasswd /home/gerrit/opt/gerrit/etc/passwords "user"
```

## 실행
### apache 재실행
```bash
# apache config가 문법적으로 잘 설정되었는지 체크 (Syntax Check)
$ sudo apachectl configtest
# apache 재시작
$ sudo service apache2 restart
```
### gerrit 재실행
```bash
$ gerrit디렉토리/bin/gerrit.sh restart
```

## 사용자 로그인
gerrit을 실행한 이후 `http://gerrit.appbee.com` 으로 접속하면 인증 화면이 나타난다. 앞서 추가했던 사용자 정보 입력 후 로그인하면 정보 입력창이 뜨는데...

* 로그인 후 설정 참고 :  http://d2.naver.com/helloworld/2930540

## ssh로 접속
```bash
$ ssh [id]@gerrit.appbee.com -p 29418

  ****    Welcome to Gerrit Code Review    ****

  Hi Yena Kim, you have successfully connected over SSH.

  Unfortunately, interactive shells are disabled.
  To clone a hosted Git repository, use:

  git clone ssh://[id]@gerrit.appbee.com:29418/REPOSITORY_NAME.git

Connection to gerrit.appbee.com closed.
```
ssh연결은 잘 되는데 왜 갑자기 Connection이 close되는지는 모르겠다. 더 알아봐야 함....ㅠㅠ

## 프로젝트 생성하기
http://pseg.or.kr/pseg/infoinstall/1815

일단 현재 상태로는 smtp가 정상적으로 설정되지 않아 프로젝트 생성이 불가능하다..... 내일 이어서 해보는걸로...
