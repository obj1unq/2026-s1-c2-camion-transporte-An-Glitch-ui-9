// ============================================== TRANSPORTE ===============================================
object camion {
  const property cosas = #{}
  const tara = 1000
		
  method cargar(unaCosa) {
	  if (self.elArticuloEstaCargado(unaCosa)){
	  	cosas.add(unaCosa)
	  } else{
	  	self.error("No se puede cargar: "+ unaCosa + " porque ya está cargado.")
	  }	
  }
    //No se puede cargar algo ya cargado ni descargar lo que no contiene el camión.  
  method descargar(unaCosa) {
   if (self.elArticuloEstaCargado(unaCosa)) {
	    cosas.remove(unaCosa)
   } else {
	    self.error("No se puede descargar: " + unaCosa)
   }
  }

  method elArticuloEstaCargado(articulo) {
	  return cosas.any({a => a == articulo})
  }

  method carga() {
	  return cosas
  }

  method todoElPesoEsPar() {
    return ((cosas.map({c => c.peso()}).sum()) % 2) == 0
  }

  method hayAlgoQuePese(kilos) {
    return cosas.any({c => (c.peso() == kilos)})
  }

  method estaExcedido() {
    return (tara + (cosas.map({c => c.peso()}).sum())) > 2500
  }

  method cosaPeligrosa(peligrosidad) {
    return if (self.hayCosaPeligrosa(peligrosidad)){
      cosas.find({c => c.nivelPeligrosidad() == peligrosidad})
    } else{
      self.error("El camión no cuenta con un artículo peligroso :) ")
    }
  }

  method hayCosaPeligrosa(peligrosidad) {
    return cosas.any({c => c.nivelPeligrosidad() == peligrosidad})
  }

  method cosasPeligrosas(peligrosidad) {
    return cosas.filter({c => c.nivelPeligrosidad() > peligrosidad})
  }

  method cosasMasPeligrosaQue(cosa) {
    return self.cosasPeligrosas(cosa.nivelPeligrosidad())
  }

  method puedeCircularEnRuta(peligrosidad) {
    return self.estaExcedido() && self.hayCosaPeligrosa(peligrosidad)
  }
}
// ========================================= COSAS ==========================================
object knightRider {
  method peso() { 
	  return 500 
  }

  method nivelPeligrosidad() { 
	  return 10 
  }
}

object arenaAGranel {
  var peso = 0

  method pesoArena(unPeso) {
	  peso = unPeso
  }

  method nivelPeligrosidad() {
	  return 1
  }

  method peso() {
    return peso
  }
}

object bumblebee {
	var estaTransformado = false


  method peso() {
	  return 800
  }

  method nivelPeligrosidad() {
	  return if (estaTransformado) {
		  15
	  } else {
		  30
	  }
  }

  method transformacion() {
	  estaTransformado = not estaTransformado
  }
}

object paqueteDeLadrillos {
  var cantidadDeLadrillos = 0


  method peso() {
	  return 2
  }

  method nivelPeligrosidad() {
	  return 2
  }

  method cantidadDeLadrillos(cantidad) {
	  cantidadDeLadrillos = cantidad
  }

  method ladrillos() {
	  return cantidadDeLadrillos
  }
}

object bateriaAntiaerea {
  var tieneMisiles = false


  method peso() {
	  return if (tieneMisiles) {
		  300
	  } else {
	  	200
	  }
  }

  method nivelPeligrosidad() {
	  return if (tieneMisiles){
	  	100
	  } else {
	  	0
	  }
  }

  method portaMisiles() {
	  tieneMisiles = not tieneMisiles
  }
}

object residuosRadioactivos {
  var peso = 0


  method pesoVariable(unPeso) {
	  peso = unPeso
  }

  method nivelPeligrosidad() {
	  return 200
  }

  method peso() {
	  return peso
  }
}

object contenedorPortuario {
  const cosas = #{}

  method peso() {
    return 100 + (cosas.map({c => c.peso()})).sum()
  }

  method nivelPeligrosidad() {
    return if (cosas.isEmpty()){
      0
    } else{
      self.nivelDeLaCosaMasPeligrosa()
    }
  }

  method nivelDeLaCosaMasPeligrosa() {
    return cosas.map({c => c.nivelPeligrosidad()}).max()
  }

  method carga(cosa) {
    cosas.add(cosa)
  }
}

object embalajeDeSeguridad {
  var cosaEnvuelta = null

  method envolverCosa(cosa) {
    cosaEnvuelta = cosa
  }

  method peso() {
    return cosaEnvuelta.peso()
  }

  method nivelPeligrosidad() {
    return cosaEnvuelta.nivelPeligrosidad() / 2
  }
}