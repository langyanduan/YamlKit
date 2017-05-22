//
//  YAMLSerialization.swift
//  YamlKit
//
//  Created by wufan on 2017/5/21.
//  Copyright © 2017年 atoi. All rights reserved.
//

import Foundation

public class YAMLSerialization {
    
    enum `Error`: Swift.Error {
        case parser
    }
    
    enum `Type` {
        case dictionary
        case array
        case object
    }
    
    public struct ReadingOptions: OptionSet {
        public let rawValue: UInt
        public init(rawValue: UInt) {
            self.rawValue = rawValue
        }
    }
    
    public struct WritingOptions: OptionSet {
        public let rawValue: UInt
        public init(rawValue: UInt) {
            self.rawValue = rawValue
        }
    }
}

extension YAMLSerialization {
    class func object(nodes: [yaml_node_t], node: yaml_node_t) throws -> Any {
        func node_(_ index: Int32) -> yaml_node_t {
            return nodes[Int(index) - 1]
        }
        func object_(_ index: Int32) throws -> Any {
            return try object(nodes: nodes, node: node_(index))
        }
        func string_(_ index: Int32) -> String {
            return String(cString: node_(index).data.scalar.value)
        }
        func scalar_(_ node: yaml_node_t) -> Any {
            let text = String(cString: node.data.scalar.value)
            switch node.data.scalar.style {
            case YAML_PLAIN_SCALAR_STYLE:
                let scanner = Scanner(string: text)
                
                do {
                    var value: Double = 0
                    if scanner.scanDouble(&value) && scanner.scanLocation == text.characters.count {
                        return value
                    }
                }
                do {
                    var value: Int = 0
                    if scanner.scanInt(&value) && scanner.scanLocation == text.characters.count {
                        return value
                    }
                }
                
                switch text {
                case "true", "True", "TRUE", "yes", "Yes", "YES", "on", "On", "ON":
                    return true
                case "false", "False", "FALSE", "no", "No", "NO", "off", "Off", "OFF":
                    return false
                case "~", "null":
                    return NSNull()
                default:
                    break
                }
            default:
                break
            }
            
            return text
        }
        
        switch node.type {
        case YAML_SCALAR_NODE:
            return scalar_(node)
        case YAML_MAPPING_NODE:
            let pairs = node.data.mapping.pairs
            var dict = [String: Any]()
            for pair in UnsafeBufferPointer(start: pairs.start, count: pairs.top - pairs.start) {
                dict[string_(pair.key)] = try object_(pair.value)
            }
            return dict
        case YAML_SEQUENCE_NODE:
            let items = node.data.sequence.items
            var array = [Any]()
            for item in UnsafeBufferPointer(start: items.start, count: items.top - items.start) {
                array.append(try object_(item))
            }
            return array
        default:
            throw Error.parser
        }
    }
}

extension YAMLSerialization {
    public class func yamlObject(with data: Data, options opt: YAMLSerialization.ReadingOptions = []) throws -> Any {
        var parser = yaml_parser_t()
        var event = yaml_event_t()
        var document = yaml_document_t()
        
        yaml_parser_initialize(&parser)
        defer { yaml_parser_delete(&parser) }
        
        yaml_parser_set_encoding(&parser, YAML_UTF8_ENCODING)
        yaml_parser_set_input_string(&parser, data.withUnsafeBytes { $0 }, data.count)
        
        guard yaml_parser_load(&parser, &document) == 1 else {
            throw Error.parser
        }
        defer { yaml_document_delete(&document) }
        
        let node = yaml_document_get_root_node(&document)!
        let nodes = document.nodes
        
        return try object(nodes: Array(UnsafeBufferPointer(start: nodes.start, count: nodes.top - nodes.start)), node: node.pointee)
        
//        var stack: [Any] = []
//        
//        var lastType: Type?
//        var done = false
//        while !done {
//            if yaml_parser_parse(&parser, &event) == 0 {
//                throw Error.parser
//            }
//            defer { yaml_event_delete(&event) }
//            
//            done = event.type == YAML_DOCUMENT_END_EVENT
//            switch event.type {
//            case YAML_SCALAR_EVENT:
//                switch lastType {
//                case .some(.dictionary):    // dictionary's key
//                    break
//                case .some(.object):        // dictionary's value
//                    break
//                case .some(.array):         
//                    break
//                default:
//                    break
//                }
//                break
//            case YAML_SEQUENCE_START_EVENT:
//                stack.append([Any]())
//                break
//            case YAML_MAPPING_START_EVENT:
//                stack.append([String: Any]())
//                break
//            case YAML_SEQUENCE_END_EVENT, YAML_MAPPING_END_EVENT:
//                if stack.count == 1 {
//                    assert(done)
//                    break
//                }
//                assert(stack.count > 1)
//                
//                let obj = stack.popLast()!
//                
//            case YAML_NO_EVENT:             fallthrough
//            case YAML_ALIAS_EVENT:          fallthrough
//            case YAML_STREAM_START_EVENT:   fallthrough
//            case YAML_STREAM_END_EVENT:     fallthrough
//            case YAML_DOCUMENT_START_EVENT: fallthrough
//            case YAML_DOCUMENT_END_EVENT:   fallthrough
//            default:
//                break
//            }
//            
//            assert(!done || (done && stack.count == 1))
//        }
//        
//        return stack.first!
    }
    
    public class func data(withJSONObject obj: Any, options opt: YAMLSerialization.WritingOptions = []) throws -> Data {
        return Data()
    }
    
    public class func isInvalidYAMLObject(_ obj: Any) -> Bool {
        return false
    }
}
