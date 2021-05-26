
//
import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var timer = Timer()
    var player: AVAudioPlayer!
    var totalTime = 0
    // althogh secondsPassed is now set to  0, as seen on line36 secondsPassed will increase by 1 every time updateTimer is called, which is one second as shown on line 31 (1.0)//
    var secondsPassed = 0
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        // timer.invalidate will stop the timer, when a new one is set //
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        
        // progressBar is the name of the element i gave to the bar, progress is a method, you can see it in the main.storyboard when you press on the bar,it is set to 0 so when the buttons are pressed the bar goes back to 0 (0.0), it will do this as the code is within the button function (harnessSelected ) the same will happen to secondsPassed (goes back to 0.0) //

        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness

        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
    }
    
    // note that float is a data type that uses decimals //
    
    @objc func updateTimer() {
        // this code looks to see when secondsPassed is less than totalTime(3,5,or 7) which when it is will increase the seconds passed by 1, when it is greater than totaltime the timer will stop, and DONE! will be shown on the screen //
        if secondsPassed < totalTime {
            secondsPassed += 1
            
            
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            print(Float(secondsPassed) / Float(totalTime))
        } else {
            // the 2 lines below will stop the timer (timer.invalidate) and will change the title label text from How do you like your eggs to done! //
            
            timer.invalidate()
            titleLabel.text = "DONE!"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
    
}
