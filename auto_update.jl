using Dates

include("./mate_ID.jl")
f = open("./mate_ID.jl")
lines = readlines(f)
close(f)

run(`git pull -f https://github.com/Aru-OUSSB/Aru-OUSSB.github.io.git main:main`)
sleep(1)

f = open("./mate_ID.jl")
lines2 = readlines(f)
close(f)
if lines != lines2
    f = open("./mate_ID.jl","w")
    for line in lines
        println(f,line)
    end
    close(f)
    run(`git add mate_ID.jl`)
    run(`git commit -m "change_ID"`)
    run(`git push origin main`)
end

function run_update()
    while true
        # generate_static_html.jlを実行
        include("generate_static_html.jl")
            
        current_time = Dates.format(now(), "HH:MM")
        println("$(current_time): ランキングを更新しました")
            
        # 10分待機
        sleep(600)
    end
end

# メインの実行
println("自動更新を開始します...")
run_update()
