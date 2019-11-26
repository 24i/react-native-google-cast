#import "RNGCCastContext.h"
#import "RNGCSessionManager.h"
#import "../types/RCTConvert+GCKCastState.m"

#import <React/RCTBridge.h>
#import <React/RCTConvert.h>
#import <React/RCTEventDispatcher.h>
#import <React/RCTLog.h>

@implementation RNGCCastContext {
  bool hasListeners;
}

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

+ (BOOL)requiresMainQueueSetup {
  return NO;
}

- (instancetype)init {
  if (self = [super init]) {
    [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(castDeviceDidChange:)
             name:kGCKCastStateDidChangeNotification
           object:[GCKCastContext sharedInstance]];
  }
  return self;
}

- (NSDictionary *)constantsToExport {
  return @{
    @"CAST_STATE_CHANGED": CAST_STATE_CHANGED
  };
}

- (NSArray<NSString *> *)supportedEvents {
  return @[
    CAST_STATE_CHANGED
  ];
}

// Will be called when this module's first listener is added.
- (void)startObserving {
  hasListeners = YES;
  // Set up any upstream listeners or background tasks as necessary
  dispatch_async(dispatch_get_main_queue(), ^{
//    [GCKCastContext.sharedInstance.sessionManager addListener:self];
  });
}

// Will be called when this module's last listener is removed, or on dealloc.
- (void)stopObserving {
  hasListeners = NO;
  // Remove upstream listeners, stop unnecessary background tasks
// FIXME: this crashes on (hot) reload
//  [GCKCastContext.sharedInstance.sessionManager removeListener:self];
}

# pragma mark - GCKCastContext methods

RCT_REMAP_METHOD(getCastState,
                 getCastStateWithResolver: (RCTPromiseResolveBlock) resolve
                 rejecter: (RCTPromiseRejectBlock) reject) {
  dispatch_async(dispatch_get_main_queue(), ^{
    GCKCastState state = [GCKCastContext.sharedInstance castState];
    resolve([RCTConvert fromGCKCastState:state]);
  });
}

RCT_REMAP_METHOD(showCastDialog,
                 showCastDialogWithResolver: (RCTPromiseResolveBlock) resolve
                 rejecter: (RCTPromiseRejectBlock) reject) {
  dispatch_async(dispatch_get_main_queue(), ^{
    [GCKCastContext.sharedInstance presentCastDialog];
    resolve(@(YES));
  });
}

RCT_REMAP_METHOD(getRoutes,
                 getRoutesWithResolver: (RCTPromiseResolveBlock) resolve
                 rejecter: (RCTPromiseRejectBlock) reject) {
  dispatch_async(dispatch_get_main_queue(), ^{
     GCKDiscoveryManager manager = [GCKCastContext.sharedInstance discoveryManager];
    //[GCKCastContext.sharedInstance presentCastDialog];
    //NSLog( @"CAST_DEBUG: '%@'", manager );
    resolve(@(YES));
  });
}

RCT_REMAP_METHOD(selectRoute,
                 deviceId:(NSString *)deviceId
                 getRoutesWithResolver: (RCTPromiseResolveBlock) resolve
                 rejecter: (RCTPromiseRejectBlock) reject) {
  dispatch_async(dispatch_get_main_queue(), ^{
     GCKDiscoveryManager manager = [GCKCastContext.sharedInstance discoveryManager];
    //[GCKCastContext.sharedInstance presentCastDialog];
   // NSLog( @"CAST_DEBUG: '%@'", manager );
    resolve(@(YES));
  });
}

RCT_REMAP_METHOD(showExpandedControls,
                 showExpandedControlsWithResolver: (RCTPromiseResolveBlock) resolve
                 rejecter: (RCTPromiseRejectBlock) reject) {
  dispatch_async(dispatch_get_main_queue(), ^{
    [GCKCastContext.sharedInstance presentDefaultExpandedMediaControls];
    resolve(@(YES));
  });
}

RCT_EXPORT_METHOD(showIntroductoryOverlay:(id)options
                  resolver: (RCTPromiseResolveBlock) resolve
                  rejecter: (RCTPromiseRejectBlock) reject) {
  dispatch_async(dispatch_get_main_queue(), ^{
    if (!options[@"once"]) {
      [GCKCastContext.sharedInstance clearCastInstructionsShownFlag];
    }
    
    resolve(@([GCKCastContext.sharedInstance presentCastInstructionsViewControllerOnce]));
  });
}



- (void)castDeviceDidChange:(NSNotification *)notification {
  if (!hasListeners) return;

  GCKCastState state = [GCKCastContext sharedInstance].castState;
  [self sendEventWithName:CAST_STATE_CHANGED
                     body:[RCTConvert fromGCKCastState:state]];
}

- (void) didUpdateDeviceList:{
    GCKDiscoveryManager manager = [GCKCastContext.sharedInstance discoveryManager];
    int deviceCount = [manager deviceCount];
    for (int i = 1; i <= deviceCount; i++)
    {
        NSLog(@"%s", [manager deviceAtIndex:i]);
    }
}

@end
