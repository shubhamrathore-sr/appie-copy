var show = "hide";

function showMenu() {

    if (show == "hide") {
        document.getElementById("menuBar").style = "display:flex"
        $("#menuBar").addClass("show")
        show = "show";
    } else {
        document.getElementById("menuBar").style = "display:none"
        show = "hide";
    }
}