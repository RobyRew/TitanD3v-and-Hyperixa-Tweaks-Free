#import "RecordingManager.h"

@interface RecordingManager () <RPPreviewViewControllerDelegate>
@property (nonatomic, strong) RPScreenRecorder *recorder;
@property (nonatomic, assign, getter=isRecording) BOOL recording;
@property (nonatomic, strong) AVAssetWriter *assetWriter;
@property (nonatomic, strong) AVAssetWriterInput *videoInput;
@property (nonatomic, strong) AVAssetWriterInput *micInput;
@property (nonatomic, strong) AVAssetWriterInput *appInput;
@property (nonatomic, assign) BOOL videoSessionStarted;
@property (nonatomic, assign) BOOL micSessionStarted;
@property (nonatomic, assign) BOOL appSessionStarted;
@property (nonatomic, assign) BOOL isMicEnabled;
@end


@implementation RecordingManager

+ (BOOL)shouldUseDumbRecordingMode {
    return NO;
}


- (void)startRecordingWithAudio:(BOOL)shouldCaptureAudio frontCameraPreview:(BOOL)shouldCaptureFrontCamera {
    
    self.isMicEnabled = shouldCaptureAudio;
    
    if (!self.recorder) {
        self.recorder = [RPScreenRecorder sharedRecorder];
        self.recorder.microphoneEnabled = shouldCaptureAudio;
        self.recorder.cameraEnabled = shouldCaptureFrontCamera;
    }
    
    if ([RecordingManager shouldUseDumbRecordingMode]) {
        [self _startDumbRecording];
    } else {
        [self _startSmartRecording];
    }
}


- (void)stopRecording {
    if ([RecordingManager shouldUseDumbRecordingMode]) {
        [self _stopDumbRecording];
    } else {
        [self _stopSmartRecordingWithError:nil];
    }
}


- (void)_startDumbRecording {
    
    __weak typeof(self) weakSelf = self;
    [self.recorder startRecordingWithHandler:^(NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                weakSelf.recording = YES;
                return;
            }
            
            [weakSelf.delegate recordingManager:weakSelf recordingDidFailWithError:error];
        });
    }];
}


- (void)_stopDumbRecording {
    
    __weak typeof(self) weakSelf = self;
    [self.recorder stopRecordingWithHandler:^(RPPreviewViewController * _Nullable previewViewController, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.recording = NO;
            
            if (error || !previewViewController) {
                [weakSelf.delegate recordingManager:weakSelf recordingDidFailWithError:error];
            } else {
                previewViewController.previewControllerDelegate = weakSelf;
                [weakSelf.delegate recordingManager:weakSelf wantsToPresentRecordingPreviewWithController:previewViewController];
            }
        });
    }];
}


