#import <UIKit/UIKit.h>

__attribute__((unused)) static NSMutableString *outputForShellCommand(NSString *cmd) {
  FILE *fp;
  char buf[1024];
  NSMutableString* finalRet;
  fp = popen([cmd UTF8String], "r");
  if (fp == NULL) {
    return nil;
  }

  fgets(buf, 1024, fp);
  finalRet = [NSMutableString stringWithUTF8String:buf];
  if(pclose(fp) != 0) {
    return nil;
  }

  return finalRet;
}
