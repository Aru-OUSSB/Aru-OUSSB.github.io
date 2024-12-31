using HTTP
using Dates

include("mate.jl")

# ランキングテーブルを生成する関数
function generate_ranking_table()
    try
        df = get_current_ranking()
        
        rows = String[]
        
        for i in 1:N
            row = (img_url=df.url[i], name=df.Name[i], current_rate=df.Now[i], max_rate=df.Max[i], Log = df.Log[i], ID = df.ID[i])
            
            player_html = """
        <div class="flex-box1">
            <div class="rank"></div>
            <div class="rank_num">$i</div>
            <div class="player-photo">
                <img src="$(row.img_url)" class="player-photo" alt="$(row.name)">
            </div>
            <div class="name">$(row.name)</div>
            <div class="fighter0"></div>
            <div class="fighter"><img src = "https://raw.githubusercontent.com/Aru-OUSSB/Aru-OUSSB.github.io/refs/heads/main/Figs/$(row.ID).avif" ></div>
            <div class="rate0">RATE</div>
            <div class="rate">$(row.current_rate) / $(row.max_rate)</div>
        </div>
            """
            push!(rows, player_html)
        end
        
        table = HTML_TEMPLATE * join(rows) * """
    </div>
</body>
</html>"""
        
        # rank2 = [df.Max[i]*10000 + df.Now[i] + 1/df.ID[i] for i in 1:N]
        # junban2 = sortperm(rank2, rev=true)
        # df2 = (ID=df.ID[junban2], Name = df.Name[junban2], url = df.url[junban2], Now = df.Now[junban2], Max = df.Max[junban2], Log = df.Log[junban2])
        
        return table
    catch e
        @error "Error generating ranking table" exception=(e, catch_backtrace())
        return "<p>ランキングの読み込み中にエラーが発生しました。</p>"
    end
end

# HTMLファイルを生成して保存
function generate_and_save_html()
    try
        html = generate_ranking_table()
        current_time = Dates.format(now(), "yyyy_mm_dd_HH:MM")
        html = replace(html, "{{TIMESTAMP}}" => "作成日時: $(current_time)")
        # HTMLファイルを保存
        output_path = "./index.html"
        open(output_path, "w") do io
            write(io, html)
        end
        println("index.html が正常に生成されました。")
        
        Gitコマンドを実行してGitHubにプッシュ
        run(`git add index.html`)
        run(`git commit -m "Update ranking: $(current_time)"`)
        run(`git push origin main`)

        println("GitHubへのアップロードが完了しました。")
    catch e
        @error "Error generating HTML file" exception=(e, catch_backtrace())
        rethrow(e)
    end
end

# HTMLファイルを生成
generate_and_save_html()
