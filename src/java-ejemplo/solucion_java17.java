
abstract class Rango {
    private final int energiaBase;

    protected Rango(int energiaBase) {
        this.energiaBase = energiaBase;
    }

    protected int getEnergiaBase() {
        return energiaBase;
    }

    public abstract int energiaMaxima();

    public boolean puedeUsarHechizo(Hechicero hechicero, Hechizo hechizo) {
        return hechicero.getEnergiaActual() >= hechizo.energiaRequerida();
    }

    public abstract void subirRango(Hechicero hechicero);
}

final class Hechicero {
    private int energiaActual;
    private Rango rango;

    public Hechicero(int energiaActual, Rango rango) {
        this.energiaActual = energiaActual;
        this.rango = rango;
    }

    public int getEnergiaActual() {
        return energiaActual;
    }

    public void setEnergiaActual(int energiaActual) {
        this.energiaActual = energiaActual;
    }

    public Rango getRango() {
        return rango;
    }

    public int energiaMaxima() {
        return rango.energiaMaxima();
    }

    public boolean puedeUsarHechizo(Hechizo hechizo) {
        return rango.puedeUsarHechizo(this, hechizo);
    }

    public void subirRango() {
        rango.subirRango(this);
    }

    public void modificarRango(Rango nuevoRango) {
        this.rango = nuevoRango;
    }
}

final class Aprendiz extends Rango {
    public static final Aprendiz INSTANCIA = new Aprendiz();

    private Aprendiz() {
        super(50);
    }

    @Override
    public int energiaMaxima() {
        return getEnergiaBase();
    }

    @Override
    public boolean puedeUsarHechizo(
            Hechicero hechicero, Hechizo hechizo) {
        return super.puedeUsarHechizo(hechicero, hechizo)
                && hechizo.energiaRequerida() < 40;
    }

    @Override
    public void subirRango(Hechicero hechicero) {
        hechicero.modificarRango(new Archimagos(1));
    }
}

final class Archimagos extends Rango {
    private int nivel;

    public Archimagos(int nivel) {
        super(100);
        this.nivel = nivel;
    }

    public int getNivel() {
        return nivel;
    }

    public void setNivel(int nivel) {
        this.nivel = nivel;
    }

    @Override
    public int energiaMaxima() {
        return getEnergiaBase() + 2 * nivel;
    }

    @Override
    public boolean puedeUsarHechizo(Hechicero hechicero, Hechizo hechizo) {
        return super.puedeUsarHechizo(hechicero, hechizo) && !hechizo.esProhibido();
    }

    @Override
    public void subirRango(Hechicero hechicero) {
        try {
            if (nivel < 0) { throw new NivelNegativo(); }

            if (nivel < 10) { nivel++; } 
            else { hechicero.modificarRango(Supremo.INSTANCIA); }
        } catch (NivelNegativo e) {
            System.err.println(e.getMessage());
        }
    }
}

final class NivelNegativo extends RuntimeException {
    public NivelNegativo() {
        super("El nivel de Archimagos no puede ser negativo.");
    }
}

final class Supremo extends Rango {
    public static final Supremo INSTANCIA = new Supremo();

    private Supremo() {
        super(500);
    }

    @Override
    public int energiaMaxima() {
        return getEnergiaBase();
    }

    @Override
    public boolean puedeUsarHechizo(
            Hechicero hechicero, Hechizo hechizo) {
        return true;
    }

    @Override
    public void subirRango(Hechicero hechicero) {
        // El rango supremo no tiene un rango superior.
    }
}


final class Hechizo {
    private int energia;
    private boolean prohibido;

    public Hechizo(int energia, boolean prohibido) {
        this.energia = energia;
        this.prohibido = prohibido;
    }

    public int getEnergia() {
        return energia;
    }

    public void setEnergia(int energia) {
        this.energia = energia;
    }

    public boolean isProhibido() {
        return prohibido;
    }

    public void setProhibido(boolean prohibido) {
        this.prohibido = prohibido;
    }

    public int energiaRequerida() {
        return energia;
    }

    public boolean esProhibido() {
        return prohibido;
    }
}

public class Main {
    public static void main(String[] args) {
        Hechicero hechicero =
                new Hechicero(45, Aprendiz.INSTANCIA);

        Hechizo hechizo = new Hechizo(30, false);

        System.out.println("Energía máxima: "
                + hechicero.energiaMaxima());

        System.out.println("¿Puede usar el hechizo? "
                + hechicero.puedeUsarHechizo(hechizo));

        hechicero.subirRango();

        System.out.println("Nuevo rango: "
                + hechicero.getRango().getClass().getSimpleName());

        System.out.println("Nueva energía máxima: "
                + hechicero.energiaMaxima());
    }
}
