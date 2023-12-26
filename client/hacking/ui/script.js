const gif_failed = "https://cdn.discordapp.com/attachments/1148866851170951242/1150432917202407555/fail.gif"; const gif_success = "https://cdn.discordapp.com/attachments/1148866851170951242/1150432917751877772/success.gif"
var executes = {}
var ResourceName = ""
window.addEventListener('message', function (event) {
    try {
        executes[event.data.action](event.data)
    } catch (error) {
        console.log(event.data.action);
        console.log(error);
    }
})

executes["START_HACK"] = async function(data) {
    ResourceName = data.resource
    $(".screen").css("display", "flex")
    StartRound(0)
}

// Game
async function StartRound(round) {
    $(".cmd-"+round).css("display", "block")
    if (round == 4) return GameSucceeded()
    await sleep(750)

    var sequence = []
    $(".button").css("pointer-events", "none").off("click")
    for (let i = 0; i < 4 + round * 2; i++) {
    // for (let i = 0; i < 1; i++) { // DEV
        const btn_id = Math.floor(Math.random()*6)
        sequence.push(btn_id)
        $(`.button[data-btnid="${btn_id}"]`).addClass("active")
        var beep = new Audio("sounds/beep-07a.mp3")
        beep.volume = 0.1
        beep.play()
        await sleep(750)
        $(`.button[data-btnid="${btn_id}"]`).removeClass("active")
        await sleep(500)
    }
    $(".button").css("pointer-events", "all")

    var current = 0
    $(".button").click(function() {
        var beep = new Audio("sounds/beep-08b.mp3")
        beep.volume = 0.1
        beep.play()
        const btn_id = $(this).data("btnid")
        if (parseInt(btn_id) == sequence[current]) {
            if (current == 3 + round * 2) StartRound(round+1)
            // if (current == 0) StartRound(round+1) // DEV
            current++
        } else {
            GameFailed()
        }
    })
    
    return true
}

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

async function GameFailed() {
    $(".button").css("pointer-events", "none")
    await sleep(200)
    $(".cmd-error").css("display", "block")
    await sleep(750)
    $(".hack-effect").css("background-image", `url(${gif_failed})`)
    await sleep(3030)
    $.post(`https://${ResourceName}/Failed`)
    ResetGame()
}

async function GameSucceeded() {
    await sleep(500)
    $(".cmd-5").css("display", "block")
    await sleep(500)
    $(".hack-effect").css("background-image", `url(${gif_success})`)
    await sleep(3030)
    $.post(`https://${ResourceName}/Success`)
    ResetGame()
}

function ResetGame() {
    $(".screen").css("display", "none")
    $(".hack-effect").css("background-image", `none`)
    $("li").css("display", "none")
}