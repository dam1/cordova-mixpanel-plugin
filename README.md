
## Cordova Plugin that wraps Mixpanel sdk for android and ios

- [android sdk version 4.5.3](https://github.com/mixpanel/mixpanel-android/tree/v4.5.3)
- [ios sdk version 2.7.2](https://github.com/mixpanel/mixpanel-iphone/tree/v2.7.2)

#### Install

```
cordova plugin add https://github.com/dam1/cordova-mixpanel-plugin.git
```

#### Usage

**window.mixpanel:**

- alias(aliasId, originalId, onSuccess, onFail)
  - also available as ```createAlias```
- flush(onSuccess, onFail)
- identify(distinctId, onSuccess, onFail)
- init(token, onSuccess, onFail)
- reset(onSuccess, onFail)
- track(eventName, eventProperties, onSuccess, onFail)
...

**window.mixpanel.people:**

- identify(distinctId, onSuccess, onFail)
- set(peopleProperties, onSuccess, onFail)
...


**create a file /platform/android/build-extras.gradle**

        dependencies {
            compile "com.mixpanel.android:mixpanel-android:4.6.4"
        }

##### Keywords
mixpanel, plugin cordova, phonegap, ionic, android, ios
