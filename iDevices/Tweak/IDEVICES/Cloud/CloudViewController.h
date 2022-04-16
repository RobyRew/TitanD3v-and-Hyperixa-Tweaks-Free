#import <TitanD3vUniversal/TitanD3vUniversal.h>
#import "Colour-Scheme.h"
#import "DataManager.h"
#import "CDHeaderView.h"
#import "MemoryView.h"
#import "CloudButton.h"
#import "DeviceUsageView.h"

@interface CloudViewController : UIViewController
@property (nonatomic, retain) CDHeaderView *headerView;
@property (nonatomic, retain) UIView *containerView;
@property (nonatomic, retain) MemoryView *toggleView;
@property (nonatomic, retain) MemoryView *dateView;
@property (nonatomic, retain) UILabel *statusLabel;
@property (nonatomic, retain) UISwitch *toggleSwitch;
@property (nonatomic, retain) CloudButton *cloudButton;
@property (nonatomic, retain) DeviceUsageView *backupProgressView;
@property (nonatomic, retain) NSTimer *icloudTimer;
@end

@interface MBManager : NSObject
-(id)init;
-(id)_init;
-(id)backupState;
-(id)getBackupListWithError:(id*)arg1 ;
@end

@interface MBStateInfo : NSObject
@property (assign,nonatomic) int state;
@property (assign,nonatomic) BOOL isBackground;
@property (assign,nonatomic) BOOL isCloud;
@property (assign,nonatomic) float progress;
@property (assign,nonatomic) unsigned long long estimatedTimeRemaining;
@property (nonatomic,retain) NSDate * date;
@property (nonatomic,retain) NSError * error;
@property (nonatomic,retain) NSMutableArray * errors;
@end

@interface MBManagerClient : NSObject
-(void)cancel;
-(id)backupList;
-(id)backupState;
-(id)dateOfLastBackup;
-(BOOL)isBackupEnabled;
-(id)nextBackupSizeInfo;
-(void)setBackupEnabled:(BOOL)arg1 ;
-(unsigned long long)nextBackupSize;
-(BOOL)startBackupWithError:(id*)arg1 ;
-(BOOL)startBackupWithOptions:(id)arg1 error:(id*)arg2 ;
@end
