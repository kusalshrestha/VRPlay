struct Strings {

    enum QuestionFmt: String {
        case questionFmt1 = "Where is the"
        case questionFmt2 = "Can you locate the"
        case questionFmt3 = "Please point to the"
    }
    
    static let learnText = "LEARN"
    static let playText = "PLAY"
    
    enum displayVC: String {
        case MenuVC = "MenuVC"
        case CatagoryVC = "CatagoryVC"
        case DetailVC = "DetailVC"
    }
}