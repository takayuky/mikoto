# Description:
#   control air conditioner

{exec} = require 'child_process'

module.exports = (robot) ->
    robot.hear /オフ/i, (msg) ->
        exec "touch off", (err, stdout, stderr) ->
            throw err if err
            console.log stdout + stderr
        msg.send msg.random [
            'エアコンのスイッチ切っといたわよ！べ、別にあんたのためじゃないんだからね！',
            'ほら、エアコン切っておいたわよ。家出る前にちゃんと確認しなさいよね！',
        ]

    robot.hear /暖房オン/i, (msg) ->
        exec "touch danbo", (err, stdout, stderr) ->
            throw err if err
            console.log stdout + stderr
        msg.send msg.random [
            'あんたが風邪引かないように、暖房入れておいたわ。感謝しなさい！',
            '早く帰ってきなさい、暖房入れて待ってるから...//',
        ]

    robot.hear /冷房オン/i, (msg) ->
        exec "touch reibo", (err, stdout, stderr) ->
            throw err if err
            console.log stdout + stderr
        msg.send msg.random [
            '今日もあっついわねー、ほら、冷房かけといたわよ。',
            'クーラーかけとくわ。帰ってきたら一緒にアイスでも食べましょ！',
        ]

