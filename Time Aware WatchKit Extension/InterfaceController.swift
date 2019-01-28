import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    @IBOutlet weak var minutePickerOutlet: WKInterfacePicker!
    @IBOutlet weak var setTimeOutlet: WKInterfaceLabel!
    
    var minutes = [Int]()
    
    var selectedHoursInMinutes = Int()
    var selectedMinutes = Int()
    var setTimeInSeconds = 0

    @IBAction func minutePickerChanged(_ value: Int) {
        selectedMinutes = minutes[value]
        setTimeOutlet.setText("\(selectedMinutes)")
    }
    
    @IBAction func vibrateButtonPressed() {
        WKInterfaceDevice.current().play(.start)
        setTimeInSeconds = 60 * selectedMinutes
        setTimeOutlet.setText("\(selectedMinutes)")
        Timer.scheduledTimer(timeInterval: TimeInterval(exactly: 10)!,
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
        
        for i in 1 ... 18 {
            minutes.append(i*5)
        }
        let minuteItems: [WKPickerItem] = minutes.map {
            let pickerItem = WKPickerItem()
            pickerItem.title = "\($0)"
            pickerItem.caption = "MINUTES"
            return pickerItem
        }
        minutePickerOutlet.setItems(minuteItems)
        minutePickerOutlet.setSelectedItemIndex(3)
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @objc func vibrate() {
        setTimeInSeconds = setTimeInSeconds - 10
        setTimeOutlet.setText("\(setTimeInSeconds)")
        if (setTimeInSeconds % 300 == 0) {
            WKInterfaceDevice.current().play(.retry)
        } else if (setTimeInSeconds == 180) {
            WKInterfaceDevice.current().play(.retry)
        } else if (setTimeInSeconds == 60) {
            WKInterfaceDevice.current().play(.notification)
        } else if (setTimeInSeconds == 30) {
            WKInterfaceDevice.current().play(.notification)
        }
    }
}
