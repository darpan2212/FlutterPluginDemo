#import "DeveloperModulePlugin.h"
#if __has_include(<developer_module/developer_module-Swift.h>)
#import <developer_module/developer_module-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "developer_module-Swift.h"
#endif

@implementation DeveloperModulePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDeveloperModulePlugin registerWithRegistrar:registrar];
}
@end
