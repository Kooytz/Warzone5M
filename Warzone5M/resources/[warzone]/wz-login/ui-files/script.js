$(document).ready(() => {
    window.addEventListener("message", function (event) {
        switch(event["data"]["action"]){

            case "Connect":
                $("#ConnectOnline").css("display", "flex");
            break;

            case "Update":
                $("#ConnectOnline").css("display", "none");
                $("#UpdateOnline").css("display", "flex");
            break;
        };
    });
});