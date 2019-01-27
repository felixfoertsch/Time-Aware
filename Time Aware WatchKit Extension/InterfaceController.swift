//
//  InterfaceController.swift
//  Time Aware WatchKit Extension
//
//  Created by Felix Förtsch on 26.01.19.
//  Copyright © 2019 Felix Förtsch. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    var looping = true

    @IBOutlet weak var hourPickerOutlet: WKInterfacePicker!
    @IBOutlet weak var minutePickerOutlet: WKInterfacePicker!
    
    @IBAction func loopSwitched(_ value: Bool) {
        self.looping = value
    }
    @IBOutlet weak var loopOutlet: WKInterfaceSwitch!
    
    @IBAction func retryButtonPressed() {
        while looping {
            WKInterfaceDevice.current().play(.retry)
            sleep(2)
        }
    }
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        let hours = ["0", "1", "2"]
        let hourItems: [WKPickerItem] = hours.map {
            let pickerItem = WKPickerItem()
            pickerItem.title = "\($0)"
            return pickerItem
        }
        hourPickerOutlet.setItems(hourItems)
        
        var minutes = [String]()
        for i in 0 ... 59 {
            minutes.append("\(i)")
        }
        let minuteItems: [WKPickerItem] = minutes.map {
            let pickerItem = WKPickerItem()
            pickerItem.title = "\($0)"
            return pickerItem
        }
        minutePickerOutlet.setItems(minuteItems)
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
