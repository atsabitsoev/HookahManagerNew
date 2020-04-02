//
//  SwipeTypes.swift
//  HookahManagerNew
//
//  Created by Ацамаз Бицоев on 02.04.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation
import UIKit


enum SwipeTypes {
    
    case approve
    case denie
    case finish
    case annul
    
    func getSwipeAction(_ handler: @escaping UIContextualAction.Handler) -> UIContextualAction {
        switch self {
        case .approve:
            let action = UIContextualAction(style: .normal,
                                            title: "Подтвердить",
                                            handler: handler)
            action.backgroundColor = .green
            return action
        case .denie:
            let action = UIContextualAction(style: .destructive,
                                            title: "Отклонить бронь",
                                            handler: handler)
            return action
        case .finish:
            let action = UIContextualAction(style: .destructive,
                                            title: "Посетитель ушел",
                                            handler: handler)
            action.backgroundColor = .blue
            return action
        case .annul:
            let action = UIContextualAction(style: .destructive,
                                            title: "Отменить бронь",
                                            handler: handler)
            return action
        }
    }
}
