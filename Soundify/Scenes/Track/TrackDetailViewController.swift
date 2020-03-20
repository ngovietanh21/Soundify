//
//  TrackDetailViewController.swift
//  Soundify
//
//  Created by Viet Anh on 3/17/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

final class TrackDetailViewController: BaseDetailViewController {
    
    private var streaming: SPTAudioStreamingController?
    
    //MARK: - IBOutlet
    @IBOutlet private weak var aboveSafeArea: UIView!
    
    ///Image
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var trackImageView: UIImageView!
    
    ///For track
    @IBOutlet private weak var trackNameLabel: UILabel!
    @IBOutlet private weak var artistsNameLabel: UILabel!
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var shuffleButton: UIButton!
    @IBOutlet private weak var repeatButton: UIButton!
    @IBOutlet private weak var audioSlider: UISlider!
    @IBOutlet private weak var currentTimeLabel: UILabel!
    @IBOutlet private weak var totalTimeLabel: UILabel!
    
    //MARK: - Track
    var track: Track!
    var urlImage: URL!
    private let navigationBar = TrackDetailNavigationBarView()
    
    //MARK: - Variable for playing song
    private var isChangingSlider = false
    private var totalTime: Float { Float(streaming?.metadata.currentTrack?.duration ?? 0) }
    private var isPlaying: Bool {
        get { streaming?.playbackState.isPlaying ?? true }
        set {
            switch newValue {
            case true:
                streaming?.setIsPlaying(true, callback: nil)
                playButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            case false:
                streaming?.setIsPlaying(false, callback: nil)
                playButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            }
        }
    }
    
    private var isShuffling: Bool {
        get { streaming?.playbackState.isShuffling ?? true }
        set {
            switch newValue {
            case true:
                streaming?.setShuffle(true, callback: nil)
                shuffleButton.tintColor = .white
            case false:
                streaming?.setShuffle(false, callback: nil)
                shuffleButton.tintColor = .lightGray
                
            }
        }
    }
    
    private var isRepeating: Bool {
        get { streaming?.playbackState.isRepeating ?? true }
        set {
            switch newValue {
            case true:
                streaming?.setRepeat(.one, callback: nil)
                repeatButton.tintColor = .white
                repeatButton.setImage(UIImage(systemName: "repeat.1"), for: .normal)
            case false:
                streaming?.setRepeat(.off, callback: nil)
                repeatButton.tintColor = .lightGray
                repeatButton.setImage(UIImage(systemName: "repeat"), for: .normal)
            }
        }
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
}

//MARK: - ConfigView
extension TrackDetailViewController {
    
    private func configView() {
        initializaStreaming()
        configBackground()
        configImageView()
        navigationBar.configView(on: self, aboveSafeArea: aboveSafeArea, with: track)
    }
    
    private func configBackground() {
        view.setGradientBackground(colorTop: #colorLiteral(red: 0.1450815201, green: 0.1451086104, blue: 0.1450755298, alpha: 1), colorBottom: #colorLiteral(red: 0.09718047827, green: 0.07773689181, blue: 0.07808386534, alpha: 1))
        trackNameLabel.text = track.name
        artistsNameLabel.text = track.artists.sequenceNameArtistsWithComma
    }
    
    private func configImageView() {
        if urlImage == nil { urlImage = track.album?.images.urlImage}
        trackImageView.do {
            $0.sd_setImage(with: urlImage, completed: nil)
            $0.borderColor = .lightGray
            $0.borderWidth = 1
            $0.cornerRadius = 10
        }
        
        backgroundImageView.do {
            $0.sd_setImage(with: urlImage, completed: nil)
            $0.alpha = 0.1
        }
    }
    
    private func initializaStreaming() {
        if streaming != nil { return }
        
        streaming = SPTAudioStreamingController.sharedInstance()?.then {
            
            do {
                try $0.start(withClientId: APIKey.CLIENT_ID, audioController: nil, allowCaching: true)
                
            } catch let error {
                print(error.localizedDescription)
            }
            $0.delegate = self
            $0.playbackDelegate = self
            $0.diskCache = SPTDiskCache()
            $0.login(withAccessToken: UserSession.shared.accessToken ?? "")
        }
    }
    
    private func getAudio() {
        streaming?.playSpotifyURI(track.uri, startingWith: 0, startingWithPosition: 0) { (error) in
            print("Fail get audio - \(error.debugDescription)")
        }
        activateAudioSession()
    }
    
    private func configLabelTime(at position: TimeInterval) {
        totalTimeLabel.text = Double(totalTime).formatterMinuteAndSecondInTrack
        currentTimeLabel.text = position.formatterMinuteAndSecondInTrack
        audioSlider.value = Float( Float(position) / totalTime)
    }
    
    func activateAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
    func deactivateAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setActive(false)
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
}

//MARK: - SPTAudioStreamingDelegate
extension TrackDetailViewController: SPTAudioStreamingDelegate {
    
    func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController!) {
        getAudio()
    }
}

//MARK: - SPTAudioStreamingPlaybackDelegate
extension TrackDetailViewController: SPTAudioStreamingPlaybackDelegate {
    
    func audioStreaming(_ audioStreaming: SPTAudioStreamingController!, didChangePosition position: TimeInterval) {
        if isChangingSlider { return }
        configLabelTime(at: position)
    }
    
    func audioStreaming(_ audioStreaming: SPTAudioStreamingController, didChangePlaybackStatus isPlaying: Bool) {
        switch isPlaying {
        case true:
            activateAudioSession()
        case false:
            deactivateAudioSession()
        }
    }
}

//MARK: - IBAction
extension TrackDetailViewController {
    
    @IBAction func sliderValueChanged(_ sender: UISlider, forEvent event: UIEvent) {
        
        if let touchEvent = event.allTouches?.first {
            isChangingSlider = true
            let currentTime = totalTime * sender.value
            
            switch touchEvent.phase {
            case .moved:
                DispatchQueue.main.async {
                    self.currentTimeLabel.text = Double(currentTime).formatterMinuteAndSecondInTrack
                }
                break
            case .ended:
                streaming?.seek(to: TimeInterval(currentTime), callback: nil)
                isChangingSlider = false
                break
                
            default:
                break
            }
        }
    }
    
    @IBAction func shuffleButtonClicked(_ sender: UIButton) {
        isShuffling.toggle()
    }
    
    @IBAction func repeatButtonClicked(_ sender: UIButton) {
        isRepeating.toggle()
    }
    
    @IBAction func playButtonClicked(_ sender: UIButton) {
        isPlaying.toggle()
    }
}
