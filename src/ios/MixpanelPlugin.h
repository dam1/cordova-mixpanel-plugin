#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>
#import "Mixpanel.h"


@interface MixpanelPlugin : CDVPlugin
{
    NSDictionary *notificationMessage;
    BOOL    isInline;
    NSString *notificationCallbackId;

    BOOL ready;
}

@property (nonatomic, copy) NSString *callbackId;
@property (nonatomic, copy) NSString *notificationCallbackId;

@property (nonatomic, strong) NSDictionary *notificationMessage;
@property BOOL                          isInline;


// MIXPANEL API


//@see https://mixpanel.com/site_media/doctyl/uploads/iPhone-spec/Classes/Mixpanel/index.html
-(void)alias:(CDVInvokedUrlCommand*)command;
-(void)flush:(CDVInvokedUrlCommand*)command;
-(void)identify:(CDVInvokedUrlCommand*)command;
-(void)init:(CDVInvokedUrlCommand*)command;
-(void)reset:(CDVInvokedUrlCommand*)command;
-(void)track:(CDVInvokedUrlCommand*)command;


// PEOPLE API


-(void)people_identify:(CDVInvokedUrlCommand*)command;
-(void)people_set:(CDVInvokedUrlCommand*)command;

// PUSH API

- (void)unregister:(CDVInvokedUrlCommand*)command;
- (void)register:(CDVInvokedUrlCommand*)command;
- (void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToke;
- (void)didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;
- (void)notificationReceived;


// CALLBACK

-(void)successWithCallbackId:(NSString *)theCallbackId;
-(void)successWithCallbackId:(NSString *)theCallbackId message:(NSString *)message;
-(void)successWithMessage:(NSString *)message;
-(void)failWithMessage:(NSString *)message withError:(NSError *)error;

@end
