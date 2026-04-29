// ============================================== TRANSPORTE ===============================================
object camion {
  const property cosas = #{}
  const tara = 1000
		
  method cargar(unaCosa) {
	  if (not self.elArticuloEstaCargado(unaCosa)){
	  	cosas.add(unaCosa)
	  } else{
	  	self.error("No se puede cargar: "+ unaCosa +" porque ya está cargado.")
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

  method pesoTotal() {
    return tara + (cosas.map({c => c.peso()}).sum())
  }

  method estaExcedido() {
    return self.pesoTotal() > 2500
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
    //return self.estaExcedido() && self.hayCosaPeligrosa(peligrosidad)
    return not self.estaExcedido() && self.cosasPeligrosas(peligrosidad).isEmpty()
  }

  method tieneAlgoQuePeseEntre(minimo, maximo) {
    return cosas.any({c => c.peso() >= minimo && c.peso() <= maximo})
  }

  method cosaMasPesada() {
    return if (cosas.isEmpty()){
      self.error("El camión no cuenta con algo pesado :(")
    } else{
        cosas.max({c => c.peso()})
      }
  }

  method listadoDePesos() {
    return cosas.map({c => c.peso()})
  }

  method totalBultos() {

    return (cosas.map({c => c.totalBultos()})).sum()
  }

  method accidente() {
    cosas.forEach({c => c.sufreAccidente()})
  }

  method transportar(destino, camino) {
    if (camino.puedeCircular(self)){
      destino.almacenarCosas(cosas)
    } else{
      self.error("El camino no puede soportar el Viaje :(")
    }
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

  method totalBultos() {
    return 1
  }

  method sufreAccidente() {
    // nada
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

  method totalBultos() {
    return 1
  }

  method sufreAccidente() {
    peso = peso + 20
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

  method totalBultos() {
    return 2
  }

  method sufreAccidente() {
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

  method totalBultos() {   // usa 1 bulto hasta 100 ladrillos, 2 bultos si son de 101 a 300 ladrillos, 3 bultos si son 301 o más ladrillos.

    return if (cantidadDeLadrillos <= 100){
      1
    } else if (cantidadDeLadrillos >= 101 && cantidadDeLadrillos <= 300){
      2
    } else {   // cantidadDeLadrillos >= 301
      3
    }
  }

  method sufreAccidente() {
    if (cantidadDeLadrillos >= 12){
      cantidadDeLadrillos = 12 - cantidadDeLadrillos
    } else{
      cantidadDeLadrillos = 0
    }
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

  method totalBultos() {
    return if (not tieneMisiles){
      1
    } else{
      2
    }
  }

  method sufreAccidente() {
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

  method totalBultos() {
    return 1
  }

  method sufreAccidente() {
    peso = peso + 15
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

  method totalBultos() {
    return 1 + cosas.map({c => c.totalBultos()}).sum()
  }

  method sufreAccidente() {
    cosas.forEach({c => c.sufreAccidente()})
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

  method totalBultos() {
    return 2
  }

  method sufreAccidente() {
    // nada
  }
}

// ========================== ALMACEN =========================
object almacen {
  const almacen = #{}

  method almacenarCosas(cosas) {
    almacen.add(cosas)
  }
}

// ==================== RUTAS / CAMINOS =====================
object ruta9 {
  method puedeCircular(vehiculo) {
    return vehiculo.puedeCircularEnRuta(20)
  }
}

object caminosVecinales {
  var pesoPermitido = 0


  method puedeCircular(vehiculo) {
    return vehiculo.pesoTotal() <= pesoPermitido
  }

  method pesoPermitido(peso) {
    pesoPermitido = peso
  }
}