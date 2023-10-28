class Paciente{
    const property edad
    var nivelDolor
    var fortalezaMuscular
    const ordenRutina = []

    method nivelDolor() = nivelDolor
    
    method fortalezaMuscular() = fortalezaMuscular

    method usarAparato(unAparato){
        if(not self.puedeUsarAparato(unAparato)){
            throw new Exception(message="El paciente no puede usar este aparato")
        }
        nivelDolor = 0.max(nivelDolor - unAparato.modificarNivelDolor(self)) 
        fortalezaMuscular += unAparato.modificarFortalezaMuscular(self)
        unAparato.desgastarMaquina(self) 
    }

    method puedeUsarAparato(unAparato) = unAparato.puedeSerUsado(self)

    method hacerRutina(){
        if(not self.puedeHacerRutina()){
            throw new Exception(message="El paciente no puede usar uno o varios aparatos de su rutina")
        }
        ordenRutina.forEach({aparato => self.usarAparato(aparato)})
    }

    method puedeHacerRutina() = ordenRutina.all({aparato => self.puedeUsarAparato(aparato)})

    method agregarAparatoARutina(unAparato){
        ordenRutina.add(unAparato)
    }

    method sacarAparatoDeRutina(unAparato){
        ordenRutina.remove(unAparato)
    }
}

class Resistente inherits Paciente{
    override method usarAparato(unAparato){
        super(unAparato)
        fortalezaMuscular += 1
    }
}

class Caprichoso inherits Paciente{
    override method puedeHacerRutina() = super() and self.hayAparatoRojo()

    method hayAparatoRojo() = ordenRutina.any({aparato => aparato.color() == 'rojo'})

    override method hacerRutina(){
        super()
        super()
    }
}

class RapidaRecuperacion inherits Paciente{
    override method hacerRutina(){
        super()
        nivelDolor = 0.max(nivelDolor - valorRecuperacionRapida.valor())
    }
}

object valorRecuperacionRapida{
    var property valor = 3
}

class Centro{
    const aparatos = []
    const pacientes = []

    method agregarAparato(unAparato){
        aparatos.add(unAparato)
    }

    method sacarAparato(unAparato){
        aparatos.remove(unAparato)
    }

    method agregarPAciente(unPaciente){
        pacientes.add(unPaciente)
    }

    method sacarPaciente(unPaciente){
        pacientes.remove(unPaciente)
    }

    method coloresDeAparatos() = aparatos.map({aparato => aparato.color()}).asSet()

    method pacientesMenoresDe(unaEdad) = pacientes.filter({paciente => paciente.edad() < unaEdad})

    method pacientesQueNoPuedenHacerRutina() = pacientes.filter({paciente => not paciente.puedeHacerRutina()})

    method cantidadPacientesQueNoPuedenHacerRutina() = self.pacientesQueNoPuedenHacerRutina().size()

    method estaEnOptimasCondiciones() = aparatos.all({aparato => not aparato.necesitaMantenimiento()})

    method aparatosNecesitanMantenimiento() = aparatos.filter({aparato => aparato.necesitaMantenimiento()})

    method cantidadAparatosNecesitanMantenimiento () = self.aparatosNecesitanMantenimiento().size()

    method estaComplicado() = self.cantidadAparatosNecesitanMantenimiento() >= (aparatos.size()/2)

    method visitaDeTecnico(){
        aparatos.forEach({aparato => aparato.hacerMantenimiento()})
    }
}