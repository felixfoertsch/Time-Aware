import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    @IBOutlet weak var hourPickerOutlet: WKInterfacePicker!
    @IBOutlet weak var minutePickerOutlet: WKInterfacePicker!

    let hours = [0, 1, 2]
    var minutes = [Int]()
    
    var selectedHoursInMinutes = Int()
    var selectedMinutes = Int()

    @IBAction func hourPickerChanged(_ value: Int) {
        selectedHoursInMinutes = 60 * hours[value]
    }
    @IBAction func minutePickerChanged(_ value: Int) {
        selectedMinutes = minutes[value]
    }
    
    @IBAction func vibrateButtonPressed() {
        let timesToVibrate = (selectedHoursInMinutes + selectedMinutes) / 300
        
        Timer.scheduledTimer(timeInterval: TimeInterval(exactly: 5)!,
                             target: self, selector: #selector(vibrate),
                             userInfo: nil, repeats: true)
    }
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        let hourItems: [WKPickerItem] = hours.map {
            let pickerItem = WKPickerItem()
            pickerItem.title = "\($0)"
            return pickerItem
        }
        hourPickerOutlet.setItems(hourItems)
        
        for i in 0 ... 11 {
            minutes.append(i*5)
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

    
    @objc func vibrate() {
        WKInterfaceDevice.current().play(.retry)
    }
}
