using Dates

include("./mate_ID.jl")
f = open("./mate_ID.jl")
lines = readlines(f)
close(f)

run(`git add auto_update.jl`)
run(`git add generate_static_html.jl`)
run(`git add mate_function.jl`)
run(`git add mate_ID.jl`)
run(`git add mate.jl`)
run(`git add README.md`)
run(`git add start_auto_update.bat`)
try
    run(`git commit -m "shokisettei"`)
catch
end
run(`git pull -f https://github.com/Aru-OUSSB/Aru-OUSSB.github.io.git main:main`)
sleep(5)

f = open("./mate_ID.jl")
lines2 = readlines(f)
close(f)
if lines != lines2
    f = open("./mate_ID.jl","w")
    for line in lines
        println(f,line)
    end
    close(f)
end

try
    run(`git add mate_ID.jl`)
    run(`git commit -m "change_ID_$(Dates.format(now(), "mm/dd"))"`)
    run(`git push origin main`)
catch
end

lines = Nothing
lines2 = Nothing

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
