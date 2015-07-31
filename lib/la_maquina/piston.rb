module LaMaquina
  class Piston

    def self.fire!(klass = "", id = nil)
      throw "A piston has to implement 'fire!'"
    end

  end
end

# in solicitor
class SunspotPiston < LaMaquina::Piston
  def self.fire!(klass = "", id = nil)
    indexed_class.find(id).index!
  end

  # of course, we would have a dependency map here
  private

  def self.indexed_class(klass)
    {"professional" => Professional}[klass] or raise "can't index class #{klass}!"
  end

end