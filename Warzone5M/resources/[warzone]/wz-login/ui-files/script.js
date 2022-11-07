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

            case "GetProfile":
                $("#ConnectOnline").css("display", "none");
                $("#UpdateOnline").css("display", "none");
                $("#GetProfileOnline").css("display", "flex");
            break;

            case "BanScreen":
                $("#GetProfileOnline").css("display", "none");
                $("#bannedError").css("display", "flex");
                banReason();
            break;
        };
    });
});

$(document).on("click",".quitButton",function(){
    $.post("http://wz-login/quitButton");
});

const banReason = () => {
    $.post("http://wz-login/infoBan",JSON.stringify({}),(data) => {
        $(".bannedText").html(`<sub>${(data["banReason"])}</sub>`);    
    });
}