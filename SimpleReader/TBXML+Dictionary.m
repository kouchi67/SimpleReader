//
// Created by 河内 浩貴 on 13/05/03.
// Copyright (c) 2013 niyaty. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "TBXML+Dictionary.h"

NSString * const kTextNodeKey = @"text";

@implementation TBXML (Dictionary)

+ (NSDictionary *)dictionaryWithElement:(TBXMLElement *)element
{
    NSMutableDictionary *elementDict = [NSMutableDictionary dictionary];

    NSString *elementName = [TBXML elementName:element];

    // elementDictに属性をセット
    TBXMLAttribute *attribute = element->firstAttribute;
    if (attribute) {
        while (attribute) {
            elementDict[[TBXML attributeName:attribute]] = [TBXML attributeValue:attribute];
            attribute = attribute->next;
        }
    }

    TBXMLElement *childElement = element->firstChild;
    if (childElement) {
        // 子要素がある場合は子要素に対し再起的に+ dictionaryWithElement:メソッドを実行する。
        while (childElement) {
            NSString *childElementName = [TBXML elementName:childElement];
            NSDictionary *childElementDict = [TBXML dictionaryWithElement:childElement];

            if (elementDict[childElementName] == nil) {
                // elementDictにchildElementNameで指定された要素が存在しない場合、elementDictに要素を追加する
                [elementDict addEntriesFromDictionary:childElementDict];
            } else if ([elementDict[childElementName] isKindOfClass:[NSArray class]]) {
                // childElementNameで指定された要素が既存在しかつ配列の場合、その配列に子要素を追加する
                NSMutableArray *items = [NSMutableArray arrayWithArray:elementDict[childElementName]];
                [items addObject:childElementDict[childElementName]];
                elementDict[childElementName] = [NSArray arrayWithArray:items];
            } else {
                // childElementNameで指定された要素が既存在しかつ配列でない場合、新しく配列を生成して子要素を追加する
                NSMutableArray *items = [NSMutableArray array];
                [items addObject:elementDict[childElementName]];
                [items addObject:childElementDict[childElementName]];
                elementDict[childElementName] = [NSArray arrayWithArray:items];
            }

            childElement = childElement->nextSibling;
        }
    } else if ([TBXML textForElement:element] != nil && [TBXML textForElement:element].length > 0) {
        // テキストがあればセットする
        if (elementDict.count > 0) {
            elementDict[kTextNodeKey] = [TBXML textForElement:element];
        } else {
            elementDict[elementName] = [TBXML textForElement:element];
        }
    }

    NSDictionary *resultDict = nil;

    if (elementDict.count > 0) {
        if (elementDict[elementName]) {
            resultDict = [NSDictionary dictionaryWithDictionary:elementDict];
        } else {
            resultDict = [NSDictionary dictionaryWithObject:elementDict forKey:elementName];
        }
    }

    return resultDict;
    
}

@end