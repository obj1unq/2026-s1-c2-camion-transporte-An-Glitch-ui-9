// ============================================== TRANSPORTE ===============================================
object camion {
  const property cosas = #{}
		
  method cargar(unaCosa) {
 	cosas.add(unaCosa)
  }

  method descargar(unaCosa) {
   cosas.remove(unaCosa)
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

  method peso(unPeso) {
	peso = unPeso
  }

  method nivelPeligrosidad() {
	return 1
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