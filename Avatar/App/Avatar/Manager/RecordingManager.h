@import UIKit;
@class RecordingManager;
@import ReplayKit;
@import AVFoundation;

@protocol RecordingManagerDelegate <NSObject>
- (void)recordingManager:(RecordingManager *)coordinator recordingDidFailWithError:(NSError *)error;
- (void)recordingManager:(RecordingManager *)coordinator wantsToPresentRecordingPreviewWithController:(__kindof UIViewController *)previewController;
- (void)recordingManagerDidFinishRecording:(RecordingManager *)coordinator;
@end

@interface RecordingManager : NSObject
- (void)startRecordingWithAudio:(BOOL)shouldCaptureAudio frontCameraPreview:(BOOL)shouldCaptureFrontCamera;
- (void)stopRecording;
@property (nonatomic, weak) id<RecordingManagerDelegate> delegate;
@property (nonatomic, readonly, getter=isRecording) BOOL recording;
@property (nonatomic, readonly) NSURL *videoURL;
@end
