try
    using Dates
    using HTTP
catch
    using Pkg
    Pkg.add("Dates")
    Pkg.add("HTTP")
end