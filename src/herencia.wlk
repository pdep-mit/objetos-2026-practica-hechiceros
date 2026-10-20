class Hechicero{
    const energiaMaxima
    var property nivel
    var property energiaActual

    method energiaMaxima()
    method puedeUsarHechizo(hechizo){
        return self.energiaActual() >= hechizo.energiaRequerida()
    }
}

class Aprendiz inherits Hechicero(energiaMaxima = 50, nivel = 0, energiaActual = energiaMaxima){
    override method energiaMaxima() = energiaMaxima
    override method puedeUsarHechizo(hechizo){
        return super(hechizo) && hechizo.energiaRequerida() < 40
    }
}

class Archimagos inherits Hechicero(energiaMaxima = 100, nivel = 1, energiaActual = energiaMaxima){
    override method energiaMaxima() = energiaMaxima + 2 * self.nivel()
    override method puedeUsarHechizo(hechizo){
        return super(hechizo) && !hechizo.esProhibido()
    }
}

class Supremos inherits Hechicero(energiaMaxima = 500, nivel = 0, energiaActual = energiaMaxima){
    override method energiaMaxima() = energiaMaxima
    override method puedeUsarHechizo(hechizo) = true
}

class Hechizo{
    var property energia // integer
    var property prohibido // boolean 
    method energiaRequerida() = self.energia()
    method esProhibido() = self.prohibido()
}