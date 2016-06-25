struct key {
    
    enum Catagory: String {
        case Animal = "Animal"
            enum AnimalName: String {
                case Dog = "Dog"
                case Elephant = "Elephant"
            }
        case Superhero = "SuperHero"
            enum SuperheroName: String {
                case Batman = "Batman"
                case Superman = "Superman"
            }
    }
    
}