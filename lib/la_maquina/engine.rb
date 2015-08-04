module LaMaquina
  class Engine

    class << self
      protected

      attr_accessor :pistons
    end
    self.pistons = []

    class << self 

      def notify!( notified_class, id, notifier_class = "" )
        pistons.each do |piston|
          begin
            # We can't thread this because Rails executes this code before the commit somehow. 
            # What. yeah. I don't know either.
            
            # Thread.new{
            piston.fire! notified_class, id, notifier_class
            # }.join
          rescue => e
            LaMaquina.error_notifier.notify(  e,
                                              misfiring_piston: piston,
                                              notified_class: notified_class,
                                              notified_id: id,
                                              notifier_class: notifier_class )
          end
        end
      end

      def install(*attrs)
        attrs.each do |piston|
          self.pistons << piston
        end
      end
    end
  end
end
