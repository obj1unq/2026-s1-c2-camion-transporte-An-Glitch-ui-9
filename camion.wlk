// ============================================== TRANSPORTE ===============================================
object camion {
  const property cosas = #{}
  const tara = 1000
		
  method cargar(unaCosa) {
    self.validarCargar(unaCosa)
	  cosas.add(unaCosa)
  }	  

  method validarCargar(unaCosa) {
	  if (self.elArticuloEstaCargado(unaCosa)) {
      self.error("No se puede cargar: "+ unaCosa +" porque ya está cargado.")
    }
  }

  method descargar(unaCosa) {
    self.validarDescargar(unaCosa)
	  cosas.remove(unaCosa)
  }

  method validarDescargar(unaCosa) {
    if (not self.elArticuloEstaCargado(unaCosa)) {
      self.error("No se puede descargar: " + unaCosa + "porque no está cargado.")
    }
  }

  method elArticuloEstaCargado(articulo) {
	  //return cosas.any({a => a == articulo})
    return cosas.contains(articulo)
  }

  method carga() {
	  return cosas
  }

  method todoElPesoEsPar() {
    //return ((cosas.all({c => c.peso()}).sum()) % 2) == 0
    return cosas.all({c => c.peso() % 2 == 0})
  }

  method hayAlgoQuePese(kilos) {
    return cosas.any({c => (c.peso() == kilos)})
  }

  method pesoTotal() {
    //return tara + (cosas.map({c => c.peso()}).sum())
    return tara + (cosas.sum({c => c.peso()}))
  }

  method estaExcedido() {
    return self.pesoTotal() > 2500
  }

  method cosaPeligrosa(peligrosidad) {
    return //if (self.hayCosaPeligrosa(peligrosidad)){
      cosas.find({c => c.nivelPeligrosidad() == peligrosidad})
    //} else{
    //  self.error("El camión no cuenta con un artículo peligroso :) ")
    //}
  }

  //method hayCosaPeligrosa(peligrosidad) {
  //  return cosas.any({c => c.nivelPeligrosidad() == peligrosidad})
  //}

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
    //return cosas.any({c => c.peso() >= minimo && c.peso() <= maximo})
    return cosas.any({c => c.peso().between(minimo, maximo)})
  }

  method cosaMasPesada() {
    return cosas.max({c => c.peso()})
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
    self.puedeSoportar(camino)
    destino.almacenarCosas(cosas)
  }

  method puedeSoportar(camino) {
    if (camino.puedeCircular()){
      self.error("El camino no puede soportar el viaje.")
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
    cantidadDeLadrillos = (cantidadDeLadrillos - 12).max(0)
  }
}

object bateriaAntiaerea {
  var estado = descargado


  method peso() {
	  return if (estado.estaCargado()) {
		  300
	  } else {
	  	200
	  }
  }

  method nivelPeligrosidad() {
	  return if (estado.estaCargado()){
	  	100
	  } else {
	  	0
	  }
  }

  method portaMisiles() {
	  if (estado.estaCargado()){
      estado = descargado
    }else{
      estado = cargado
    }
  }

  method totalBultos() {
    return if (estado.estaDescargado()){
      1
    } else{
      2
    }
  }

  method sufreAccidente() {
   estado = descargado  
  }
}
// ===============
object cargado {
  method estaCargado() { 
    return true 
  }

  method estaDescargado() { 
    return false 
  }
}

object descargado {
  method estaCargado() { 
    return false 
  }

  method estaDescargado() { 
    return true
  }
}
// ===============


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