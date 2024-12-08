using HTTP
using Dates

include("mate.jl")

# HTMLテンプレートを web_server.jl から取得
const HTML_TEMPLATE = """
<!DOCTYPE html>
<html>
<head>
    <title>Mate Rate Ranking</title>
    <meta charset="UTF-8">
    <style>
        body {
            margin: 0;
            padding: 20px;
            background-color: #f0f0f0;
            font-family: Arial, sans-serif;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            position: relative;
        }
        .header {
            margin-bottom: 20px;
            text-align: center;
        }
        .title {
            margin: 0;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f8f9fa;
            font-weight: bold;
        }
        .player-info {
            display: flex;
            align-items: center;
            gap: 10px;
            justify-content: flex-start;
        }
        .player-photo {
            width: 40px;
            height: 40px;
        }
        .timestamp {
            position: absolute;
            bottom: 10px;
            right: 20px;
            font-size: 0.8em;
            color: #666;
        }
            
        .Now_screen.no {
            display: none;
        }
        .Max_screen.no {
            display: none;
        }

    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1 class="title">レートランキング</h1>
        </div>
        {{RANKING_TABLE}}
        <div class="timestamp">{{TIMESTAMP}}</div>
    </div>
<script>
    const buttonNow = document.getElementById('Now_btn')
    const buttonMax = document.getElementById('Max_btn')
    const screenNow = document.querySelector('.Now_screen')
    const screenMax = document.querySelector('.Max_screen')
    buttonNow.addEventListener('click',function(){
        screenNow.classList.remove('no');
        screenMax.classList.add('no');
    })
    buttonMax.addEventListener('click',function(){
        screenNow.classList.add('no');
        screenMax.classList.remove('no');
    })
</script>
</body>
</html>
"""

# ランキングテーブルを生成する関数
function generate_ranking_table()
    try
        df = get_current_ranking()
        
        rows = String[]
        push!(rows, """
            <tr>
                <th>順位</th>
                <th>プレイヤー</th>
                <th>現在レート</th>
                <th class="buttonMax" id="Max_btn">最高レート</th>
                <th>対戦成績</th>
            </tr>
        """)
        
        for i in 1:N
            row = (img_url=df.url[i], name=df.Name[i], current_rate=df.Now[i], max_rate=df.Max[i], Log = df.Log[i])
            
            player_html = """
                <tr>
                    <td>$(i)</td>
                    <td>
                        <div class="player-info">
                            <img src="$(row.img_url)" class="player-photo" alt="$(row.name)">
                            $(row.name)
                        </div>
                    </td>
                    <td>
                        $(round(Int, row.current_rate))
                    </td>
                    <td>
                        $(round(Int, row.max_rate))
                    </td>
                    <td>$(row.Log)</td>
                </tr>
            """
            push!(rows, player_html)
        end
        
        table1 = "<table class=\"Now_screen\">" * join(rows) * "</table>"
        
        rank2 = [df.Max[i]*10000 + df.Now[i] + 1/df.ID[i] for i in 1:N]
        junban2 = sortperm(rank2, rev=true)
        df2 = (ID=df.ID[junban2], Name = df.Name[junban2], url = df.url[junban2], Now = df.Now[junban2], Max = df.Max[junban2], Log = df.Log[junban2])
        
        rows2 = String[]
        push!(rows2, """
            <tr>
                <th>順位</th>
                <th>プレイヤー</th>
                <th class="buttonNow" id="Now_btn">現在レート</th>
                <th>最高レート</th>
                <th>対戦成績</th>
            </tr>
        """)
        
        for i in 1:N
            row = (img_url=df2.url[i], name=df2.Name[i], current_rate=df2.Now[i], max_rate=df2.Max[i], Log = df2.Log[i])
            
            player_html = """
                <tr>
                    <td>$(i)</td>
                    <td>
                        <div class="player-info">
                            <img src="$(row.img_url)" class="player-photo" alt="$(row.name)">
                            $(row.name)
                        </div>
                    </td>
                    <td>
                        $(round(Int, row.current_rate))
                    </td>
                    <td>
                        $(round(Int, row.max_rate))
                    </td>
                    <td>$(row.Log)</td>
                </tr>
            """
            push!(rows2, player_html)
        end
        
        table2 = "<table class=\"Max_screen no\">" * join(rows2) * "</table>"
        
        return table1 * table2
    catch e
        @error "Error generating ranking table" exception=(e, catch_backtrace())
        return "<p>ランキングの読み込み中にエラーが発生しました。</p>"
    end
end

# HTMLファイルを生成して保存
function generate_and_save_html()
    try
        ranking_table = generate_ranking_table()
        current_time = Dates.format(now(), "mm/dd HH:MM")
        html = replace(HTML_TEMPLATE, "{{RANKING_TABLE}}" => ranking_table)
        html = replace(html, "{{TIMESTAMP}}" => "作成日時: $(current_time)")
        
        # HTMLファイルを保存
        output_path = "./index.html"
        open(output_path, "w") do io
            write(io, html)
        end
        println("index.html が正常に生成されました。")
        
        # Gitコマンドを実行してGitHubにプッシュ
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
