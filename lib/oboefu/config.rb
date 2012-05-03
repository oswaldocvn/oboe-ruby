# Copyright (c) 2012 by Tracelytics, Inc.
# All rights reserved.

module Oboe
  # The following is done for compatability with older versions of oboe and
  # oboe_fu (0.2.x)
  if not defined?(Config)
    Config = {
        :tracing_mode => "through",
        :sampling_rate => 3e5
    }
  end

  class << Config 
    def passthrough?
      ["always", "through"].include? self[:tracing_mode].to_s
    end
  
    def always?
      Oboe::Config[:tracing_mode].to_s == "always"
    end
  
    def never?
      Oboe::Config[:tracing_mode].to_s == "never"
    end
  
    def tracing?
      Oboe::Context.isValid and not Oboe.never?
    end
  
    def start?
      not Oboe::Context.isValid and Oboe.always?
    end

    def sample?
      # Note that this the only point in the code that currently does and
      # should ever read the sampling rate. When autopilot is released, modify
      # the line below and that line only.
      Oboe::Config[:sampling_rate].to_i < rand(1e6) end end end
