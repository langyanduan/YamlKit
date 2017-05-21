//
//  main.c
//  libyamlTests
//
//  Created by wufan on 2017/5/21.
//  Copyright © 2017年 atoi. All rights reserved.
//

#include <stdio.h>
#include <yaml.h>
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    // insert code here...
    
    FILE *file = fopen("yaml/Temp.yaml", "rb");
    char buffer[2048] = { 0 };
    size_t nread = 0;
    if (file) {
        while ((nread = fread(buffer, 1, sizeof buffer, file)) > 0)
            fwrite(buffer, 1, nread, stdout);
        if (ferror(file)) {
            /* deal with error */
        }
//        fclose(file);
    }
    
    
    yaml_parser_t parser;
    yaml_document_t document;
    
    yaml_parser_initialize(&parser);
    yaml_parser_set_encoding(&parser, YAML_UTF8_ENCODING);
//    yaml_parser_set_input_file(&parser, file);
    yaml_parser_set_input_string(&parser, (void *)buffer, strlen(buffer));
    
    
    
    
    NSMutableArray *stack = [NSMutableArray array];
    
    int done = 0;
    yaml_event_t event;
    while (!done) {
        if (!yaml_parser_parse(&parser, &event)) {
            // TODO: error
            printf("error!!!\n");
            break;
        }
        
        done = (event.type == YAML_STREAM_END_EVENT);
        
        switch (event.type) {
            case YAML_SCALAR_EVENT:
                printf("YAML_SCALAR_EVENT\n");
                break;
            case YAML_SEQUENCE_START_EVENT:
                printf("YAML_SEQUENCE_START_EVENT\n");
                break;
            case YAML_SEQUENCE_END_EVENT:
                printf("YAML_SEQUENCE_END_EVENT\n");
                break;
            case YAML_MAPPING_START_EVENT:
                printf("YAML_MAPPING_START_EVENT\n");
                break;
            case YAML_MAPPING_END_EVENT:
                printf("YAML_MAPPING_END_EVENT\n");
                break;
            case YAML_ALIAS_EVENT:  // TODO: ?
                printf("YAML_ALIAS_EVENT\n");
                break;
            case YAML_NO_EVENT:
                printf("YAML_NO_EVENT\n");
                break;
            case YAML_STREAM_START_EVENT:
                printf("YAML_STREAM_START_EVENT\n");
                break;
            case YAML_STREAM_END_EVENT:
                printf("YAML_STREAM_END_EVENT\n");
                break;
            case YAML_DOCUMENT_START_EVENT:
                printf("YAML_DOCUMENT_START_EVENT\n");
                break;
            case YAML_DOCUMENT_END_EVENT:
                printf("YAML_DOCUMENT_END_EVENT\n");
                break;
            default:
                printf("default\n");
                break;
        }
        
        yaml_event_delete(&event);
    }
    
    yaml_parser_delete(&parser);
    
    printf("Hello, World!\n");
    return 0;
}
