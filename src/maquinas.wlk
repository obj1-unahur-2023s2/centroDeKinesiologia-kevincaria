class Maquina{
    var property color = "blanco"

    method modificarNivelDolor(unPaciente)

    method modificarFortalezaMuscular(unPaciente)

    method puedeSerUsado(unPaciente)

    method hacerMantenimiento()

    method desgastarMaquina(unPaciente)

    method necesitaMantenimiento()
}

class Magneto inherits Maquina{
    var puntosImantacion = 800

    override method modificarNivelDolor(unPaciente) = (unPaciente.nivelDolor()*0.1)
    
    override method modificarFortalezaMuscular(unPaciente) = 0

    override method puedeSerUsado(unPaciente) = true

    override method hacerMantenimiento(){
        if (self.necesitaMantenimiento()){
            puntosImantacion += 500
        }
    }

    override method desgastarMaquina(unPaciente){
        puntosImantacion = 0.max(puntosImantacion - 1)
    }

    override method necesitaMantenimiento() = puntosImantacion < 100
}

class Bicicleta inherits Maquina{
    var cantidadDesajusteTornillos = 0
    var cantidadPerdidaAceite = 0
    
    override method modificarNivelDolor(unPaciente)= 4

    override method modificarFortalezaMuscular(unPaciente) = 3     

    override method puedeSerUsado(unPaciente) = unPaciente.edad() > 8

    override method hacerMantenimiento(){
        if(self.necesitaMantenimiento()){
            cantidadDesajusteTornillos = 0
            cantidadPerdidaAceite = 0
        }
    }

    override method desgastarMaquina(unPaciente){
        if(unPaciente.nivelDolor() > 30){
            if(unPaciente.edad().between(30,50)){ //Se asume (por el enunciado, que en este punto nos dice "si además") que para tener en cuenta esta condicion, primero debemos tener un paciente con nivel de dolor mayor a 30
                cantidadPerdidaAceite += 1
            }
            cantidadDesajusteTornillos += 1
        }
    }

    override method necesitaMantenimiento() = cantidadDesajusteTornillos >= 10 and cantidadPerdidaAceite >= 5
}

class Minitramp inherits Maquina{
    override method modificarNivelDolor(unPaciente)= 0

    override method modificarFortalezaMuscular(unPaciente) = (unPaciente.edad()) * 0.1

    override method puedeSerUsado(unPaciente) = unPaciente.nivelDolor() < 20

    override method hacerMantenimiento(){}

    override method desgastarMaquina(unPaciente){}

    override method necesitaMantenimiento(){}
}