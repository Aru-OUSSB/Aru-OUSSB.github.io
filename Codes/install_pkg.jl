# 必要なパッケージを宣言
try
    using Dates
    using HTTP
catch
    using Pkg
    Pkg.add("Dates")
    Pkg.add("HTTP")
    using Dates
    using HTTP
end