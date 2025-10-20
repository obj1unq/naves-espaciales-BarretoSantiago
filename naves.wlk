class Nave {
	var property velocidad = 0
	method recibirAmenaza(){

	}
	method propulsar(){
		velocidad += 20000
		if (velocidad >300000){
			velocidad = 300000
		}
	}
	method prepararViaje(){
		velocidad += 15000
		if(velocidad > 300000){
			velocidad = 300000
		}
	}

}

class NaveDeCarga inherits Nave {
	var property carga = 0

	method sobrecargada() = carga > 100000

	method excedidaDeVelocidad() = velocidad > 100000

	override method recibirAmenaza() {
		carga = 0
	}

}

class NaveDePasajeros inherits Nave {
	var property alarma = false
	const cantidadDePasajeros = 0

	method tripulacion() = cantidadDePasajeros + 4

	method velocidadMaximaLegal() = 300000 / self.tripulacion() - if (cantidadDePasajeros > 100) 200 else 0

	method estaEnPeligro() = velocidad > self.velocidadMaximaLegal() or alarma

	override method recibirAmenaza() {
		alarma = true
	}

}

class NaveDeCombate inherits Nave {
	var property modo = reposo
	const property mensajesEmitidos = []

	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}
	
	method ultimoMensaje() = mensajesEmitidos.last()

	method estaInvisible() = velocidad < 10000 and modo.invisible()

	override method recibirAmenaza() {
		modo.recibirAmenaza(self)
	}
	override method prepararViaje(){
		self.setearVelocidadViaje()
		
		modo = ataque		
	}

	method setearVelocidadViaje(){
		velocidad += 15000
		if(velocidad > 300000){
			velocidad = 300000
		}
	}

}

object reposo {

	method invisible() = false

	method recibirAmenaza(nave) {
		nave.emitirMensaje("¡RETIRADA!")
	}
	method prepararViaje(nave) {
	  nave.emitirMensaje("volviendo a la base")
	}	

}

object ataque {

	method invisible() = true

	method recibirAmenaza(nave) {
		nave.emitirMensaje("Enemigo encontrado")
	}
	method prepararViaje(nave){
		
	}
}

class NaveResiduosRadioactivos inherits NaveDeCarga {
	var estaSellado = false
	method sellarAlVacio(){
		estaSellado = true
	}
	
	override method recibirAmenaza(){
		velocidad = 0
	}
	override method prepararViaje(){
		self.setearVelocidadViaje()
		self.sellarAlVacio()
	}
	method setearVelocidadViaje(){
		velocidad += 15000
		if(velocidad > 300000){
			velocidad = 300000
		}
	}
	
}