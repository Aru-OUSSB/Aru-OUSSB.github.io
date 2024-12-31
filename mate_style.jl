const HTML_TEMPLATE = """<!DOCTYPE html>
<html lang="ja">
<head>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto+Condensed:wght@700&display=swap" rel="stylesheet">

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>レートランキング{{TIMESTAMP}}</title>
    <style>
        @media (max-width:600px){
            .flex-box0 {
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                align-items: center;
                padding: 0px;
                background-color: white;
                font-family: "fantasy";
                font-size: 5vw;
                font-weight: bolder;
            }
            .flex-box1 {
                position: relative;
                width: 95vw;
                height: 19vw;
                background: repeating-linear-gradient(
                135deg,
                black,
                black 5px, 
                #222222 2px, 
                #222222 7px 
                );
                background-color: black;
                border: 0px solid #ccc;
                font-weight: 700;
                margin-bottom: 3px;
            }
            .rank{
                background: linear-gradient(rgba(161, 134, 62, 0.8), rgba(202, 168, 70, 0.8), rgba(161, 134, 62, 0.8)) ; 
                position: absolute;
                justify-content: center; 
                background-color: #967D36;
                clip-path: polygon(0 100%, 0 0%, 100% 0%,  13.5vw 100%); 
                width: 16.7vw; 
                height: 6vw;
            }
            .rank_num{
                font-family: "Roboto", sans-serif;
                position: absolute;
                display: flex;
                justify-content: center; 
                align-items: center;
                vertical-align: middle;
                color: white;
                padding: 0px;
                margin: 0px;
                text-align: center;
                width: 13.5vw; 
                height: 6vw;
                font-weight: 700;
                font-size: 3.5vw;
            }
            .player-photo {
                position: absolute;
                height: 8.86vw;
                bottom: 0.7vw;
                left: 0.7vw;
            }
            .name{
                display:flex;
                align-items: center;
                position: absolute;
                color: white;
                font-size: 3.7vw;
                height: 8.86vw;
                bottom: 0.7vw;
                width: 40vw;
                vertical-align: middle;
                left: 13vw;
                
            }
            .fighter0{
                background-color: black;
                position: absolute;
                height: 9.6vw;
                width: 47vw;
                bottom: 0px;
                right: 0px;
                clip-path: polygon(0 100%, 5.8vw 0%, 100% 0%,  100% 100%);
            }
            .fighter{
                position: absolute;
                display: flex;
                height: 9.6vw;
                bottom: 0px;
                right: 0px
            }
            .rate0{
                font-family: "Roboto Condensed", sans-serif;
                display: flex;
                position: absolute;
                color:white;
                font-size: 3.4vw;
                line-height: 3.4vw;
                right: 27vw;
                bottom: 11.9vw;
                padding: 0px;
                margin: 0px;
            }
            .rate{ 
                background: linear-gradient(rgba(161, 134, 62, 0.8), rgba(202, 168, 70, 0.8), rgba(161, 134, 62, 0.8)) text; 
                -webkit-text-fill-color: transparent; 
                color: rgb(161, 134, 62); 
                font-family: "Roboto Condensed", sans-serif;
                position: absolute;
                font-weight: 700;
                font-size: 5.7vw;
                height: 5.7vw;
                right: 2vw;
                bottom: 12vw;
                letter-spacing: -0.05em;
            }
        }
        @media (min-width:601px){
            .flex-box0 {
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                align-items: center;
                padding: 0px;
                background-color: white;
                font-family: "fantasy";
                font-size: 3vw;
                font-weight: bolder;
            }
            .flex-box1 {
                position: relative;
                width: 95vw;
                height: 9vw;
                background: repeating-linear-gradient(
                135deg,
                black,
                black 5px,
                #222222 2px,
                #222222 7px
                );
                background-color: black;
                border: 0px solid #ccc;
                font-weight: bold;
                margin-bottom: 3px;
            }
            .rank{
                background: linear-gradient(rgba(161, 134, 62, 0.8), rgba(202, 168, 70, 0.8), rgba(161, 134, 62, 0.8)) ; 
                position: absolute;
                justify-content: center; 
                background-color: #967D36;
                clip-path: polygon(0 100%, 0 0%, 100% 0%, 7vw  100%);
                width: 12vw; 
                height: 100%;
            }
            .rank_num{
                font-family: "Roboto", sans-serif;
                position: absolute;
                display: flex;
                justify-content: center; 
                align-items: center;
                vertical-align: middle;
                color: white;
                padding: 0px;
                margin: 0px;
                text-align: center;
                width: 9vw;
                height: 100%;
                font-weight: bold;
                font-size: 3vw;
            }
            .player-photo {
                position: absolute;
                height: 7vw;
                bottom: 0.5vw;
                left: 6.5vw;
            }
            .name{
                display:flex;
                align-items: center;
                position: absolute;
                color: white;
                font-size: 2.5vw;
                height: 9vw;
                bottom: 0px;
                width: 28vw;
                vertical-align: middle;
                left: 22vw;
            }
            .fighter0{
                background-color: black;
                position: absolute;
                height: 9vw;
                width: 50vw;
                bottom: 0px;
                right: 0px;
                clip-path: polygon(0 100%, 50px 0%, 100% 0%,  100% 100%);
            }
            .fighter{
                position: absolute;
                display: flex;
                height: 9vw;
                bottom: 0px;
                right: 0px
            }
            .rate0{
                font-family: "Roboto Condensed", sans-serif;
                display: flex;
                position: absolute;
                color:white;
                font-size: 1.8vw;
                line-height: 1.8vw;
                right: 24vw;
                bottom: 4.3vw;
                padding: 0px;
                margin: 0px;
            }
            .rate{ 
                background: linear-gradient(rgba(161, 134, 62, 0.8), rgba(202, 168, 70, 0.8), rgba(161, 134, 62, 0.8)) text; 
                -webkit-text-fill-color: transparent; 
                color: rgb(161, 134, 62); 
                font-family: "Roboto Condensed", sans-serif;
                position: absolute;
                font-weight: 700;
                font-size: 5.5vw;
                height: 5.5vw;
                right: 24vw;
                bottom: 0px;
                letter-spacing: -0.05em;
            }
        }
        @media (min-width:1000px){
            .flex-box0 {
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                align-items: center;
                padding: 0px;
                background-color: white;
                font-family: "fantasy";
                font-size: 30px;
                font-weight: bolder;
            }
            .flex-box1 {
                position: relative;
                width: 950px;
                height: 90px;
                background: repeating-linear-gradient(
                135deg,
                black,
                black 5px,
                #222222 2px,
                #222222 7px
                );
                background-color: black;
                border: 0px solid #ccc;
                font-weight: bold;
                margin-bottom: 3px;
            }
            .rank{
                background: linear-gradient(rgba(161, 134, 62, 0.8), rgba(202, 168, 70, 0.8), rgba(161, 134, 62, 0.8)) ; 
                position: absolute;
                justify-content: center; 
                background-color: #967D36;
                clip-path: polygon(0 100%, 0 0%, 100% 0%, 70px  100%);
                width: 120px; 
                height: 100%;
            }
            .rank_num{
                font-family: "Roboto", sans-serif;
                position: absolute;
                display: flex;
                justify-content: center; 
                align-items: center;
                vertical-align: middle;
                color: white;
                padding: 0px;
                margin: 0px;
                text-align: center;
                width: 90px;
                height: 100%;
                font-weight: bold;
                font-size: 30px;
            }
            .player-photo {
                position: absolute;
                height: 70px;
                bottom: 5px;
                left: 65px;
            }
            .name{
                display:flex;
                align-items: center;
                position: absolute;
                color: white;
                font-size: 25px;
                height: 90px;
                bottom: 0px;
                width: 280px;
                vertical-align: middle;
                left: 220px;
            }
            .fighter0{
                background-color: black;
                position: absolute;
                height: 90px;
                width: 500px;
                bottom: 0px;
                right: 0px;
                clip-path: polygon(0 100%, 50px 0%, 100% 0%,  100% 100%);
            }
            .fighter{
                position: absolute;
                display: flex;
                height: 90px;
                bottom: 0px;
                right: 0px
            }
            .rate0{
                font-family: "Roboto Condensed", sans-serif;
                display: flex;
                position: absolute;
                color:white;
                font-size: 18px;
                line-height: 18px;
                right: 240px;
                bottom: 43px;
                padding: 0px;
                margin: 0px;
            }
            .rate{ 
                background: linear-gradient(rgba(161, 134, 62, 0.8), rgba(202, 168, 70, 0.8), rgba(161, 134, 62, 0.8)) text; 
                -webkit-text-fill-color: transparent; 
                color: rgb(161, 134, 62); 
                font-family: "Roboto Condensed", sans-serif;
                position: absolute;
                font-weight: 700;
                font-size: 55px;
                height: 55px;
                right: 240px;
                bottom: 0px;
                letter-spacing: -0.05em;
            }
        }        
    </style>
</head>

<body>
    <div id="flexDisplay" class="flex-box0">
        OUSSB RATE RANKING
        """