class Hechicero{
    var property energiaActual
    var property rango

    method energiaMaxima() = rango.energiaMaxima(self)
    method puedeUsarHechizo(hechizo){
        return self.energiaActual() >= hechizo.energiaRequerida()
    }
    method subirRango(){
        rango.subirRango(self)
    }
    method modificarRango(nuevoRango){
        rango = nuevoRango
    }
}

class Rango{
    var energiaMaxima
    method energiaMaxima()
    method puedeUsarHechizo(hechicero, hechizo){
        return hechicero.energiaActual() >= hechizo.energiaRequerida()
    }
    method subirRango(hechiecero)
}

object aprendiz inherits Rango(energiaMaxima = 50){
    override method energiaMaxima() = energiaMaxima
    override method puedeUsarHechizo(hechicero, hechizo){
        return super(hechicero, hechizo) && hechizo.energiaRequerida() < 40
    }
    override method subirRango(hechicero){
        hechicero.modificarRango(new Archimagos(nivel = 1))
    }
}

class Archimagos inherits Rango(energiaMaxima = 100){
    var property nivel
    override method energiaMaxima() = energiaMaxima + 2 * self.nivel()
    override method puedeUsarHechizo(hechicero, hechizo){
        return super(hechicero, hechizo) && !hechizo.esProhibido()
    }
    override method subirRango(hechicero){
        try {
            if (self.nivel() < 0) { throw new NivelNegativo() }
            
            if (self.nivel() < 10) { nivel = self.nivel() + 1}
            else { hechicero.modificarRango(supremo) }
        } catch e {
            self.error(e.message())
        }
    }
}

class NivelNegativo inherits wollok.lang.Exception {}

object supremo inherits Rango(energiaMaxima = 500){
    override method energiaMaxima() = energiaMaxima
    override method puedeUsarHechizo(hechicero, hechizo) = true
    override method subirRango(hechicero){// El rango supremo no tiene un rango superior.}
}

class Hechizo{
    var property energia // integer
    var property prohibido // boolean 
    method energiaRequerida() = self.energia()
    method esProhibido() = self.prohibido()
}