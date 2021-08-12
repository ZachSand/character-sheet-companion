//
//  SocketEvents.swift
//  CharacterSheetCompanion
//
//  Created by Zachary Sanders on 7/9/21.
//

import Foundation

struct SocketEvents {
    // extended by each listener
    enum IOS {
        struct SETUP {}
        struct ACTOR {}
        struct ROLL {}
        struct DISPLAY {}
    }

    // extended by each listener
    enum SERVER {
        enum SETUP {
            struct SEND {}
        }

        enum ACTOR {
            struct SEND {}
        }

        enum ROLL {
            struct SEND {}
        }

        enum DISPLAY {
            struct SEND {}
        }
    }
}
