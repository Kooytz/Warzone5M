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

            case "noAccountScreen":
                $("#GetProfileOnline").css("display", "none");
                $("#noAccountError").css("display", "flex");
                noAccountMessage();
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

const noAccountMessage = () => {
    $(".noAccountText").html(`<sub>Primeiro login detectado. Clique no botão abaixo para registrar-se.
    <br>
    <br>
    Qualquer usuário que for encontrado usando apelido agressivo, ofensivo, derrogatória ou culturalmente carregado estará sujeito a ter sua conta permanentemente banida.
    <br>
    <br>
    Para mais informações, acesse https://discord.gg/colocar-link-do-discord.</sub>`);    
}