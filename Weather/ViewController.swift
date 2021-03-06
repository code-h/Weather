//
//  ViewController.swift
//  Weather
//
//  Created by marquis on 16/1/29.
//  Copyright © 2016年 marquis. All rights reserved.
//

import UIKit
import AVFoundation
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    //@IBOutlet Current Weather
    @IBOutlet weak var windBag: UIImageView!
    @IBOutlet weak var umbrella: UIImageView!
    @IBOutlet weak var humidity: UIImageView!
    @IBOutlet weak var userLocationLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    
    //@IBOutlet Current Time Label: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var pmAmount: UILabel!
    @IBOutlet weak var humidityAmount: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    //@IBOutlet weak var refreshActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var degreeBtn: UIButton!
    @IBOutlet weak var swipeView: UIView!
    @IBOutlet weak var heatIndex: UIImageView!
    @IBOutlet weak var dayCurrentTemperatureLowLabel: UILabel!
    @IBOutlet weak var dayCurrentTemperatureHighLabel: UILabel!
    
    
    @IBOutlet weak var windUILabel: UILabel!
    @IBOutlet weak var pmUILabel: UILabel!
    @IBOutlet weak var humidityUILabel: UILabel!
    
    //@IBOutlet Daily Weather
    @IBOutlet weak var dayCurrentTemperatureLow: UILabel!
    @IBOutlet weak var dayCurrentTemperatureHigh: UILabel!
    
    @IBOutlet weak var dayOneWeekDayLabel: UILabel!
    @IBOutlet weak var dayOneWeekDayImage: UIImageView!
    @IBOutlet weak var dayOneLowHigh: UILabel!
    
    @IBOutlet weak var dayTwoWeekDayLabel: UILabel!
    @IBOutlet weak var dayTwoWeekDayImage: UIImageView!
    @IBOutlet weak var dayTwoLowHigh: UILabel!
    
    @IBOutlet weak var dayThreeWeekDayLabel: UILabel!
    @IBOutlet weak var dayThreeWeekDayImage: UIImageView!
    @IBOutlet weak var dayThreeLowHigh: UILabel!
    
    @IBOutlet weak var dayFourWeekDayLabel: UILabel!
    @IBOutlet weak var dayFourWeekDayImage: UIImageView!
    @IBOutlet weak var dayFourLowHigh: UILabel!
    
    @IBOutlet weak var dayFiveWeekDayLabel: UILabel!
    @IBOutlet weak var dayFiveWeekDayImage: UIImageView!
    @IBOutlet weak var dayFiveLowHigh: UILabel!
    
    @IBOutlet weak var daySixWeekDayLabel: UILabel!
    @IBOutlet weak var daySixLowHigh: UILabel!
    @IBOutlet weak var daySixWeekDayImage: UIImageView!
    
    //@IBOutlet Alerts
    @IBOutlet weak var wAlerts: UILabel!
    
    var audioPlayer = AVAudioPlayer()
    var userTemperatureCelsius: Bool!
    
    //MARK: - LocationModel
    var locationModel: LocationViewModel!
    var weatherDataService: WeatherDataService!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        locationModel = LocationViewModel(delegate: self, delegateData: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        userTemperatureCelsius = defaults.boolForKey("celsius")
        print("defaults: celsius  = \(userTemperatureCelsius)")
        let swipeDown = UISwipeGestureRecognizer(target: self, action: "swipedView:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDown)
        //Refresh
        refresh()
    }
    
    func swipedView(gesture: UIGestureRecognizer){
        self.swooshSound()
        refresh()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//MARK: - Refresh
extension ViewController{
    func refresh() {

        locationModel.initLocationManager()
        
        self.temperatureLabel.alpha = 0
        self.dayOneWeekDayImage.alpha = 0
        self.dayTwoWeekDayImage.alpha = 0
        self.dayThreeWeekDayImage.alpha = 0
        self.dayFourWeekDayImage.alpha = 0
        self.dayFiveWeekDayImage.alpha = 0
        self.daySixWeekDayImage.alpha = 0
        self.dayCurrentTemperatureLow.alpha = 0
        self.dayCurrentTemperatureHigh.alpha = 0
        self.windSpeedLabel.alpha = 0
        self.humidityAmount.alpha = 0
        self.pmAmount.alpha = 0
        self.pmUILabel.alpha = 0
        self.dayOneWeekDayLabel.alpha = 0
        self.dayOneLowHigh.alpha = 0
        self.dayTwoWeekDayLabel.alpha = 0
        self.dayTwoLowHigh.alpha = 0
        self.dayThreeWeekDayLabel.alpha = 0
        self.dayThreeLowHigh.alpha = 0
        self.dayFourWeekDayLabel.alpha = 0
        self.dayFourLowHigh.alpha = 0
        self.dayFiveWeekDayLabel.alpha = 0
        self.dayFiveLowHigh.alpha = 0
        self.daySixWeekDayLabel.alpha = 0
        self.daySixLowHigh.alpha = 0
        self.wAlerts.alpha = 0
        
        self.weeklyForcastAnimation()
        
        UIView.animateWithDuration(1.5, animations: {
            self.temperatureLabel.alpha = 1.0
            self.heatIndex.alpha = 1.0
            self.dayOneWeekDayImage.alpha = 1.0
            self.dayTwoWeekDayImage.alpha = 1.0
            self.dayThreeWeekDayImage.alpha = 1.0
            self.dayFourWeekDayImage.alpha = 1.0
            self.dayFiveWeekDayImage.alpha = 1.0
            self.daySixWeekDayImage.alpha = 1.0
            self.dayCurrentTemperatureLow.alpha = 1.0
            self.dayCurrentTemperatureHigh.alpha = 1.0
            self.windSpeedLabel.alpha = 1.0
            self.humidityAmount.alpha = 1.0
            self.pmAmount.alpha = 1.0
            self.pmUILabel.alpha = 1.0
            self.dayOneWeekDayLabel.alpha = 1.0
            self.dayOneLowHigh.alpha = 1.0
            self.dayTwoWeekDayLabel.alpha = 1.0
            self.dayTwoLowHigh.alpha = 1.0
            self.dayThreeWeekDayLabel.alpha = 1.0
            self.dayThreeLowHigh.alpha = 1.0
            self.dayFourWeekDayLabel.alpha = 1.0
            self.dayFourLowHigh.alpha = 1.0
            self.dayFiveWeekDayLabel.alpha = 1.0
            self.dayFiveLowHigh.alpha = 1.0
            self.daySixWeekDayLabel.alpha = 1.0
            self.daySixLowHigh.alpha = 1.0
            self.wAlerts.alpha = 1.0
            
        })
    }
    
    
    func weeklyForcastAnimation() {
        //DAILY
        self.dayCurrentTemperatureLowLabel.transform = CGAffineTransformMakeTranslation(-300, 0)
        self.dayCurrentTemperatureHighLabel.transform = CGAffineTransformMakeTranslation(300, 0)
        self.windBag.transform = CGAffineTransformMakeTranslation(0, -600)
        self.umbrella.transform = CGAffineTransformMakeTranslation(0, -600)
        self.humidity.transform = CGAffineTransformMakeTranslation(0, -600)
        self.iconView.transform = CGAffineTransformMakeTranslation(-200, 0)
        self.temperatureLabel.transform = CGAffineTransformMakeTranslation(300, 0)
        self.summaryLabel.transform = CGAffineTransformMakeTranslation(0, -200)
        self.heatIndex.transform = CGAffineTransformMakeTranslation(-350, 0)
        self.userLocationLabel.transform = CGAffineTransformMakeTranslation(350, 0)
        self.degreeBtn.transform = CGAffineTransformMakeTranslation(350,0)
        self.windUILabel.transform = CGAffineTransformMakeTranslation(-350,0)
        self.humidityUILabel.transform = CGAffineTransformMakeTranslation(350,0)
        self.degreeBtn.transform = CGAffineTransformMakeTranslation(350, 0)
        
        
        //WEEKLY
        self.dayOneWeekDayImage.transform = CGAffineTransformMakeTranslation(0, 100)
        self.dayTwoWeekDayImage.transform = CGAffineTransformMakeTranslation(0, 100)
        self.dayThreeWeekDayImage.transform = CGAffineTransformMakeTranslation(0, 100)
        self.dayFourWeekDayImage.transform = CGAffineTransformMakeTranslation(0, 100)
        self.dayFiveWeekDayImage.transform = CGAffineTransformMakeTranslation(0, 100)
        self.daySixWeekDayImage.transform = CGAffineTransformMakeTranslation(0, 100)
        
        //DAILY SPRING ACTION
        let springAnimation = SpringAnimation();
        springAnimation.springWithDelay(0.9, delay: 0.45, animations: {
            self.userLocationLabel.transform = CGAffineTransformMakeTranslation(0, 0)
        })
        springAnimation.springWithDelay(0.9, delay: 0.60, animations: {
            self.degreeBtn.transform = CGAffineTransformMakeTranslation(0, 0)
        })
    
        springAnimation.springWithDelay(0.9, delay: 0.25, animations: {
            self.windBag.transform = CGAffineTransformMakeTranslation(0, 0)
        })
        springAnimation.springWithDelay(0.9, delay: 0.35, animations: {
            self.umbrella.transform = CGAffineTransformMakeTranslation(0, 0)
        })
        springAnimation.springWithDelay(0.9, delay: 0.45, animations: {
            self.humidity.transform = CGAffineTransformMakeTranslation(0, 0)
        })
        
        springAnimation.springWithDelay(0.9, delay: 0.45, animations: {
            self.iconView.transform = CGAffineTransformMakeTranslation(0, 0)
        })
        
        springAnimation.springWithDelay(0.9, delay: 0.45, animations: {
            self.temperatureLabel.transform = CGAffineTransformMakeTranslation(0, 0)
        })
        
        springAnimation.springWithDelay(0.9, delay: 0.60, animations: {
            self.summaryLabel.transform = CGAffineTransformMakeTranslation(0, 0)
        })
        springAnimation.springWithDelay(0.9, delay: 0.45, animations: {
            self.heatIndex.transform = CGAffineTransformMakeTranslation(0, 0)
        })
        
        springAnimation.springWithDelay(0.9, delay: 0.45, animations: {
            self.dayCurrentTemperatureLowLabel.transform = CGAffineTransformMakeTranslation(0, 0)
        })
        
        springAnimation.springWithDelay(0.9, delay: 0.45, animations: {
            self.dayCurrentTemperatureHighLabel.transform = CGAffineTransformMakeTranslation(0, 0)
        })
        
        springAnimation.springWithDelay(0.9, delay: 0.45, animations: {
            self.userLocationLabel.transform = CGAffineTransformMakeTranslation(0, 0)
        })
        
        springAnimation.springWithDelay(0.9, delay: 0.45, animations: {
            self.windUILabel.transform = CGAffineTransformMakeTranslation(0, 0)
        })
        
        
        springAnimation.springWithDelay(0.9, delay: 0.45, animations: {
            self.humidityUILabel.transform = CGAffineTransformMakeTranslation(0, 0)
        })
        
        //WEEKLY FORCAST SPRING ACTION
        springAnimation.springWithDelay(0.9, delay: 0.25, animations: {
            self.dayOneWeekDayImage.transform = CGAffineTransformMakeTranslation(0, 0)
        })
        
        springAnimation.springWithDelay(0.9, delay: 0.35, animations: {
            self.dayTwoWeekDayImage.transform = CGAffineTransformMakeTranslation(0, 0)
        })
        
        springAnimation.springWithDelay(0.9, delay: 0.45, animations: {
            self.dayThreeWeekDayImage.transform = CGAffineTransformMakeTranslation(0, 0)
        })
        
        springAnimation.springWithDelay(0.9, delay: 0.55, animations: {
            self.dayFourWeekDayImage.transform = CGAffineTransformMakeTranslation(0, 0)
        })
        
        springAnimation.springWithDelay(0.9, delay: 0.65, animations: {
            self.dayFiveWeekDayImage.transform = CGAffineTransformMakeTranslation(0, 0)
        })
        
        springAnimation.springWithDelay(0.9, delay: 0.75, animations: {
            self.daySixWeekDayImage.transform = CGAffineTransformMakeTranslation(0, 0)
            
        })
    }
}

//MARK: - Voice
extension ViewController{
    func swooshSound(){
        let alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("swoosh", ofType: "wav")!)
        do{
            audioPlayer = try AVAudioPlayer(contentsOfURL: alertSound)
        }catch let errorOther as NSError{
            let error: NSError? = errorOther
            NSLog("Sound \(error)")
        }
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
}

//MARK: - View Model Location
extension ViewController: LocationViewDelegate{
    func displayLocationInfo(locality: String, administrativeArea: String){
        self.userLocationLabel.text = "\(locality), \(administrativeArea)"
    }
}

//MARK: - Service Weather
extension ViewController: WeatherDataDelegate{
    func show(currentWeather: CurrentViewModel, weeklyWeather: WeatherViewModel, alertWeather: WeatherAlertsView){
        if self.userTemperatureCelsius == true{
             //MARK - Celsius
        }else{
            self.temperatureLabel.text = "\(currentWeather.current.temperature!)"
        }
        self.iconView.image = currentWeather.current.icon
        self.windSpeedLabel.text = "\(currentWeather.current.windSpeed!)"
        self.pmAmount.text = "\(currentWeather.current.pm!)"
        self.humidityAmount.text = "\(currentWeather.current.humidity!)"
        self.summaryLabel.text = "\(currentWeather.current.summary)"
        
        if self.userTemperatureCelsius == true{
            //MARK - Celsius
        }else{
            self.dayCurrentTemperatureHigh.text = "\(weeklyWeather.weekly.dayCurrentTemperatureMax!)"
            self.dayCurrentTemperatureLow.text = "\(weeklyWeather.weekly.dayCurrentTemperatureMin!)"
        }
        //MARK - Weekly
        if self.userTemperatureCelsius == true{
             //MARK - Celsius
        }else{
            self.dayOneLowHigh.text = "\(weeklyWeather.weekly.dayOneTemperatureMin!)°~\(weeklyWeather.weekly.dayOneTemperatureMax!)°"
            self.dayTwoLowHigh.text = "\(weeklyWeather.weekly.dayTwoTemperatureMin!)°~\(weeklyWeather.weekly.dayTwoTemperatureMax!)°"
            self.dayThreeLowHigh.text = "\(weeklyWeather.weekly.dayThreeTemperatureMin!)°~\(weeklyWeather.weekly.dayThreeTemperatureMax!)°"
            self.dayFourLowHigh.text = "\(weeklyWeather.weekly.dayFourTemperatureMin!)°~\(weeklyWeather.weekly.dayFourTemperatureMax!)°"
            self.dayFiveLowHigh.text = "\(weeklyWeather.weekly.dayFiveTemperatureMin!)°~\(weeklyWeather.weekly.dayFiveTemperatureMax!)°"
            self.daySixLowHigh.text = "\(weeklyWeather.weekly.daySixTemperatureMin!)°~\(weeklyWeather.weekly.daySixTemperatureMax!)°"
        }
        self.dayOneWeekDayLabel.text = "\(weeklyWeather.weekly.dayOneTime!)"
        self.dayOneWeekDayImage.image = weeklyWeather.weekly.dayOneIcon!
        
        self.dayTwoWeekDayLabel.text = "\(weeklyWeather.weekly.dayTwoTime!)"
        self.dayTwoWeekDayImage.image = weeklyWeather.weekly.dayTwoIcon!
        
        self.dayThreeWeekDayLabel.text = "\(weeklyWeather.weekly.dayThreeTime!)"
        self.dayThreeWeekDayImage.image = weeklyWeather.weekly.dayThreeIcon!
        
        self.dayFourWeekDayLabel.text = "\(weeklyWeather.weekly.dayFourTime!)"
        self.dayFourWeekDayImage.image = weeklyWeather.weekly.dayFourIcon!
        
        self.dayFiveWeekDayLabel.text = "\(weeklyWeather.weekly.dayFiveTime!)"
        self.dayFiveWeekDayImage.image = weeklyWeather.weekly.dayFiveIcon!
        
        self.daySixWeekDayLabel.text = "\(weeklyWeather.weekly.daySixTime!)"
        self.daySixWeekDayImage.image = weeklyWeather.weekly.daySixIcon!
        
        //MARK - Weather Alerts
        
        self.wAlerts.text = "\(alertWeather.userAlert)"
    }
}

