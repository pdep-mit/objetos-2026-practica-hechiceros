class Hechicero {
    var energiaActual
    var rango

    method energiaMaxima() = rango.energiaMaxima()

    method puedeUsarHechizo(hechizo) = energiaActual >= hechizo.energiaRequerida() && rango.cumpleRequerimiento(hechizo)

    method subirRango() {
        rango.subirRango(self)
    }

    method cambiarEnergia(nuevaEnergia) {
        energiaActual = nuevaEnergia
    }

    method cambiarRango(nuevoRango) {
        rango = nuevoRango
    }
}

class Aprendiz {
    method energiaMaxima() = 50

    method cumpleRequerimiento(hechizo) = hechizo.energiaRequerida() < 40

    method subirRango(hechicero) {
        hechicero.cambiarRango(new Archimago(nivel = 1))
    }
}

class Archimago {
    var property nivel

    method energiaMaxima() = 100 + (2 * nivel)

    method cumpleRequerimiento(hechizo) = !hechizo.esProhibido()

    method subirRango(hechicero) {
        if (nivel < 10) 
            nivel += 1
        else 
            hechicero.cambiarRango(supremo)
    }
}

object supremo {
    method energiaMaxima() = 500

    method cumpleRequerimiento(hechizo) = true

    method subirRango(hechicero) {}
}

class Hechizo {
    var property energiaRequerida
    var property esProhibido = false
}
