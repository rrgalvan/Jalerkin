# This file has been obtained fom the Gridap library
# https://github.com/gridap/Gridap.jl (c) [Santiago
# Badia](mailto:santiago.badia@monash.edu) and [Francesc
# Verdugo](mailto:fverdugo@cimne.upc.edu)

"""
    @abstractmethod

Macro used in generic functions that must be overloaded by derived types.
"""
macro abstractmethod()
  quote
    error("This function belongs to an interface definition and cannot be used.")
  end
end

"""
    @notimplemented
    @notimplemented "Error message"

Macro used to raise an error, when something is not implemented.
"""
macro notimplemented(message="This function is not yet implemented")
  quote
    error($(esc(message)))
  end
end

"""
    @notimplementedif condition
    @notimplementedif condition "Error message"

Macro used to raise an error if the `condition` is true
"""
macro notimplementedif(condition,message="This function is not yet implemented")
  quote
    if $(esc(condition))
      @notimplemented $(esc(message))
    end
  end
end

"""
    @unreachable
    @unreachable "Error message"

Macro used to make sure that a line of code is never reached.
"""
macro unreachable(message="This line of code cannot be reached")
  quote
    error($(esc(message)))
  end
end
