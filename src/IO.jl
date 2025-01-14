function Base.show(io::IOT, gr::KGrid{T, D}) where {IOT <: IO, T<:KGridType, D}
    if get(io, :compact, true)
        print(io, "$T(t=$(gr.t)) grid in $D dimensions with ", Nk(gr), " k-points.")
    else
        print(io, "$T(t=$(gr.t)) grid in $D dimensions with ", Nk(gr), " k-points.\n
   === Public Fields ===
Nk    : total number of points
Ns    : number of points per dimension
kGrid : gridpoints
kInd  : indices
kMult : multiplicity per point
t     : hopping amplitude
ϵkGrid: dispersion")
    end
end

Base.show(io::IOT, ::MIME"text/plain", gr::KGrid{T, D}) where {IOT <: IO, T<:KGridType, D} = show(io, gr)

#TODO: macro to include lattice specific IO   
