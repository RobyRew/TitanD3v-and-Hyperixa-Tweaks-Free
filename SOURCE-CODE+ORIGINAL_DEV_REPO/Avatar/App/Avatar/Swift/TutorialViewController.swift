import UIKit

class TutorialViewController: UIViewController {
    
    var whatsnewView: WhatsNewBaseView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .init(named: "Primary")
        
        let contents = createOnboardingContents()
        whatsnewView = WhatsNewBaseView(content: contents)
        view.addSubview(whatsnewView)
        
        whatsnewView.fill()
        
    }
    
    
    func createOnboardingContents() -> WhatsNewContent.Base {
        let color: UIColor = .systemBlue
        let title = WhatsNewContent.Title(format: .multiline(welcomeText: "Welcome to Avatar"), text: "Tutorial")
            
        let items = [
            
            WhatsNewContent.Card(title: "Hello",
                                 resume: "Thank you for purchasing Avatar, have an amazing time creating awesome videos and sharing them.",
                                 icon: UIImage(systemName: "hand.wave.fill"),
                                 iconTintColor: .systemIndigo),
            
            WhatsNewContent.Card(title: "Avatar Profile",
                                 resume: "Tap on your profile icon from the home page to customise your profile avatar.",
                                 icon: UIImage(systemName: "1.circle.fill"),
                                 iconTintColor: .systemGreen),
                
            WhatsNewContent.Card(title: "Memoji",
                                 resume: "Choose your Memoji from the home page Memoji section, once you have selected your Memoji then it will take you to the recording studio where you can either add a wallpaper or background colour, add stickers and record your Memoji.",
                                 icon: UIImage(systemName: "2.circle.fill"),
                                 iconTintColor: .systemBlue),
            
            WhatsNewContent.Card(title: "Animoji",
                                 resume: "Choose your Animoji from home page Animoji section, once you have selected your Animoji then it will take you to recording studio where you can either add wallpaper or background colour, add stickers and record your Animoji.",
                                 icon: UIImage(systemName: "3.circle.fill"),
                                 iconTintColor: .systemPink),
            
            WhatsNewContent.Card(title: "Avimoji",
                                 resume: "Avimoji is a studio where you can customise any avatar, add a background image or colour, Emojis, Memoji stickers or text and change the mask shape then you can that save avatar to your photo library to share them via social media.",
                                 icon: UIImage(systemName: "4.circle.fill"),
                                 iconTintColor: .systemYellow),
            
            WhatsNewContent.Card(title: "Library",
                                 resume: "Every time you record Memoji or Animoji, the video will be saved to your photo library automatically so you can watch the video, save them to your photo library, share them or delete the video from your photo library by long pressing on the cells.",
                                 icon: UIImage(systemName: "5.circle.fill"),
                                 iconTintColor: .systemTeal),
            
            WhatsNewContent.Card(title: "Existing Memoji",
                                 resume: "If you don’t want to create Memojis from scratch, you can toggle to import existing Memoji from the settings so it will load existing Memojis that you created from the iMessage app but you won’t be able to create new Memoji in the Avatar app but you still can create new Memoji in iMessage then the Avatar app will load the newly created Memoji. If you disable being able to import existing Memojis then you will need to create new Memoji within the app. Don’t worry you can switch between existing or new Memoji in the settings option.",
                                 icon: UIImage(systemName: "6.circle.fill"),
                                 iconTintColor: .systemOrange),
            
            WhatsNewContent.Card(title: "Social",
                                 resume: "If you need any help or are having troubling to use the Avatar app please don’t hesitate to contact us via the Social media section from settings.",
                                 icon: UIImage(systemName: "7.circle.fill"),
                                 iconTintColor: .systemRed)
                
            ]
            
        let startBtn = WhatsNewContent.Button(text: "Go Back", backgroundColor: .systemBlue) { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
            
            
        return WhatsNewContent.Base(backgroundColor: .init(named: "Primary")!, title: title, cards: items, button: startBtn)
    }
    

}
