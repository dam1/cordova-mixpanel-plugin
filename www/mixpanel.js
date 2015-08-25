'use strict';

var exec = require('cordova/exec'),
    mixpanel = {
        people: {},
        ios: {},
        android:{}
    };


// MIXPANEL API


mixpanel.alias = mixpanel.createAlias = function(alias, originalId, onSuccess, onFail) {
    exec(onSuccess, onFail, 'Mixpanel', 'alias', [alias, originalId]);
};

mixpanel.flush = function(onSuccess, onFail) {
    exec(onSuccess, onFail, 'Mixpanel', 'flush', []);
};

mixpanel.identify = function(id, onSuccess, onFail) {
    exec(onSuccess, onFail, 'Mixpanel', 'identify', [id]);
};

mixpanel.init = function(token, onSuccess, onFail) {
    exec(onSuccess, onFail, 'Mixpanel', 'init', [token]);
};

mixpanel.reset = function(onSuccess, onFail) {
    exec(onSuccess, onFail, 'Mixpanel', 'reset', []);
};

mixpanel.track = function(eventName, eventProperties, onSuccess, onFail) {
    exec(onSuccess, onFail, 'Mixpanel', 'track', [eventName, eventProperties]);
};


// PEOPLE API


mixpanel.people.identify = function(distinctId, onSuccess, onFail) {
    exec(onSuccess, onFail, 'Mixpanel', 'people_identify', [distinctId]);
};

mixpanel.people.set = function(peopleProperties, onSuccess, onFail) {
    exec(onSuccess, onFail, 'Mixpanel', 'people_set', [peopleProperties]);
};

mixpanel.people.increment = function(property, value, onSuccess, onFail){
    var invert = function(){
        onFail = onSuccess;
        onSuccess = value;
    }
    var data = [];
    if(typeof property === 'object'){
        invert();
        data = [2, property];
    } else if(typeof value === 'function'){
        invert();
        data = [1, property, 1];
    } else if(typeof value === 'number'){
        data = [1, property, value];
    }
    exec(onSuccess, onFail, 'Mixpanel', 'people_increment', data);
}
mixpanel.people.track_charge = function(value, datails, onSuccess, onFail){

}

mixpanel.android.initPushHandling = function(projectId, onSuccess, onFail) {
    exec(onSuccess, onFail, 'Mixpanel', 'initialize_handle_push', [projectId]);
};

mixpanel.android.setPushRegistrationId = function(registrationId, onSuccess, onFail) {
    exec(onSuccess, onFail, 'Mixpanel', 'set_push_registration_id', [registrationId]);
};

// IOS NOTIFICATION


mixpanel.ios.setShowNotificationOnActive = function(bool, onSuccess, onFail) {
    return exec(onSuccess, onFail, "Mixpanel", "setShowNotificationOnActive", [bool]);
};

mixpanel.ios.showNotification = function(onSuccess, onFail) {
    return exec(onSuccess, onFail, "Mixpanel", "showNotification", []);
};

mixpanel.ios.showNotificationWithID = function(id, onSuccess, onFail) {
    return exec(onSuccess, onFail, "Mixpanel", "showNotificationWithID", [id]);
};

// Call this to register for push notifications. Content of [options] depends on whether we are working with APNS (iOS) or GCM (Android)
mixpanel.ios.register = function(options, onSuccess, onFail) {
    return exec(onSuccess, onFail, "Mixpanel", "register", [options]);
};

// Call this to unregister for push notifications
mixpanel.ios.unregister = function(options, onSuccess, onFail) {
    return exec(onSuccess, onFail, "Mixpanel", "unregister", [options]);
};

// Call this to set the application icon badge
mixpanel.ios.setApplicationIconBadgeNumber = function(badge, onSuccess, onFail) {
    return exec(onSuccess, onFail, "Mixpanel", "setApplicationIconBadgeNumber", [{
        badge: badge
    }]);
};

mixpanel.ios.setShowSurveyOnActive = function(bool, onSuccess, onFail){
  return exec(onSuccess, onFail, "Mixpanel", "setShowSurveyOnActive", [bool]);
};

mixpanel.ios.showSurvey = function(onSuccess, onFail){
  return exec(onSuccess, onFail, "Mixpanel", "showSurvey", []);
};

mixpanel.ios.showSurveyWithID = function(id, onSuccess, onFail){
  return exec(onSuccess, onFail, "Mixpanel", "showSurveyWithID", [id]);
};

// Exports


module.exports = mixpanel;
