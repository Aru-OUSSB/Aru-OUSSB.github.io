using Dates

function run_update()
    while true
        # generate_static_html.jlを実行
        run(`julia generate_static_html.jl`)
            
        current_time = Dates.format(now(), "HH:MM")
        println("$(current_time): ランキングを更新しました")
            
        # 10分待機
        sleep(600)
    end
end

# メインの実行
println("自動更新を開始します...")
run_update()
