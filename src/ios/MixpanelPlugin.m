#import "MixpanelPlugin.h"

@implementation MixpanelPlugin

@synthesize notificationMessage;
@synthesize isInline;

@synthesize callbackId;
@synthesize notificationCallbackId;


// MIXPANEL API


-(void)alias:(CDVInvokedUrlCommand*)command;
{
    CDVPluginResult* pluginResult = nil;
    Mixpanel* mixpanelInstance = [Mixpanel sharedInstance];
    NSArray* arguments = command.arguments;
    NSString* aliasId = [arguments objectAtIndex:0];
    NSString* originalId = [arguments objectAtIndex:1];

    if (mixpanelInstance == nil)
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Mixpanel not initialized"];
    }
    else if(aliasId == nil || 0 == [aliasId length])
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Alias id missing"];
    }
    else
    {
        if(originalId == (id)[NSNull null] || 0 == [originalId length || [originalId  isEqual: @"null"])
        {
            originalId = mixpanelInstance.distinctId;
        }
        [mixpanelInstance createAlias:aliasId forDistinctID:originalId];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


-(void)flush:(CDVInvokedUrlCommand*)command;
{
    CDVPluginResult* pluginResult = nil;
    Mixpanel* mixpanelInstance = [Mixpanel sharedInstance];

    if (mixpanelInstance == nil)
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Mixpanel not initialized"];
    }
    else
    {
        [mixpanelInstance flush];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


-(void)identify:(CDVInvokedUrlCommand*)command;
{
    CDVPluginResult* pluginResult = nil;
    Mixpanel* mixpanelInstance = [Mixpanel sharedInstance];
    NSArray* arguments = command.arguments;
    NSString* distinctId = [arguments objectAtIndex:0];

    if (mixpanelInstance == nil)
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Mixpanel not initialized"];
    }
    else
    {
        if(distinctId == nil || 0 == [distinctId length])
        {
            distinctId = mixpanelInstance.distinctId;
        }
        [mixpanelInstance identify:distinctId];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:distinctId];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

-(void)get_distinct_id:(CDVInvokedUrlCommand*)command;
{
    CDVPluginResult* pluginResult = nil;
    Mixpanel* mixpanelInstance = [Mixpanel sharedInstance];
    NSString* distinctId = mixpanelInstance.distinctId;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:distinctId];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

-(void)init:(CDVInvokedUrlCommand*)command;
{
    CDVPluginResult* pluginResult = nil;
    NSArray* arguments = command.arguments;
    NSString* token = [arguments objectAtIndex:0];

    if (token == nil || 0 == [token length])
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Token is missing"];
    }
    else
    {
        [Mixpanel sharedInstanceWithToken:token];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


-(void)reset:(CDVInvokedUrlCommand*)command;
{
    CDVPluginResult* pluginResult = nil;
    Mixpanel* mixpanelInstance = [Mixpanel sharedInstance];

    if (mixpanelInstance == nil)
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Mixpanel not initialized"];
    }
    else
    {
        [mixpanelInstance reset];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


-(void)track:(CDVInvokedUrlCommand*)command;
{
    CDVPluginResult* pluginResult = nil;
    Mixpanel* mixpanelInstance = [Mixpanel sharedInstance];
    NSArray* arguments = command.arguments;
    NSString* eventName = [arguments objectAtIndex:0];
    NSDictionary* eventProperties = [command.arguments objectAtIndex:1];

    if (mixpanelInstance == nil)
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Mixpanel not initialized"];
    }
    else if(eventName == nil || 0 == [eventName length])
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Event name missing"];
    }
    else
    {
        [mixpanelInstance track:eventName properties:eventProperties];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


// PEOPLE API


-(void)people_identify:(CDVInvokedUrlCommand*)command;
{
    // ios sdk doesnt have separate people identify method
    // just call the normal identify call
    [self identify:command];
}


-(void)people_set:(CDVInvokedUrlCommand*)command;
{
    CDVPluginResult* pluginResult = nil;
    Mixpanel* mixpanelInstance = [Mixpanel sharedInstance];
    NSArray* arguments = command.arguments;
    NSDictionary* peopleProperties = [arguments objectAtIndex:0];

    if (mixpanelInstance == nil)
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Mixpanel not initialized"];
    }
    else if(peopleProperties == nil || 0 == [peopleProperties count])
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"missing people properties object"];
    }
    else
    {
        [mixpanelInstance.people set:peopleProperties];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

-(void)people_increment:(CDVInvokedUrlCommand*)command;
{
    CDVPluginResult* pluginResult = nil;
    Mixpanel* mixpanelInstance = [Mixpanel sharedInstance];

    if (mixpanelInstance == nil)
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Mixpanel not initialized"];
    }

    NSArray* arguments = command.arguments;
    NSNumber* increment_type = (NSNumber*)[arguments objectAtIndex:0];

    NSNumber* default_action = [NSNumber numberWithInt:1];
    NSNumber* object_action = [NSNumber numberWithInt:2];

    if([increment_type isEqualToNumber:default_action]){
        [mixpanelInstance.people increment:[arguments objectAtIndex:1] by:[arguments objectAtIndex:2]];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }else if([increment_type isEqualToNumber:object_action]){
        [mixpanelInstance.people increment:[arguments objectAtIndex:1]];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

-(void)setShowNotificationOnActive:(CDVInvokedUrlCommand *)command;
{
    Mixpanel *mixpanel = [Mixpanel sharedInstance];

    BOOL showNotificationOnActive = [[command.arguments objectAtIndex:0] boolValue];

    mixpanel.showNotificationOnActive = showNotificationOnActive;

    [self successWithCallbackId:command.callbackId];
}

-(void)showNotification:(CDVInvokedUrlCommand *)command;
{
    Mixpanel *mixpanel = [Mixpanel sharedInstance];

    [mixpanel showNotification];

    [self successWithCallbackId:command.callbackId];
}

-(void)showNotificationWithID:(CDVInvokedUrlCommand *)command;
{
    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    NSUInteger ID = (NSUInteger)[command.arguments objectAtIndex:0];

    [mixpanel showNotificationWithID:ID];

    [self successWithCallbackId:command.callbackId];
}

-(void)setShowSurveyOnActive:(CDVInvokedUrlCommand *)command;
{
    Mixpanel *mixpanel = [Mixpanel sharedInstance];

    BOOL showSurveyOnActive = [[command.arguments objectAtIndex:0] boolValue];

    mixpanel.showNotificationOnActive = showSurveyOnActive;

    [self successWithCallbackId:command.callbackId];
}

-(void)showSurvey:(CDVInvokedUrlCommand *)command;
{
    Mixpanel *mixpanel = [Mixpanel sharedInstance];

    [mixpanel showSurvey];

    [self successWithCallbackId:command.callbackId];
}

-(void)showSurveyWithID:(CDVInvokedUrlCommand *)command;
{
    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    NSUInteger ID = (NSUInteger)[command.arguments objectAtIndex:0];

    [mixpanel showSurveyWithID:ID];

    [self successWithCallbackId:command.callbackId];
}

- (void)unregister:(CDVInvokedUrlCommand*)command;
{
    self.callbackId = command.callbackId;

    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    [self successWithMessage:@"unregistered"];
}

- (void)register:(CDVInvokedUrlCommand*)command;
{
    self.callbackId = command.callbackId;

    NSMutableDictionary* options = [command.arguments objectAtIndex:0];

    UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeNone;
    id badgeArg = [options objectForKey:@"badge"];
    id soundArg = [options objectForKey:@"sound"];
    id alertArg = [options objectForKey:@"alert"];

    if ([badgeArg isKindOfClass:[NSString class]])
    {
        if ([badgeArg isEqualToString:@"true"])
        {
            notificationTypes |= UIRemoteNotificationTypeBadge;
        }
    }
    else if ([badgeArg boolValue])
    {
        notificationTypes |= UIRemoteNotificationTypeBadge;
    }

    if ([soundArg isKindOfClass:[NSString class]])
    {
        if ([soundArg isEqualToString:@"true"])
        {
            notificationTypes |= UIRemoteNotificationTypeSound;
        }
    }
    else if ([soundArg boolValue])
    {
        notificationTypes |= UIRemoteNotificationTypeSound;
    }

    if ([alertArg isKindOfClass:[NSString class]])
    {
        if ([alertArg isEqualToString:@"true"])
        {
            notificationTypes |= UIRemoteNotificationTypeAlert;
        }
    }
    else if ([alertArg boolValue])
    {
        notificationTypes |= UIRemoteNotificationTypeAlert;
    }

    if (notificationTypes == UIRemoteNotificationTypeNone)
    {
        NSLog(@"PushPlugin.register: Push notification type is set to none");
    }

    isInline = NO;

    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];

    // if there is a pending startup notification
    if (notificationMessage)
    {
        [self notificationReceived];  // go ahead and process it
    }
}

- (void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"withString:@""]
                        stringByReplacingOccurrencesOfString:@">" withString:@""]
                       stringByReplacingOccurrencesOfString: @" " withString: @""];

    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    [mixpanel.people addPushDeviceToken:deviceToken];

    [self successWithMessage:token];
}

- (void)didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [self failWithMessage:@"" withError:error];
}

- (void)notificationReceived {
    if (notificationMessage)
    {
        NSMutableString *jsonStr = [NSMutableString stringWithString:@"{"];

        [self parseDictionary:notificationMessage intoJSON:jsonStr];

        if (isInline)
        {
            [jsonStr appendFormat:@"foreground:\"%d\"", 1];
            isInline = NO;
        } else
        {
            [jsonStr appendFormat:@"foreground:\"%d\"", 0];
        }

        [jsonStr appendString:@"}"];

        NSLog(@"Msg: %@", jsonStr);

        NSString *js = [NSString stringWithFormat:@"cordova.fireDocumentEvent('mixpanel.push', %@);", jsonStr];
        [self.commandDelegate evalJs:js scheduledOnRunLoop:NO];

        self.notificationMessage = nil;
    }
}

// reentrant method to drill down and surface all sub-dictionaries' key/value pairs into the top level json
-(void)parseDictionary:(NSDictionary *)inDictionary intoJSON:(NSMutableString *)jsonString
{
    NSArray         *keys = [inDictionary allKeys];
    NSString        *key;

    for (key in keys)
    {
        id thisObject = [inDictionary objectForKey:key];

        if ([thisObject isKindOfClass:[NSDictionary class]])
        {
            [self parseDictionary:thisObject intoJSON:jsonString];
        }
        else if ([thisObject isKindOfClass:[NSString class]])
        {
            [jsonString appendFormat:@"\"%@\":\"%@\",",
             key,
             [[[[inDictionary objectForKey:key]
                stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"]
               stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""]
              stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"]];
        }
        else {
            [jsonString appendFormat:@"\"%@\":\"%@\",", key, [inDictionary objectForKey:key]];
        }
    }
}

- (void)setApplicationIconBadgeNumber:(CDVInvokedUrlCommand *)command {
    self.callbackId = command.callbackId;

    NSMutableDictionary* options = [command.arguments objectAtIndex:0];
    int badge = [[options objectForKey:@"badge"] intValue] ?: 0;

    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badge];

    [self successWithMessage:[NSString stringWithFormat:@"app badge count set to %d", badge]];
}

// CALLBACK

-(void)successWithCallbackId:(NSString *)theCallbackId;
{
    [self successWithCallbackId:theCallbackId message:@""];
}

-(void)successWithCallbackId:(NSString *)theCallbackId message:(NSString *)message;
{
    self.callbackId = theCallbackId;
    [self successWithMessage:message];
}

-(void)successWithMessage:(NSString *)message
{
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:message];

    [self.commandDelegate sendPluginResult:commandResult callbackId:self.callbackId];
}

-(void)failWithMessage:(NSString *)message withError:(NSError *)error
{
    NSString        *errorMessage = (error) ? [NSString stringWithFormat:@"%@ - %@", message, [error localizedDescription]] : message;
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:errorMessage];

    [self.commandDelegate sendPluginResult:commandResult callbackId:self.callbackId];
}

@end
