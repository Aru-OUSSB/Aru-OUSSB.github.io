

run(`git add Codes`)
run(`git add Figs`)
run(`git add index.html`)
run(`git add README.md`)
run(`git add start_auto_update.bat`)
run(`git add .github`)
run(`git add setting.bat`)

try
    run(`git commit -m "setting"`)
catch
end
# run(`git pull -f https://github.com/Aru-OUSSB/Aru-OUSSB.github.io.git main:main`)

include("./install_pkg.jl")

include("./generate_static_html.jl")
include("./get_ranking.jl")
include("./ID.jl")
include("./html_style.jl")
include("./read_web_data.jl")

const N = length(ID)

function run_update()
    while true
        generate_and_save_html()
        current_time = Dates.format(now(), "HH:MM")
        println("$(current_time): ランキングを更新しました")
            
        # 10分待機
        sleep(600)
    end
end

# メインの実行
println("自動更新を開始します...")
run_update()
