class Standalone < ActiveRecord::Base
  include LaMaquina::Notifier

  notifies_about :self, using: ::ExplodingCommObject
end