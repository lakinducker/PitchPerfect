//
//  RecordAudio.swift
//  Pitch Perfect
//
//  Created by Lakin Ducker on 1/21/15.
//  Copyright (c) 2015 Lakin Ducker. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    init(filePathUrl: NSURL!, title: String!) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}