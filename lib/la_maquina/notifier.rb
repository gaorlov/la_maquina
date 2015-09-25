module LaMaquina
  module Notifier
    extend ActiveSupport::Concern
    include ActiveRecord::Callbacks

    included do
      
      class << self
        attr_accessor :notified_objects
      end

      self.notified_objects = []

      
      class << self
        def notifies_about(target, opts = {})
          notified_objects << {:target => target, :options => opts}
        end
      end

      after_commit  :notify!
    end

    def notify!
      self.class.notified_objects.each do |notified|

        target  = notified[:target]
        options = notified[:options]

        comm_object = options[:using]

        klass = notified_class( target, options )
        ids   = notified_id( target, options )

        notifier_class = LaMaquina.format_object_name(self)

        begin
          ids.each do |id|
            if comm_object
              comm_object.notify(:notified_class => klass, :notified_id => id, :notifier_class => notifier_class)
            else
              LaMaquina::Engine.notify! klass, id, notifier_class
            end
          end
        rescue => e
          LaMaquina.error_notifier.notify(  e,
                                            notified_class: klass,
                                            notified_id: id,
                                            notifier_class: notifier_class,
                                            notifier_id: self.id)
        end
      end
    end

    private

    def notified_class(target, options)
      if target == :self
        return LaMaquina.format_object_name(self)
      end

      if options[:polymorphic]
        if self.respond_to? "#{target}_type"
          return LaMaquina.format_class_name(self.send("#{target}_type"))
        else
          return LaMaquina.format_class_name(self.send(target).class)
        end
      end
      
      if options[:class_name]
        return LaMaquina.format_class_name(options[:class_name])
      end
      
      if options[:class]
        return LaMaquina.format_class_name(options[:class])
      end
      
      return target.to_s.singularize
    end

    def notified_id(target, options)
      if target == :self
        return [self.id]
      end

      if options[:through]
        ids = []
        join_objects =  Array(self.send(options[:through]))
        
        join_objects.each do |obj|
          if obj.respond_to? "#{target}_id"
            ids << obj.send("#{target}_id")
          else
            ids << Array(obj.send(target)).map(&:id)
          end
        end

        return ids
      end

      if self.respond_to? "#{target}_id"
        Array self.send("#{target}_id")
      else
        Array(self.send(target)).map(&:id)
      end
    end
  end
end