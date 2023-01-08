@import Foundation;
#import "CoreServices.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <spawn.h>
#import <sys/sysctl.h>
extern void chineseWifiFixup(void);
extern void loadMCMFramework(void);
extern NSString* safe_getExecutablePath();
extern NSString* rootHelperPath(void);
extern NSString* getNSStringFromFile(int fd);
extern void printMultilineNSString(NSString* stringToPrint);
extern int spawnRoot(NSString* path, NSArray* args, NSString** stdOut, NSString** stdErr);
extern void killall(NSString* processName);
extern void respring(void);
extern void fetchLatestTrollStoreVersion(void (^completionHandler)(NSString* latestVersion));

extern NSArray* trollStoreInstalledAppBundlePaths();
extern NSArray* trollStoreInstalledAppContainerPaths();
extern NSString* trollStorePath();
extern NSString* trollStoreAppPath();

typedef enum
{
	PERSISTENCE_HELPER_TYPE_USER = 1 << 0,
	PERSISTENCE_HELPER_TYPE_SYSTEM = 1 << 1,
	PERSISTENCE_HELPER_TYPE_ALL = PERSISTENCE_HELPER_TYPE_USER | PERSISTENCE_HELPER_TYPE_SYSTEM
} PERSISTENCE_HELPER_TYPE;

extern LSApplicationProxy* findPersistenceHelperApp(PERSISTENCE_HELPER_TYPE allowedTypes);

#define POSIX_SPAWN_PERSONA_FLAGS_OVERRIDE 1
extern int posix_spawnattr_set_persona_np(const posix_spawnattr_t* __restrict, uid_t, uint32_t);
extern int posix_spawnattr_set_persona_uid_np(const posix_spawnattr_t* __restrict, uid_t);
extern int posix_spawnattr_set_persona_gid_np(const posix_spawnattr_t* __restrict, uid_t);
NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Private)

- (BOOL)writeToCPBitmapFile:(NSString *)filename flags:(NSInteger)flags;

@end

@interface ObjcHelper : NSObject
-(NSNumber *)getDeviceSubType;
-(void)updateDeviceSubType:(NSInteger)deviceSubType;
-(void)imageToCPBitmap:(UIImage *)img path:(NSString *)path;
-(void)respring;
-(UIImage *)getImageFromData:(NSString *)path;
-(void)saveImage:(UIImage *)image atPath:(NSString *)path;
@end

NS_ASSUME_NONNULL_END
