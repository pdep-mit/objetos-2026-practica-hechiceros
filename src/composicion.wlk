class Hechicero{
    var property energiaActual
    var property rango

    method energiaMaxima() = rango.energiaMaxima(self)
    method puedeUsarHechizo(hechizo){
        return self.energiaActual() >= hechizo.energiaRequerida()
            && rango.cumpleRequerimiento(hechizo)
            // en caso de que los requerimientos lo pidan y tengamos que acceder atributos del mago, usariamos self 
            // y armaríamos métodos en la clase hechicero para no romper el encapsulamiento. Por ejemplo, si un hechizo requiere que el mago tenga un nivel mayor a 5, podríamos hacer algo como:
    }
    method subirRango(){
        rango.subirRango(self)
    }
    method modificarRango(nuevoRango){
        rango = nuevoRango
    }
}

class Rango{
    const property energiaMaxima
    method energiaMaxima()
    method cumpleRequerimiento(hechizo)
    method subirRango(hechicero)
}

object aprendiz inherits Rango(energiaMaxima = 50){
    override method energiaMaxima() = energiaMaxima
    override method cumpleRequerimiento(hechizo){
        return hechizo.energiaRequerida() < 40
    }
    override method subirRango(hechicero){
        hechicero.modificarRango(new Archimagos(nivel = 1))
    }
}

class Archimagos inherits Rango(energiaMaxima = 100){
    var property nivel
    override method energiaMaxima() = energiaMaxima + 2 * self.nivel()
    override method cumpleRequerimiento(hechizo){
        return !hechizo.esProhibido()
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

object supremo inherits Rango(energiaMaxima = 500){
    override method energiaMaxima() = energiaMaxima
    override method cumpleRequerimiento(hechizo) = true
    override method subirRango(hechicero){
        // no tiene efecto, entonces el conportamiento está vacío.
    }
}

class Hechizo{
    var property energia
    var property prohibido
}


class NivelNegativo inherits wollok.lang.Exception {}