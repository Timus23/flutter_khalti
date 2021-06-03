#import "FlutterKhaltiPlugin.h"
#if __has_include(<flutter_khalti/flutter_khalti-Swift.h>)
#import <flutter_khalti/flutter_khalti-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_khalti-Swift.h"
#endif

@implementation FlutterKhaltiPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterKhaltiPlugin registerWithRegistrar:registrar];
}
@end
