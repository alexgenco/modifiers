require 'modifiers/define_modifier'

module Modifiers
  define_modifier(:deprecated) do |method|
    caller[3] =~ /(.*?):(\d+).*?$/i
    klass = self.kind_of? Module
    target = klass ? "#{self}." : "#{self.class}#"
    location = [$1, $2].join(":")
    warning = "deprecated method #{target}#{method.name} called from #{location}"
    warn warning
    method.invoke
  end
end
