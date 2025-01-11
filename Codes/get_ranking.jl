function get_current_ranking()
    user_name = Vector{String}(undef,N)
    user_image_url = Vector{String}(undef,N)
    rate_now = Vector{Int}(undef,N)
    rate_max = Vector{Int}(undef,N)
    rate_log = Vector{String}(undef,N)

    for i in 1:N
        try
            ID2df(i,user_name,user_image_url,rate_now,rate_max,rate_log)
            sleep(2)  # 2秒待機
        catch e
            @error "Error fetching data for ID $(ID[i])" exception=(e, catch_backtrace())
            user_name[i] = "Unknown"
            user_image_url[i] = ""
            rate_now[i] = 1000
            rate_max[i] = 1000
            rate_log[i] = "0勝 0敗"
        end
    end

    junban = [rate_now[i]*10000 + rate_max[i] + 1/ID[i] for i in 1:N]

    rank = sortperm(junban, rev=true)

    df = (ID=ID[rank], Name = user_name[rank], url = user_image_url[rank], Now = rate_now[rank], Max = rate_max[rank], Log = rate_log[rank])        
    
    return df
end
