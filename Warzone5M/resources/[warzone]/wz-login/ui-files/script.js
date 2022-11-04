$(document).ready(() => {
    window.addEventListener("message", function (event) {
        switch(event["data"]["action"]){
            case "GetProfile":
                $("#GetProfileOnline").css("display", "flex");
            break;
        };
    });
});