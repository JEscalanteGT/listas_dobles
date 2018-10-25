require 'byebug'
require 'terminal-table'

def vacia?(lista)
  lista[:tope].nil? && lista[:fondo].nil?
end

def obtener_posicion(lista, carnet)
  i = 0
  aux = lista[:tope]
  loop do
    if aux[:valor][:carnet] == carnet || aux[:siguiente].nil?
      break
    end
    i += 1
    aux = aux[:siguiente]
  end

  return i
end

def obtener_nodo(lista, posicion)
  nodo = {}
  i = 0
  aux = lista[:tope]
  loop do
    if i == posicion
      nodo = aux
      return nodo
    end
    if aux[:siguiente] == nil
      break
    end
    i += 1
    aux = aux[:siguiente]
  end
  return nodo
end

def mostrar(lista)
  aux = lista[:tope]
  if vacia?(lista)
    puts 'La lista esta vacía'
  else
    tabla = Terminal::Table.new do |t|
      t.headings = ['Valor', 'Posicion', 'Siguiente']

      aux = lista[:tope]
      loop do
        siguiente = aux[:siguiente]
        estudiante = aux[:valor]
        t.add_row([
          "#{estudiante[:carnet]} - #{estudiante[:nombre]}",
          obtener_posicion(lista, estudiante[:carnet]),
          siguiente == nil ? 'NIL' : siguiente[:valor][:carnet]
        ])
        if aux[:siguiente] == nil
          break
        end
        aux = aux[:siguiente]
      end
      t.add_row(:separator)
      t.add_row([
        { value: 'Total', colspan: 2, alignment: :right },
        lista[:size]
      ])
    end
    puts tabla
  end
end

estudiantes = [
  { nombre: 'Donald', carnet: '1538017' },
  { nombre: 'Leysi', carnet: '1542218' },
  { nombre: 'José', carnet: '1567417' },
  { nombre: 'Diana', carnet: '1515617' },
  { nombre: 'Kelvin', carnet: '1662318' }
]

lista = {
  tope: nil,
  fondo: nil,
  size: 0
}