- (NSURL *)_recordingURL {
    
    NSString *basePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *path = [basePath stringByAppendingPathComponent:@"Recordings"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *fileName = [NSString stringWithFormat:@"Avatar_%.0f.mp4", [NSDate date].timeIntervalSince1970];
    
    NSURL *url = [NSURL fileURLWithPath:[NSString pathWithComponents:@[path, fileName]]];
 
    return url;
}


- (void)_startSmartRecording {

    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"ASDemoMode"]) {
        self.recording = YES;
        return;
    }
    
    NSError *writerError;
    self.assetWriter = [AVAssetWriter assetWriterWithURL:[self _recordingURL] fileType:AVFileTypeQuickTimeMovie error:&writerError];
    
    NSDictionary <NSString *, id> *aperture = @{AVVideoCleanApertureWidthKey: @(1024), AVVideoCleanApertureHeightKey: @(1024), AVVideoCleanApertureVerticalOffsetKey: @(10), AVVideoCleanApertureHorizontalOffsetKey: @(10)};
    
    NSDictionary <NSString *, id> *aspectRatio = @{AVVideoPixelAspectRatioVerticalSpacingKey: @1, AVVideoPixelAspectRatioHorizontalSpacingKey: @1};
    
    NSDictionary <NSString *, id> *compressionSettings = @{AVVideoPixelAspectRatioKey: aspectRatio, AVVideoCleanApertureKey: aperture};
    
    NSDictionary <NSString *, id> *videoSettings = @{AVVideoCompressionPropertiesKey: compressionSettings, AVVideoCodecKey: AVVideoCodecTypeHEVC, AVVideoWidthKey: @(1024), AVVideoHeightKey: @(1024), AVVideoScalingModeKey: AVVideoScalingModeResizeAspectFill};
    
    NSDictionary <NSString *, id> *micAudioSettings = @{AVFormatIDKey: @(kAudioFormatMPEG4AAC), AVNumberOfChannelsKey: @(2), AVSampleRateKey: @(44100.0), AVEncoderBitRateKey: @(128000)};
    
    NSDictionary <NSString *, id> *appAudioSettings = @{AVFormatIDKey: @(kAudioFormatMPEG4AAC), AVNumberOfChannelsKey: @(2), AVSampleRateKey: @(44100.0),AVEncoderBitRateKey: @(128000)};
    
    self.videoInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:videoSettings];
    self.micInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeAudio outputSettings:micAudioSettings];
    self.appInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeAudio outputSettings:appAudioSettings];
    
    self.videoInput.expectsMediaDataInRealTime = YES;
    self.micInput.expectsMediaDataInRealTime = YES;
    self.appInput.expectsMediaDataInRealTime = YES;
    
    [self.assetWriter addInput:self.videoInput];
    
    if (self.isMicEnabled) [self.assetWriter addInput:self.micInput];
    
    [self.assetWriter addInput:self.appInput];
    
    if (writerError) {
        [self.delegate recordingManager:self recordingDidFailWithError:writerError];
        return;
    }
    
    if (![self.assetWriter startWriting]) {
        [self _stopSmartRecordingWithError:self.assetWriter.error];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [self.recorder startCaptureWithHandler:^(CMSampleBufferRef  _Nonnull sampleBuffer, RPSampleBufferType bufferType, NSError * _Nullable error) {
        if (!CMSampleBufferDataIsReady(sampleBuffer)) return;
        
        if (self.assetWriter.status != AVAssetWriterStatusWriting) return;
        
        switch (bufferType) {
            case RPSampleBufferTypeVideo:
                if (!weakSelf.videoSessionStarted) {
                    weakSelf.videoSessionStarted = YES;
                    [self.assetWriter startSessionAtSourceTime:CMSampleBufferGetPresentationTimeStamp(sampleBuffer)];
                }
                
                if (weakSelf.videoInput.isReadyForMoreMediaData) {
                    [weakSelf.videoInput appendSampleBuffer:sampleBuffer];
                }
                break;
            case RPSampleBufferTypeAudioMic:
                if (!weakSelf.isMicEnabled) break;
                
                if (!weakSelf.micSessionStarted) {
                    weakSelf.micSessionStarted = YES;
                    [self.assetWriter startSessionAtSourceTime:CMSampleBufferGetPresentationTimeStamp(sampleBuffer)];
                }
                
                if (weakSelf.micInput.isReadyForMoreMediaData) {
                    [weakSelf.micInput appendSampleBuffer:sampleBuffer];
                }
                break;
            case RPSampleBufferTypeAudioApp:
                if (!weakSelf.appSessionStarted) {
                    weakSelf.appSessionStarted = YES;
                    [self.assetWriter startSessionAtSourceTime:CMSampleBufferGetPresentationTimeStamp(sampleBuffer)];
                }
                
                if (weakSelf.appInput.isReadyForMoreMediaData) {
                    [weakSelf.appInput appendSampleBuffer:sampleBuffer];
                }
                break;
            default: break;
        }
    } completionHandler:^(NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                [weakSelf.delegate recordingManager:weakSelf recordingDidFailWithError:error];
            } else {
                weakSelf.recording = YES;
            }
        });
    }];
}


- (void)_stopSmartRecordingWithError:(NSError *)inputError {

    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"ASDemoMode"]) {
        self.recording = NO;
        [self.delegate recordingManagerDidFinishRecording:self];
        return;
    }
    
    if (inputError) {
        [self.recorder stopCaptureWithHandler:nil];
        [self.delegate recordingManager:self recordingDidFailWithError:inputError];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [self.recorder stopCaptureWithHandler:^(NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.recording = NO;
            
            if (error) {
                [weakSelf.delegate recordingManager:self recordingDidFailWithError:error];
            }
            
            [weakSelf.assetWriter finishWritingWithCompletionHandler:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.delegate recordingManagerDidFinishRecording:weakSelf];
                });
            }];
        });
    }];
}


- (NSURL *)videoURL {

    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"ASDemoMode"]) {
        return [[NSBundle mainBundle] URLForResource:@"Foxie" withExtension:@"mov"];
    }
    
    return self.assetWriter.outputURL;
}


- (void)previewControllerDidFinish:(RPPreviewViewController *)previewController {
    [previewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


- (void)previewController:(RPPreviewViewController *)previewController didFinishWithActivityTypes:(NSSet<NSString *> *)activityTypes {
    [previewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
