import Foundation

private let asset = "Art.scnassets/"

struct Assets {
    
    struct Animal {
        static let dog = asset + "Animal/dog.dae"
    }
    
    struct Building {
        static let parliament = asset + "House/Houses_of_parliament_2.dae"
    }
    
    struct Hero {
        static let Batman = asset + "Batman/Batman.dae"
        static let Hulk = asset + "Hulk_Avengers/Hulk_Avengers.dae"
        static let Ironman = asset + "Ironman/Ironman.dae"
        static let Spiderman = asset + "Spider-Man.dae"
    }
    
}