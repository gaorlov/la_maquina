class CleverCommObject
  def self.notify(params)
    LaMaquina::Engine.notify!(params[:notified_class], params[:notified_id], params[:notifier_class])
  end
end