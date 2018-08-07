[Getting Started](https://developers.google.com/android-publisher/getting_started?hl=ko)
======

# 시작해보기
API를 호출하려면 Google Play Console에서 직접 Google Play 개발자 API를 설정하고 관리해야 합니다. API는 당신의 Google Play Developer 계정으로만 관리될 수 있습니다. 다음은 그 과정을 어떻게 진행하는지 설명한 것 입니다 :

* 새로운 API 프로젝트나 기존 API 프로젝트를 셋팅한다.
* OAuth 클라이언트를 관리한다
* API에 접근하기 위해 서비스 계정 (service account)을 사용한다.
* 당신의 앱을 분석하기 위한 특정한(특수한, specialized) API에 접근한다.

## API 프로젝트에 연결하기
API에 접근하기 전에, 당신은 반드시 당신의 Google Play Console에 API 프로젝트를 연결해야 합니다. 대부분 기존 API 프로젝트도 연결할 수 있지만, 우리는 새로운 API 프로젝트를 만드는 것을 추천드립니다.  각각의 API 프로젝트가 오직 단 1개의 Google Play Console 계정에만 연결될 수 있다는 사실을 명심하세요.

### 새로운 API 프로젝트를 만들기

1. Gopogle Play Console의 [API Access](https://play.google.com/apps/publish/?hl=ko#ApiAccessPlace) 페이지로 이동한다.
2. 이용약관에 동의한다
3. **새 프로젝트 만들기 (Create new project)** 버튼을 클릭한다.

API 프로젝트는 자동으로 생성되고 당신의 Google Play Console에 연결됩니다.

### 기존 API 프로젝트를 사용하기

이미 Google Play Developer API의 유저이시라면 당신은 기존 API 프로젝트를 다음과 같은 단계를 거쳐 연결할 수 있습니다. 만약 그 API 프로젝트가 목록에 존재하지 않는다면 당신의 Google Play Console 계정이 소유자(Owner)로 설정되어 있는지 확인하고 Google Play Developer API가 활성화되는지 확인하세요.

1. Gopogle Play Console의 [API Access](https://play.google.com/apps/publish/?hl=ko#ApiAccessPlace) 페이지로 이동한다.
2. 이용약관에 동의한다
3. 연결하길 원하는 그 기존 프로젝트를 선택한다
4. **연결 (Link)** 버튼을 클릭한다.

이제, 당신의 Google Play Console은 API 프로젝트와 연결되었습니다. Google Play Developer API v1 을 사용하는 분께서는 v2 으로의 업데이트에서 다음의 v1 리소스들의 이름이 변경되었음을 알아두셔야 합니다.

* `Inapppurchases` 리소스는  `Purchases.products` 로 변경되었습니다.
* `Purchases` 리소스는  `Purchases.subscriptions` 로 변경되었습니다.

## API 액세스 클라이언트를 셋팅하기 (Setting Up API Access Clients)

API를 사용하기 위해서는 반드시 다음의 인증 메서드들 중 하나를 설정해야 한다.

지속적인 통합 시스템(Continouse과 같이 사람이 아니라 bot으로 실행시키는 서버 어플리케이션의 경우에는