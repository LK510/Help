//
//  FileUtils.m
//  yinji
//
//  Created by 印记 on 16/6/27.
//  Copyright © 2016年 印记. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FileUtils.h"


@implementation FileUtils


+(NSString*) getHomeDirectory{
    NSString* homeDir = NSHomeDirectory();
    return homeDir;
}

+(NSString*) getDocumentsDirectory{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docDir = [paths objectAtIndex:0];
    return docDir;
}

+(NSString*) getCachesDirectory{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* cachesDir = [paths objectAtIndex:0];
    return cachesDir;
}

+(NSString*) getTmpDirectory{
    NSString* tmpDir = NSTemporaryDirectory();
    return tmpDir;
}


+(BOOL) isFileExist:(NSString*) filePath{
    NSFileManager *fm = [NSFileManager defaultManager];
    
    return [fm fileExistsAtPath:filePath];
}

+(NSData*) getFileContent:(NSString*) filePath{
    NSFileManager *fm = [NSFileManager defaultManager];
    return [fm contentsAtPath:filePath];
}

+(BOOL) writeFileContent:(NSString*) toFile :(NSData*) data{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString* toFilePath = [toFile stringByDeletingLastPathComponent];
    if (![self isDirExist:toFilePath]) {
        [self createPath:toFilePath];
    }
    return [fm createFileAtPath:toFile contents:data attributes:nil];
}

+(BOOL) copyFileToFile:(NSString*) fromFile :(NSString*) toFile{
    NSFileManager *fm = [NSFileManager defaultManager];
    //如果来源文件不存在，返回false
    if (![fm fileExistsAtPath:fromFile]) {
        return false;
    }
    //如果目标文件目录不存在，创建
    NSString* toFilePath = [toFile stringByDeletingLastPathComponent];
    if (![self isDirExist:toFilePath]) {
        [self createPath:toFilePath];
    }
    //如果目标文件存在，删除掉目标文件
    if ([fm fileExistsAtPath:toFile]) {
        [fm removeItemAtPath:toFile error:nil];
    }
    return [fm copyItemAtPath:fromFile toPath:toFile error:nil];
}

+(BOOL) moveFileToFile:(NSString*) fromFile :(NSString*) toFile{
    NSFileManager *fm = [NSFileManager defaultManager];
    //如果来源文件不存在，返回false
    if (![fm fileExistsAtPath:fromFile]) {
        return false;
    }
    //如果目标文件目录不存在，创建
    NSString* toFilePath = [toFile stringByDeletingLastPathComponent];
    if (![self isDirExist:toFilePath]) {
        [self createPath:toFilePath];
    }
    //如果目标文件存在，删除掉目标文件
    if ([fm fileExistsAtPath:toFile]) {
        [fm removeItemAtPath:toFile error:nil];
    }
    return [fm moveItemAtPath:fromFile toPath:toFile error:nil];
}

+(BOOL) deleteFile:(NSString*) filePath{
    NSFileManager *fm = [NSFileManager defaultManager];
    return [fm removeItemAtPath:filePath error:nil];
}

+(BOOL) isDirExist:(NSString*) filePath{
    BOOL isDir;
    NSFileManager *fm = [NSFileManager defaultManager];
    if([fm fileExistsAtPath:filePath isDirectory:&isDir]){
        if (isDir) {
            return true;
        }
    }
    return false;
}

+(BOOL) createPath:(NSString*) path{
    NSFileManager *fm = [NSFileManager defaultManager];
    return [fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
}

+(BOOL) deletePath:(NSString*) path{
    NSFileManager *fm = [NSFileManager defaultManager];
    return [fm removeItemAtPath:path error:nil];
}

+(unsigned long) getFileSize:(NSString*) filePath{
    
    unsigned long size = 0;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDictionary *fileAttr = [fm attributesOfItemAtPath:filePath error:NULL];
    if (fileAttr != nil) {
        size = [[fileAttr objectForKey:NSFileSize] unsignedLongValue];
    }
    
    return size;
}

+(NSDate*) getFileModifyTime:(NSString*) filePath{
    
    NSDate* fileModDate;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDictionary *fileAttr = [fm attributesOfItemAtPath:filePath error:NULL];
    if (fileAttr != nil) {
        fileModDate = [fileAttr objectForKey:NSFileModificationDate];
    }
    
    return fileModDate;
}

+(UIImage *) getImageFromURL: (NSString *) imageURL {
    if (imageURL==nil) {
        return nil;
    }
    NSData* imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:imageURL]];
    if (imageData==nil) {
        return nil;
    }
    UIImage* image = [[UIImage alloc] initWithData:imageData];
    return image;
}

+(NSArray*) getFileListFromPath:(NSString*) filePath{
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray* directoryContents = [fm directoryContentsAtPath:filePath];
    
    return directoryContents;
    
}

+(NSArray*) getDirListFromPath:(NSString*) filePath{
    
    NSMutableArray* resultArray = [[NSMutableArray alloc] init];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray* directoryContents = [fm directoryContentsAtPath:filePath];
    for (NSString* path in directoryContents) {
        NSString* checkPath = [filePath stringByAppendingPathComponent:path];
        if ([self isDirExist:checkPath]) {
            [resultArray addObject:checkPath];
        }
    }
    
    return resultArray;
    
}

@end
