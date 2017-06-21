//
//  FileUtils.h
//  yinji
//
//  Created by 印记 on 16/6/27.
//  Copyright © 2016年 印记. All rights reserved.
//

#ifndef FileUtils_h
#define FileUtils_h

@interface FileUtils : NSObject
 
+(NSString*) getHomeDirectory;
+(NSString*) getDocumentsDirectory;
+(NSString*) getCachesDirectory;
+(NSString*) getTmpDirectory;


+(BOOL) isFileExist:(NSString*) filePath;
+(NSData*) getFileContent:(NSString*) filePath;
+(BOOL) writeFileContent:(NSString*) filePath :(NSData*) data;
+(BOOL) copyFileToFile:(NSString*) fromFile :(NSString*) toFile;
+(BOOL) moveFileToFile:(NSString*) fromFile :(NSString*) toFile;
+(BOOL) deleteFile:(NSString*) filePath;

+(BOOL) isDirExist:(NSString*) filePath;
+(BOOL) createPath:(NSString*) path;
+(BOOL) deletePath:(NSString*) path;

+(unsigned long) getFileSize:(NSString*) filePath;
+(NSDate*) getFileModifyTime:(NSString*) filePath;

+(NSArray*) getFileListFromPath:(NSString*) filePath;
+(NSArray*) getDirListFromPath:(NSString*) filePath;

@end

#endif /* FileUtils_h */
