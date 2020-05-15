module Dispersions

export gen_kGrid
  
"""
    gen_kGrid(Nk, D[; min = 0, max = π, include_min=true])


Generates an Iterator for the Cartesian product of k vectors. 
This can be collected to reduce into a `Nk` times `Nk` array, containing
tuples of length `D`.

# Examples
```
julia> gen_kGrid(2, 2; min = 0, max = 2π, include_min = false)
Base.Iterators.ProductIterator{Tuple{Array{Float64,1},Array{Float64,1}}}(([3.141592653589793, 6.283185307179586], [3.141592653589793, 6.283185307179586]))
```
"""
function gen_kGrid(Nk::Int64, D::Int64; min = 0, max = π, include_min=true)
    kx::Array{Float64} = [((max-min)/(Nk - Int(include_min))) * 
                          j + min for j in (1:Nk) .- Int(include_min)]
    indArr = Base.product([1:(Nk) for Di in 1:D]...)
    kGrid  = Base.product([kx for Di in 1:D]...)
    return indArr, kGrid
end

end # module