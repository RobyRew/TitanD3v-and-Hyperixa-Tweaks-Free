#import <AppSupport/CPDistributedMessagingCenter.h>
#import <rocketbootstrap/rocketbootstrap.h>
#import "SMSScheuler.h"
#import "ScheduleManager.h"


@interface SMSScheuler : NSObject{
	CPDistributedMessagingCenter * _messagingCenter;
}
@end

@implementation SMSScheuler

+ (void)load {
	[self sharedInstance];
}

+ (instancetype)sharedInstance {
	static dispatch_once_t once = 0;
	__strong static id sharedInstance = nil;
	dispatch_once(&once, ^{
		sharedInstance = [self new];
	});
	return sharedInstance;
}

- (instancetype)init {
	if ((self = [super init])) {
		_messagingCenter = [CPDistributedMessagingCenter centerNamed:@"com.TitanD3v.SMSScheuler"];
		rocketbootstrap_distributedmessagingcenter_apply(_messagingCenter);

		[_messagingCenter runServerOnCurrentThread];
		[_messagingCenter registerForMessageName:@"SMSScheuler" target:self selector:@selector(sendText:withUserInfo:)];
	}

	return self;
}

- (NSNumber *)sendText:(NSString*)name withUserInfo:(NSDictionary *)vals{
	__block NSNumber* ret_bool = 0;

	IMDaemonController* controller = [%c(IMDaemonController) sharedController];

	void (^processBlock)() = ^{

		if ([controller connectToDaemon]){
			NSString* Message = vals[@"Message"];
			NSString* Phone = vals[@"Phone"];
			NSArray* attachments = vals[@"Attachment"];

			if([Message isEqualToString:@"Write a message..."] && [attachments count] !=0)
				Message = @"Attachment(s)";

			NSAttributedString* text = [[NSAttributedString alloc] initWithString:Message];

			CKConversationList* list = [%c(CKConversationList) sharedConversationList];
			CKConversation* conversation = [list conversationForExistingChatWithGroupID:Phone];
			if (conversation != nil) {
				CKComposition* composition = [%c(CKComposition) composition];

				CKMediaObjectManager* si = [%c(CKMediaObjectManager) sharedInstance];
				for (NSString* obj in attachments) {

					NSURL* file_url = [NSURL fileURLWithPath:obj];
					CKMediaObject* object = [si mediaObjectWithFileURL:file_url filename:nil transcoderUserInfo:@{} attributionInfo:@{} hideAttachment:NO];

					composition = [composition compositionByAppendingMediaObject:object];
				}

				if ([text length] > 0)
					composition = [composition compositionByAppendingText:text];
				IMMessage* message = [conversation messageWithComposition:composition];
				[conversation sendMessage:message newComposition:YES];

			} else {
				IMAccountController *sharedAccountController = [%c(IMAccountController) sharedInstance];
				IMAccount *myAccount = [sharedAccountController activeIMessageAccount];

				if (myAccount == nil)
					myAccount = [sharedAccountController activeSMSAccount];

				__NSCFString *handleId = (__NSCFString *)Phone;
				IMHandle *handle = [[%c(IMHandle) alloc] initWithAccount:myAccount ID:handleId alreadyCanonical:YES];

				IMChatRegistry *registry = [%c(IMChatRegistry) sharedInstance];
				IMChat *chat = [registry chatForIMHandle:handle];

				IMMessage* message;
				if ([[[%c(UIDevice) currentDevice] systemVersion] floatValue] >= 14.0)
					message = [%c(IMMessage) instantMessageWithText:text flags:1048581 threadIdentifier:nil];
				else
					message = [%c(IMMessage) instantMessageWithText:text flags:1048581];

				[chat sendMessage:message];
			}

			ret_bool = @1;
		}
	};

	//[Black NewCodeEnds]
	
	if ([NSThread isMainThread])
		processBlock();
	else
		dispatch_sync(dispatch_get_main_queue(), ^{
			processBlock();
		});

	return ret_bool;
}
@end

%hook IMDaemonController
- (unsigned)_capabilities {
	NSString *process = [[NSProcessInfo processInfo] processName];
	if ([process isEqualToString:@"SpringBoard"] || [process isEqualToString:@"MobileSMS"] || [process isEqualToString:@"Nova"])
		return 17159;
	else
		return %orig;
}

%end


%ctor {
	NSString *bundleID = [[NSBundle mainBundle] bundleIdentifier];
	if ([bundleID isEqualToString:@"com.apple.springboard"])
		[SMSScheuler sharedInstance];
}