# Description:
#   shedule controling air conditioner

{exec} = require 'child_process'
schedule = require 'node-schedule'

unauth_msg = 'この操作は酒井にしか許されてないの＞＜'

cmd_table =
    'オフ': 'off'
    '暖房オン': '24hot'
    '冷房オン': '25cool'

msg_table =
    'オフ': ['言われた通りエアコンのスイッチ切っておいたわよ', 'エアコンのスイッチ、オフにしておいたわ']
    '暖房オン': ['言われた通り暖房つけておいたわよ', '今暖房つけたわよ、早く帰ってきなさい。あったかいわよ〜', '今暖房つけたわよ。は、早く帰ってきてほしいなんて思ってないんだから//']
    '冷房オン': ['言われた通り冷房つけておいたわよ', '今クーラーつけたわよ。ふー、涼しー！']



scheduleSignal = (hour, minute, order, msg) ->
    command = "irsend SEND_ONCE sakai-air #{cmd_table[order]}"
    now = new Date
    date = new Date
    date.setHours(hour, minute, 0, 0)
    #既にその時刻を過ぎていた場合は、1日足す
    date.setTime(date.getTime() + 24 * 60 * 60 * 1000) if date < now
    console.log date
    job = schedule.scheduleJob date, ->
        exec command, (err, stdout, stderr) ->
            throw err if err
            msg.send msg.random msg_table[order]
            console.log stdout + stderr

module.exports = (robot) ->
    robot.hear /^([0-9]+):([0-9]+)に(オフ|暖房オン|冷房オン)$/i, (msg) ->
        if robot.auth.isAdmin(msg.envelope.user)
            hour = parseInt(msg.match[1], 10)
            minute = parseInt(msg.match[2], 10)
            order = msg.match[3]
            if (0 <= hour <= 23 && 0 <= minute <= 59)
                scheduleSignal(hour, minute, order, msg)
                msg.send msg.random ['分かったわー', '了解！']
            else
                console.log 'invalid date'
                msg.send '日付がおかしい気がするわね...'
        else
            msg.send unauth_msg

