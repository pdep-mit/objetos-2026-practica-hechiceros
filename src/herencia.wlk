class Hechicero{
    var property energiaActual

    method energiaMaxima()
    method puedeUsarHechizo(hechizo){
        return self.energiaActual() >= hechizo.energiaRequerida()
    }
}

class Aprendiz inherits Hechicero(){
    override method energiaMaxima() { return 50 }
    override method puedeUsarHechizo(hechizo){
        return super(hechizo) && hechizo.energiaRequerida() < 40
    }
}

class Archimagos inherits Hechicero(){
    var property nivel = 1
    override method energiaMaxima() = 100 + 2 * self.nivel()
    override method puedeUsarHechizo(hechizo){
        return super(hechizo) && !hechizo.esProhibido()
    }
}

class Supremos inherits Hechicero(){
    override method energiaMaxima() = 500
    override method puedeUsarHechizo(hechizo) = true
}

class Hechizo{
    var property energia // integer
    var property prohibido // boolean 
    method energiaRequerida() = self.energia()
    method esProhibido() = self.prohibido()
}