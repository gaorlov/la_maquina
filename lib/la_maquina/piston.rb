module LaMaquina
  class Piston

    def self.fire!(klass = "", id = nil)
      throw "A piston has to implement 'fire!'"
    end

  end
end
