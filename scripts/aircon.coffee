# Description:
#   control air conditioner

{exec} = require 'child_process'

unauth_msg = 'この操作は酒井にしか許されてないの＞＜'

module.exports = (robot) ->
    robot.hear /^オフ$/i, (msg) ->
        if robot.auth.isAdmin(msg.envelope.user)
            exec "touch off", (err, stdout, stderr) ->
                throw err if err
                console.log stdout + stderr
            msg.send msg.random [
                'エアコンのスイッチ切っといたわよ！べ、別にあんたのためじゃないんだからね！',
                'ほら、エアコン切っておいたわよ。家出る前にちゃんと確認しなさいよね！',
            ]
        else
            msg.send unauth_msg

    robot.hear /^暖房オン$/i, (msg) ->
        if robot.auth.isAdmin(msg.envelope.user)
            exec "touch danbo", (err, stdout, stderr) ->
                throw err if err
                console.log stdout + stderr
            msg.send msg.random [
                'あんたが風邪引かないように、暖房入れておいたわ。感謝しなさい！',
                '早く帰ってきなさい、暖房入れて待ってるから...//',
            ]
        else
            msg.send unauth_msg

    robot.hear /^冷房オン$/i, (msg) ->
        if robot.auth.isAdmin(msg.envelope.user)
            exec "touch reibo", (err, stdout, stderr) ->
                throw err if err
                console.log stdout + stderr
            msg.send msg.random [
                '今日もあっついわねー、ほら、冷房かけといたわよ。',
                'クーラーかけとくわ。帰ってきたら一緒にアイスでも食べましょ！',
            ]
        else
            msg.send unauth_msg

